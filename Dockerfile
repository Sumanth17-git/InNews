# app/Dockerfile
FROM python:3.9-slim

WORKDIR /app

# Install system packages needed for newspaper3k and others
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    software-properties-common \
    git \
    libxml2-dev \
    libxslt1-dev \
    libjpeg-dev \
    zlib1g-dev \
    libffi-dev \
    libssl-dev \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements first for better caching
COPY requirements.txt .

# Install Python packages
RUN pip install --upgrade pip && pip install -r requirements.txt

# Copy your full app
COPY . .

# Expose Streamlit port
EXPOSE 8501

# Health check endpoint
HEALTHCHECK CMD curl --fail http://localhost:8501/_stcore/health || exit 1

# Set environment variables for Datadog APM
ENV DD_SERVICE=InNews \
    DD_ENV=staging \
    DD_LOGS_INJECTION=true \
    DD_TRACE_SAMPLE_RATE=1 \
    DD_PROFILING_ENABLED=true

# Run app with ddtrace-run wrapper
ENTRYPOINT ["ddtrace-run", "streamlit", "run", "App.py", "--server.port=8501", "--server.address=0.0.0.0"]
