import requests

def send_discord_message(webhook_url, message):
    data = {"content": message}
    requests.post(webhook_url, json=data)

webhook_url = "YOUR_DISCORD_WEBHOOK_URL"
message = ""
while True:
    line = input("Enter a line of text for the message (or press enter to send): ")
    if line == "":
        break
    message += line + "\n"
send_discord_message(webhook_url, message)
