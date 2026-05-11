#!/bin/bash
# ================================================
# pingsweep.sh - Network Ping Sweep Tool
# Author: Ayman Ahmed
# Description: Scan entire subnet for live hosts
# Usage: ./pingsweep.sh
# ================================================
echo "Scanning 192.168.184.0/24..."
for i in {1..254}; do
    {
        ping -c 1 -W 1 192.168.184.$i > /dev/null 2>&1
        if [ $? -eq 0 ]; then
            echo "192.168.184.$i is UP"
        fi
    } &
done
wait
echo "Scan Complete!"
