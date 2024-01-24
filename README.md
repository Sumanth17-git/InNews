# InNews - Setup on Linux 
 
sudo yum update
sudo yum install git
git clone https://github.com/Sumanth17-git/InNews.git
python3 
yum install python3-pip
python3 -m pip
sudo yum remove python3-requests
cd InNews/
python3 -m pip install -r requirements.txt
python3 -m streamlit run App.py

if the application is not accessible from browser
Change the inbound rules of 8501 port in security groups.
