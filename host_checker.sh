#!/bin/bash
# ================================
# host_checker.sh - Host Check & Scan
# Author: Ayman Ahmed
# Usage: ./host_checker.sh <IP>
# ================================

# 1. التحقق من وجود الـ argument
if [ -z "$1" ]; then
    echo "Usage: $0 <IP>"
    exit 1
fi

# تعيين الـ IP في متغير
TARGET_IP="$1"

echo "============================="
echo "  HOST CHECKER - $TARGET_IP"
echo "============================="
echo "[*] Checking host: $TARGET_IP ..."

# 2. ping check
if ping -c 1 -W 1 "$TARGET_IP" > /dev/null 2>&1; then
    echo "[+] Host is UP!"
    echo "[*] Starting nmap -sV scan on $TARGET_IP ..."
    echo "-----------------------------------------------"
    nmap -sV "$TARGET_IP"
else
    echo "[-] Host unreachable"
    exit 1
fi
