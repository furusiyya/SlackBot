Combining both versions of the README to include all information, the comprehensive README for your "SlackBot" project would look like this:

---

# SlackBot [Under Development]

SlackBot is an interactive chatbot for Slack designed to automate responses, send scheduled surveys, and facilitate better engagement within Slack channels. Built using Python, this bot leverages the Slack API, OpenAI's powerful GPT models for generating responses, and a Flask server to handle events and commands.

## Features

- **Automated Responses**: Dynamically responds to user messages in Slack channels.
- **Scheduled Surveys**: Sends pre-defined or dynamic survey questions to a specified channel at scheduled times.
- **Slash Command Support**: Processes slash commands from Slack to perform actions like sending surveys on demand.
- **Customizable**: Easy to extend and customize for various automated tasks within Slack.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

- Python 3.6+
- pip
- A Slack account and a Slack app created in your workspace
- ngrok for local development

### Setup Slack App

1. **Create Your Slack App**
   - Go to the [Slack API](https://api.slack.com/apps) page and click "Create New App".
   - Choose "From scratch", name your app, and select your Slack workspace.

2. **Bot Token**
   - Navigate to "OAuth & Permissions" page in your app settings.
   - Under "Scopes", add necessary bot token scopes (e.g., `chat:write`, `commands`).
   - Install the app to your workspace to generate a bot token (begins with `xoxb-`).

3. **Signing Secret**
   - Find the "App Credentials" section in the "Basic Information" page.
   - Copy the "Signing Secret".

4. **Enable Events**
   - Go to "Event Subscriptions" and enable events.
   - Enter the Request URL (you'll set this using ngrok).

5. **Slash Commands (Optional)**
   - In "Slash Commands", create any commands you want your bot to respond to.

### Installation

1. **Clone the repository**

```bash
git clone https://github.com/yourusername/SlackBot.git
cd SlackBot
```

2. **Configure environment variables**

Copy `.env.sample` to a new file named `.env` and update it with your actual configuration values.

```bash
cp .env.sample .env
```

3. **Signup on Nnrok and get auth token for local development**

Copy your auth token from ngrok account and add in `.env` file.


### Running the Bot

1. **Run setup file to install dependcies and setup environment**

```bash
chmod +x setup.sh
./setup.sh
```

2. **Setup Slack App to get your Bot Token and Secret**

Go to slack, create a slack app from scratch. Next go to app basic setting and copy bot token and secret to add in `.env` file. 

3. **Start the Flask server**

```bash
chmod +x run.sh
./run.sh
```
4. **Run ngrok local intance to enable to your Flask receive slack events.**

Run your ngrok instance.
```bash
chmod +x start_ngrok.sh
./start_ngrok.sh
```
Copy your https ngrok endpoint and add to slack under Event Subcription request URL of your Slack App. If it is verified. You are good to start using app.

5. **Slack Conversation Logs**
Tail bot_log.txt to view slack events, conversation logs. 

## Deployment

For deploying this bot in a production environment, consider using a cloud service provider like Heroku, AWS, or GCP. Ensure to securely manage your environment variables in the deployment environment.

## Contributing

Contributions are what make the open-source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

Distributed under the MIT License. See `LICENSE` for more information.

## Acknowledgments

- Slack API
- OpenAI API
- Python Slack SDK
- Flask
- ngrok for local development testing

## Contributors

* [Muhammad Saad Arif] (https://github.com/saadarif-14)
* [Muhammad Bilal Arif](https://github.com/furusiyya)
