#!/bin/bash

# Navigate to the SlackBot project directory
cd SlackBot

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

echo "Setup completed. Virtual environment is ready, and dependencies are installed."
