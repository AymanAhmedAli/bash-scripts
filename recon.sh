#!/bin/bash

TARGET=$1

function ping_check() {
    ping -c 1 -W 1 $TARGET > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo "[+] Host is UP"
    else
        echo "[-] Host is DOWN"
        exit 1
    fi
}

function port_scan() {
    echo "[*] Scanning ports..."
    nmap -sV $TARGET
}

# MAIN
echo "============================="
echo "  RECON TOOL - $TARGET"
echo "============================="
ping_check
port_scan
