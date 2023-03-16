#!/bin/bash
# Developer/s: Mobly, Double A, SirCryptic @ (NullSecurityTeam)
# Info:        Admin Control Panel Finder [Beta] - By NullSecurityTeam
# Note/s:      A Bash Based Admin Control Panel finder using random user agents for domains and IP's (PLEASE NOTE THIS IS BETA AND HAS BEEN SINCE 2018)
# Updates:     Recently been revised by myself @ SirCryptic ~ NST // 2023 to include color support and read control panel possibilities from a text file rather than stored as array also to use random user agents & use command history / support for proper keyboard input.

# Set up color variables / history & keybind suppport etc
HISTFILE="$HOME/.bash_history"
history -a "$HISTFILE"

if [[ $- == *i* ]]; then
    bind '"\e[A": history-search-backward'
    bind '"\e[B": history-search-forward'
    bind '"\e[C": forward-char'
    bind '"\e[D": backward-char'
fi
history -r
history -a
history -w

black=`tput setaf 0`
red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 3`
blue=`tput setaf 4`
magenta=`tput setaf 5`
cyan=`tput setaf 6`
white=`tput setaf 7`
reset=`tput sgr0`

# banner & title
title="Admin Control Panel Finder [BETA]"
echo -e '\033]2;'$title'\007'
banner="
${cyan}  ___  _____ ______${magenta}______ 
${cyan} / _ \/  __ \| ___ \ ${magenta} ___|
${cyan}/ /_\ \ /  \/| |_/ /${magenta} |_   
${cyan}|  _  | |    |  __/${magenta}|  _|  
${cyan}| | | | \__/\| |   ${magenta}| |    
${cyan}\_| |_/\____/\_|   ${magenta}\_|    
${cyan}Admin Control Panel ${magenta}Finder ${yellow}[BETA]
${magenta}Developed By ${cyan}NullSecurityTeam${reset}
${magenta}Revised By ${cyan}SirCryptic@NullSecurityTeam${reset}
"
# Define the URL prefix
url_prefix="http://"

# Read the user agents from the file
user_agents=$(cat user_agents.txt)
# Clear the cli
clear

echo -e "${banner}"

# Prompt the user for the domain name
read -e -p "Enter the domain name to check: " domain  && echo "$domain" >> ~/.bash_history 2>/dev/null

# Read the possible URLs from the file
found_admin_panel=false
urls_checked=0
while read url_suffix; do
  # Construct the full URL
  url="$url_prefix$domain$url_suffix"

  # Pick a random user agent
  user_agent=$(echo "$user_agents" | shuf -n 1)

  # Send a HEAD request and save the response headers
  headers=$(curl -I --silent --user-agent "$user_agent" "$url")

  # Extract the status code from the headers
  status=$(echo "$headers" | grep -oP "^HTTP/\d\.\d \K\d{3}")

  # Check if the status code is in the 200-299 range
  # Display the URL and the response body
  if [[ "$status" =~ ^2[0-9]{2}$ ]]; then
    echo "${cyan}URL:${reset} $url"
    echo "${magenta}User agent:${reset} $user_agent"
    echo "${yellow}Response body:${reset}"
    curl --silent --user-agent "$user_agent" "$url"
    echo "-----------------------------------------"
  elif [[ "$status" == "301" ]]; then
    echo "${cyan}URL:${reset} $url"
    echo "${magenta}User agent:${reset} $user_agent"
    echo "${yellow}Status code:${reset} $status Moved Permanently"
    echo ""
    echo "-----------------------------------------"
  elif [[ "$status" == "400" ]]; then
    echo "${cyan}URL:${reset} $url"
    echo "${magenta}User agent:${reset} $user_agent"
    echo "${yellow}Status code:${reset} $status Bad request"
    echo ""
    echo "-----------------------------------------"
  elif [[ "$status" == "401" ]]; then
    echo "${cyan}URL:${reset} $url"
    echo "${magenta}User agent:${reset} $user_agent"
    echo "${yellow}Status code:${reset} $status Not Found"
    echo ""
    echo "-----------------------------------------"
  elif [[ "$status" == "403" ]]; then
    echo "${cyan}URL:${reset} $url"
    echo "${magenta}User agent:${reset} $user_agent"
    echo "${yellow}Status code:${reset} $status Requested resource is forbidden"
    echo ""
    echo "-----------------------------------------"
  elif [[ "$status" == "404" ]]; then
    echo "${cyan}URL:${reset} $url"
    echo "${magenta}User agent:${reset} $user_agent"
    echo "${yellow}Status code:${reset} $status Page not found or File not found"
    echo ""
    echo "-----------------------------------------"
  elif [[ "$status" == "405" ]]; then
    echo "${cyan}URL:${reset} $url"
    echo "${magenta}User agent:${reset} $user_agent"
    echo "${yellow}Status code:${reset} $status Method Not Allowed"
    echo ""
    echo "-----------------------------------------"
  elif [[ "$status" == "503" ]]; then
    echo "${cyan}URL:${reset} $url"
    echo "${magenta}User agent:${reset} $user_agent"
    echo "${yellow}Status code:${reset} $status Service Unavailable"
    echo ""
    echo "-----------------------------------------"
  elif [[ "$status" == "200" ]]; then
    echo "${cyan}URL:${reset} $url"
    echo "${magenta}User agent:${reset} $user_agent"
    echo "${green}Status code:${reset} $status"
    echo "${green}Admin panel found at:${reset} $url"
    echo ""
    echo "-----------------------------------------"
    break
  else
    # Display the URL and the status code
    echo "${cyan}URL:${reset} $url"
    echo "${magenta}User agent:${reset} $user_agent"
    echo "${yellow}Status code:${reset} $status Unknown {Null}"
    echo ""
    echo "-----------------------------------------"
  fi
  urls_checked=$((urls_checked+1))
done < admin_urls.txt

# Check if an admin panel was found
if [[ "$found_admin_panel" == false ]]; then
  echo "${yellow}No results found after checking $urls_checked URLs.${reset}"
fi

# NullSecurityTeam

## Greetz to the world and gov sectors,

## We are a group of hacktivists who have played our parts in various government operations between 2018 - 2021 ✌️👨‍💻

## It has been a pleasure to meet and work anonymously among those in this industry. We hope to continue our work and make a positive impact in the world.

## Signed,
## ~ m0bly, double A, and SirCryptic ~ root@nst (2018)
## ~ SirCryptic (revised 2023) // Mobly = M.I.A / Double A = M.I.A - SCNS@127.0.0.1 over & out
