#!/bin/bash
# ================================================
# recon.sh - Basic Reconnaissance Tool
# Author: Ayman Ahmed
# Description: Ping check + Port scan + Web scan
# Usage: ./recon.sh <target-ip>
# ================================================

TARGET=$1

# Check if user provided a target
if [ -z "$TARGET" ]; then
    echo "Usage: ./recon.sh <target-ip>"
    exit 1
fi

# Check if host is alive before scanning
function ping_check() {
    ping -c 1 -W 1 $TARGET > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo "[+] Host is UP"
    else
        echo "[-] Host is DOWN"
        exit 1
    fi
}

# Scan open ports and detect service versions
function port_scan() {
    echo "[*] Scanning ports..."
    nmap -sV $TARGET
}

# Scan web services and find hidden directories
function web_scan() {
    echo "[*] Web Scanning..."
    nmap --script=http-title,http-enum,banner -sV -p 80,443,8080 $TARGET
}

# MAIN - Run all functions
echo "============================="
echo "  RECON TOOL - $TARGET"
echo "============================="
ping_check
port_scan
web_scan
