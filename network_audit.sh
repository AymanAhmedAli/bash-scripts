#!/bin/bash

# =========================
# Variables
# =========================

subnet=$1
log_dir="logs"
log_file="$log_dir/audit.txt"

mkdir -p "$log_dir"

# =========================
# System Information
# =========================

function system_info() {

    hostname=$(hostname)
    user=$(whoami)
    os=$(. /etc/os-release && echo "$NAME $VERSION_ID")
    kernel=$(uname -r)

    ram_total=$(free -h | grep Mem: | awk '{print $2}')
    ram_used=$(free -h | grep Mem: | awk '{print $3}')

    disk=$(df -h / | tail -1 | awk '{print $5}')

    {
        echo "===== SYSTEM INFO ====="
        echo "Hostname: $hostname"
        echo "User: $user"
        echo "OS: $os"
        echo "Kernel: $kernel"
        echo "RAM Total: $ram_total"
        echo "RAM Used : $ram_used"
        echo "Disk Usage: $disk"
        echo
    } >> "$log_file"
}

# =========================
# Check Required Tools
# =========================

function check_tools() {

    nmap_status=$(command -v nmap)
    ping_status=$(command -v ping)
    curl_status=$(command -v curl)

    {
        echo "===== TOOL CHECK ====="

        if [ -n "$nmap_status" ]; then
            echo "nmap : INSTALLED"
        else
            echo "nmap : NOT FOUND"
        fi

        if [ -n "$ping_status" ]; then
            echo "ping : INSTALLED"
        else
            echo "ping : NOT FOUND"
        fi

        if [ -n "$curl_status" ]; then
            echo "curl : INSTALLED"
        else
            echo "curl : NOT FOUND"
        fi

        echo
    } >> "$log_file"
}

# =========================
# Network Scan
# =========================

function scan_network() {

    {
        echo "===== NETWORK SCAN ====="
    } >> "$log_file"

    for ip in {1..254}
    do
        target="$subnet.$ip"

        ping_result=$(ping -c 1 -W 1 "$target" 2>/dev/null)

        if [ $? -eq 0 ]; then

            echo "$target is UP" >> "$log_file"

            live_hosts+=("$target")
        fi
    done

    echo >> "$log_file"
}

# =========================
# Web Check
# =========================

function web_check() {

    {
        echo "===== WEB CHECK ====="
    } >> "$log_file"

    for host in "${live_hosts[@]}"
    do
        web_scan=$(nmap --script http-title -p 80 "$host" 2>/dev/null)

        {
            echo "Checking $host"
            echo "$web_scan"
            echo
        } >> "$log_file"
    done
}

# =========================
# Execute Functions
# =========================

echo "===== NETWORK AUDIT REPORT =====" > "$log_file"
echo "Date: $(date)" >> "$log_file"
echo >> "$log_file"

system_info
check_tools
scan_network
web_check

echo "Audit Completed!"
echo "Saved in $log_file"
