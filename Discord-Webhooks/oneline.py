import requests

def send_discord_message(webhook_url, message):
    data = {"content": message}
    requests.post(webhook_url, json=data)

webhook_url = "YOUR_DISCORD_WEBHOOK_URL"
message = input("Enter the message you want to send: ")
send_discord_message(webhook_url, message)
