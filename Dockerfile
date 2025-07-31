# app/Dockerfile
FROM python:3.9-slim
WORKDIR /app
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

# Clone template (optional if you're copying your app anyway)
RUN git clone https://github.com/streamlit/streamlit-example.git .
COPY requirements.txt .
COPY . .
RUN pip3 install -r requirements.txt
EXPOSE 8501
HEALTHCHECK CMD curl --fail http://localhost:8501/_stcore/health
ENTRYPOINT ["ddtrace-run","streamlit", "run", "App.py", "--server.port=8501", "--server.address=0.0.0.0"]

