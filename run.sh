#!/bin/bash

# Navigate to the project directory if not already there
cd "$(dirname "$0")"

# # Load the sample.env file and export its variables
# NGROK_AUTH_TOKEN=$(grep 'NGROK_AUTH_TOKEN' .env | cut -d '=' -f2 | xargs)

# # Check if NGROK_AUTH_TOKEN is set
# if [ -z "$NGROK_AUTH_TOKEN" ]; then
#     echo "Ngrok auth token not found in .env file."
#     exit 1
# else
#     echo "Authenticating ngrok with the token from .env file..."
#     ./ngrok authtoken $NGROK_AUTH_TOKEN
# fi


# Activate the virtual environment
echo "Activating the virtual environment..."
source venv/bin/activate

# Start the Flask app in the background and save its PID
echo "Starting the Flask app..."
python bot.py > bot_log.txt &
FLASK_PID=$!
echo "Flask PID: $FLASK_PID"

# Wait a bit for Flask to initialize
sleep 5


# Check if Flask app started successfully by checking if the process is running
if kill -0 $FLASK_PID 2>/dev/null; then
    echo "Flask app started successfully."

    # Authenticate ngrok and start it
    # echo "Authenticating ngrok..."
    # ./ngrok authtoken $NGROK_AUTH_TOKEN

    # echo "Starting ngrok..."
    # ./ngrok http 3000 > ngrok_log.txt &
    # NGROK_PID=$!
    # echo "NGROK PID: $NGROK_PID"

    # echo "Your Flask app and ngrok are now running."

    # # Wait a bit for Ngrok to initialize
    # sleep 5

else
    echo "Failed to start the Flask app. Please check for errors."
    # Clean up Flask background process if it's still running for some reason
    kill $FLASK_PID 2>/dev/null
fi

#  # Fetch the ngrok tunnel URL
# NGROK_URL=$(curl --silent --max-time 10 http://127.0.0.1:4040/api/tunnels | jq -r '.tunnels[] | select(.proto == "https") | .public_url')
# echo "NGROK URL"+$ngrok

# if [ -z "$NGROK_URL" ]; then
#     echo "Failed to retrieve ngrok tunnel URL. Is ngrok running?"
#     exit 1
# else
#     echo "Ngrok tunnel established at: $NGROK_URL"
#     echo "Update your Slack app's Request URL to: $NGROK_URL/slack/events"
# fi

# Function to handle cleanup
cleanup() {
    echo "Cleaning up before exiting..."
    # Kill Flask and Ngrok processes
    if [ ! -z "$FLASK_PID" ]; then
        kill $FLASK_PID 2>/dev/null
    fi
    # if [ ! -z "$NGROK_PID" ]; then
    #     kill $NGROK_PID 2>/dev/null
    # fi
    # Deactivate the virtual environment
    deactivate
    exit 0
}

# Trap the SIGINT signal (Ctrl+C)
trap 'cleanup' SIGINT


echo "Press [CTRL+C] to stop this app..."
wait