#!/usr/bin/env python
import cfscrape
import re

# Developer: SirCryptic (NullSecurityTeam)
# Info: Cloudfare Resolver 1.1 
# Create a scraper object
scraper = cfscrape.create_scraper()

# Enter target website
target = input("Enter target website: ")

# Send a GET request to the target URL with the user-agent of a browser
r = scraper.get(target, headers={'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.82 Safari/537.36'})

# Extract the true IP address from the response
ip_address = re.search(r'\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}', r.text).group()

print("True IP address: " + ip_address)
