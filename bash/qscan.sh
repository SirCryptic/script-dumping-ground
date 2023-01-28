#!/bin/bash
echo "Advanced Scanner"
echo "Written By: NullSecurityTeam"
echo "Enter target IP or hostname:"
read target

# Perform initial nmap scan to find open ports and services
nmap $target -p- --open -oG nmap-results.txt

# Extract open ports and save to a file
cat nmap-results.txt | grep "/open" | cut -d " " -f 2 > open-ports.txt

# Check for weak SSH ciphers
echo "Checking for weak SSH ciphers..."
for port in $(cat open-ports.txt); do
    ssh-enum-algos -p $port $target >> ssh-ciphers.txt
done

# Perform vulnerability scan using nikto
echo "Running nikto vulnerability scanner..."
nikto -h $target > nikto-results.txt

# Perform vulnerability scan using OpenVAS
echo "Running OpenVAS vulnerability scanner..."
openvas-scan -f xml -o openvas-results.txt $target

# Save all results to a single file
cat nmap-results.txt open-ports.txt ssh-ciphers.txt nikto-results.txt openvas-results.txt > all-results.txt

echo "Scan complete. Results saved to all-results.txt"
