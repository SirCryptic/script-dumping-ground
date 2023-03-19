#!/bin/bash

if [[ "$1" == "-i" ]]; then
    echo "Installing dependencies..."
    sudo apt-get install -y nmap nikto ssh-audit
    echo "Dependencies installed. Please run the script again without the -i argument."
    exit
fi
# Check for dependencies
command -v nmap >/dev/null 2>&1 || { echo >&2 "nmap is required but not installed. Aborting."; exit 1; }
command -v nikto >/dev/null 2>&1 || { echo >&2 "nikto is required but not installed. Aborting."; exit 1; }
command -v ssh-audit >/dev/null 2>&1 || { echo >&2 "ssh-audit is required but not installed. Aborting."; exit 1; }

# Set up history and keybinds
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

# Set up color variables
black=`tput setaf 0`
red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 3`
blue=`tput setaf 4`
magenta=`tput setaf 5`
cyan=`tput setaf 6`
white=`tput setaf 7`
reset=`tput sgr0`
title="AQS"
echo -e '\033]2;'$title'\007'
banner="
${yellow}Advanced QuickScan
By ${red}NullSecurityTeam ${reset}- ${green}SirCryptic${reset} - ${green}m0bly${reset} - ${green}Double A${reset}
 "
clear
echo -e "${banner}"
echo "Enter target IP or hostname:"
read -e target && echo "$target" >> ~/.bash_history 2>/dev/null

# Get current date and time
datetime=$(date '+%Y-%m-%d_%H-%M-%S')

# Perform initial nmap scan to find open ports and services
nmap $target -p- --open -oG nmap-results.txt

# Extract open ports and save to a file
cat nmap-results.txt | grep "/open/tcp//" | grep -oP '\d+(?=/open/tcp/)' > open-ports.txt

# Check for weak SSH ciphers
echo "${yellow}Checking for weak SSH ciphers...${reset}"
for port in $(cat open-ports.txt); do
    ssh -o PreferredAuthentications=publickey -o PasswordAuthentication=no -o ConnectTimeout=5 -o ConnectionAttempts=3 -o StrictHostKeyChecking=no -p $port $target -vvv < /dev/null 2>&1 | grep "cipher" | cut -d " " -f 2 >> ssh-ciphers.txt || echo "Failed to check SSH ciphers for port $port. Check your installation."
done

# Perform vulnerability scan using nikto
echo "${yellow}Running nikto vulnerability scanner...${reset}"
nikto -h $target > nikto-results.txt || echo "Failed to run nikto vulnerability scanner. Check your installation."

# Perform SSH audit
echo "${yellow}Running ssh-audit...${reset}"
ssh-audit $target >> ssh-audit.txt

# Save all results to a single file
echo "Saving results to file..."
echo "Host: $target" > all-results_${datetime}.txt
echo "--------nmap----------" >> all-results_${datetime}.txt
cat nmap-results.txt >> all-results_${datetime}.txt
echo "--------open-ports----------" >> all-results_${datetime}.txt
cat open-ports.txt >> all-results_${datetime}.txt
echo "--------ssh-ciphers----------" >> all-results_${datetime}.txt
cat ssh-ciphers.txt >> all-results_${datetime}.txt
echo "--------nikto----------" >> all-results_${datetime}.txt
cat nikto-results.txt >> all-results_${datetime}.txt
echo "--------ssh-audit----------" >> all-results_${datetime}.txt
cat ssh-audit.txt >> all-results_${datetime}.txt

# Remove old files
rm nmap-results.txt open-ports.txt ssh-ciphers.txt nikto-results.txt ssh-audit.txt

echo "Scan complete. Results saved to all-results_${datetime}.txt"

if [[ "$1" == "-d" ]]; then
  cat all-results_${datetime}.txt
  exit
fi
