#!/bin/bash
# ================================
# myfunctions.sh - Function Examples
# Author: Ayman Ahmed
# ================================

function say_hello() {
    echo "Hello, $1! Welcome to Linux."
}

function check_host() {
    ping -c 1 -W 1 $1 > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo "[+] $1 is UP"
    else
        echo "[-] $1 is DOWN"
    fi
}

say_hello "Ayman"
check_host "8.8.8.8"
check_host "192.168.1.1"
