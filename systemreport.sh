#!/bin/bash
#hostname varible
hostname=$(hostname)
#user varaible
user=$(whoami)
#os variable
#help to get is release
. /etc/os-release
os="$NAME $VERSION_ID"
#kernel version variable
kernel_version=$(uname -r)
#ram total variable
ram_total=$(free -h | grep Mem: | awk '{print $2}')
ram_used=$(free -h | grep Mem: | awk '{print $3}')
#disk usage variable
disk_usage=$(df -h / | tail -1 | awk '{print $5}')
#file variable
file_home=$(ls ~ | wc -l)
#date variable
date=$(date)
#output
echo "===================================="
echo "           system report            "
echo "===================================="
echo "HOSTNAME           :$hostname       "
echo "USER NAME          :$user           "
echo "OPERATING SYSTEM   :$os             "
echo "KERNEL VERSION     :$kernel_version "
echo "RAM TOTAL          :$ram_total      "
echo "RAM USED           :$ram_used       "
echo "------------------------------------"
echo "DISK USAGE         :$disk_usage     "
echo "------------------------------------"
echo "FILE HOME          :$file_home      "
echo "DATE               :$date           "
echo "===================================="
echo "           THANK YOU !              "
echo "===================================="
