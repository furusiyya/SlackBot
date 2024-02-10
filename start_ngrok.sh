#!/bin/bash

# Navigate to the project directory if not already there
cd "$(dirname "$0")"

# Load the sample.env file and export its variables
NGROK_AUTH_TOKEN=$(grep 'NGROK_AUTH_TOKEN' .env | cut -d '=' -f2 | xargs)

# Check if NGROK_AUTH_TOKEN is set
if [ -z "$NGROK_AUTH_TOKEN" ]; then
    echo "Ngrok auth token not found in .env file."
    exit 1
else
    echo "Authenticating ngrok with the token from .env file..."
    ./ngrok authtoken $NGROK_AUTH_TOKEN
fi

# Authenticate ngrok and start it
echo "Authenticating ngrok..."
./ngrok authtoken $NGROK_AUTH_TOKEN

echo "Starting ngrok..."
./ngrok http 3000 > ngrok_log.txt &
NGROK_PID=$!
echo "NGROK PID: $NGROK_PID"

echo "Your ngrok is now running."

# Wait a bit for Ngrok to initialize
sleep 5

 # Fetch the ngrok tunnel URL
NGROK_URL=$(curl --silent --max-time 10 http://127.0.0.1:4040/api/tunnels | jq -r '.tunnels[] | select(.proto == "https") | .public_url')
echo "NGROK URL"+$ngrok

if [ -z "$NGROK_URL" ]; then
    echo "Failed to retrieve ngrok tunnel URL. Is ngrok running?"
    exit 1
else
    echo "Ngrok tunnel established at: $NGROK_URL"
    echo "1. Now RUN your FLAST App \n 2. Update your Slack app's Request URL to: $NGROK_URL/slack/events"
fi

echo "Press [CTRL+C] to stop this app..."
wait