#!/bin/bash

# Update and install Python3 and pip
echo "Updating system and installing Python3 and pip..."
sudo apt update
sudo apt install python3 python3-pip python3-venv -y

# Create a virtual environment
echo "Creating a virtual environment..."
python3 -m venv venv

# Activate the virtual environment
echo "Activating the virtual environment..."
source venv/bin/activate

# Install dependencies from requirements.txt
echo "Installing dependencies from requirements.txt..."
pip install -r requirements.txt

# Downloading and installing ngrok
echo "Downloading ngrok..."
sudo apt install wget unzip
wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip

echo "Unzipping ngrok..."
unzip ngrok-stable-linux-amd64.zip

# JQ will be used to extract ngrok http tunner URL latter
sudo apt-get install jq

# Clean up the zip file
echo "Cleaning up..."
rm ngrok-stable-linux-amd64.zip

echo "Setup completed. Virtual environment is ready, dependencies are installed, and ngrok is set up."