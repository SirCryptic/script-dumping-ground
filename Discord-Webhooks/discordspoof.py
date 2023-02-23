import requests
import json

def send_discord_message(webhook_url, title, message, username, avatar_url):
    data = {
        "username": username,
        "avatar_url": avatar_url,
        "embeds": [{
            "title": title,
            "description": message
        }]
    }
    requests.post(webhook_url, json=data)

webhook_url = "YOUR_DISCORD_WEBHOOK_URL"
username = input("Enter the username for the message: ")
avatar_url = input("Enter the avatar URL for the message: ")
title = input("Enter the title of the message: ")
message = ""
while True:
    line = input("Enter a line of text for the message (or press enter to send): ")
    if line == "":
        break
    message += line + "\n"
send_discord_message(webhook_url, title, message, username, avatar_url)
