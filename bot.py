import json
import logging
import os
from flask import Flask, request, jsonify
from dotenv import load_dotenv, find_dotenv
import schedule
import threading
import time
from slack_sdk import WebClient
from slack_sdk.errors import SlackApiError
from slack_sdk.signature import SignatureVerifier
from slack_sdk.webhook import WebhookClient
from slackeventsapi import SlackEventAdapter

# Load environment variables
_ = load_dotenv(find_dotenv())

# Configurations
SLACK_TOKEN = os.getenv('SLACK_TOKEN')
SIGNING_SECRET = os.getenv('SLACK_SIGNING_SECRET')
OPENAI_API_KEY = os.getenv('OPENAI_API_KEY')
CHANNEL_ID = 'C06B1TGP06B'

# Slack Client and Signature Verifier
client = WebClient(token=SLACK_TOKEN)
verifier = SignatureVerifier(SIGNING_SECRET)
webhook_client = WebhookClient(url=os.getenv('SLACK_WEBHOOK_URL'))

# Flask app and Slack Event Adapter
app = Flask(__name__)
slack_event_adapter = SlackEventAdapter(SIGNING_SECRET, '/slack/events', app)

# Logging Configuration
logging.basicConfig(filename='bot_log.txt', level=logging.DEBUG, format='%(asctime)s:%(levelname)s:%(message)s')


@app.route('/slack/command', methods=['POST'])
def handle_command():
    """Handles slash commands or interactive messages from Slack."""
    if not verifier.is_valid_request(request.get_data(), request.headers):
        return jsonify({'error': 'Invalid signature'}), 403

    command_text = request.form.get('text', '').lower()
    if 'survey' in command_text:
        send_survey(CHANNEL_ID)
        return jsonify(response_type='in_channel', text="Survey has been sent!"), 200
    else:
        return jsonify(response_type='ephemeral', text="Sorry, I didn't understand that command."), 200



@slack_event_adapter.on("message")
def handle_message(event_data):
    """Processes incoming message events."""
    message = event_data['event']
    channel_id = message.get('channel')
    user_id = message.get('user')
    text = message.get('text')
    logging.info(f"Received message from {user_id} in {channel_id}: {text}")

    # Dynamic response based on user input
    if 'hello' in text.lower():
        send_message(channel_id, f"Hello there! How can I assist you today?")

def send_message(channel_id, text):
    """Sends a message to a specified Slack channel."""
    try:
        response = client.chat_postMessage(channel=channel_id, text=text)
        logging.info(f"Message sent to {channel_id}: {response['message']['text']}")
    except SlackApiError as e:
        logging.error(f"Error sending message: {e.response['error']}")

def survey_questions():
    """Returns a survey question."""
    return "How was your performance today? Respond with 'good', 'average', or 'poor'."

def send_survey(channel_id):
    """Sends a survey question to a specified Slack channel."""
    text = survey_questions()
    send_message(channel_id, text)

def schedule_send_survey():
    """Schedules the survey to be sent every minute."""
    schedule.every().second.do(send_survey, channel_id=CHANNEL_ID)
    while True:
        schedule.run_pending()
        time.sleep(1)

if __name__ == "__main__":
    # Start the scheduler thread to send the survey every minute
    threading.Thread(target=schedule_send_survey, daemon=True).start()
    
    # Start Flask server
    app.run(debug=True, port=3000)
