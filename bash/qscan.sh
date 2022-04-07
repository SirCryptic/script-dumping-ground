#! /bin/bash

echo Simple scanner.
echo Written By: NULLSec
echo Let us Begin:
echo usage eg: 127.0.0.1 / https://testsite.com
echo enter target:
read target

nmap $target --open -oG scan-results; cat scan-results | grep "/open" | cut -d " " -f 2 > exposed-services-ips

nikto -h $target
