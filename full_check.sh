#!/bin/bash
#Information About System
kernel=$(uname -r)
user=$(whoami)
. /etc/os-release
os="$NAME $VERSION_ID"
#OutPut System Information
echo "===================================="
echo "             SYSTEM INFO            "
echo "===================================="
echo "Kernel is            :$kernel       "
echo "User name is         :$user         "
echo "OS Version is        :$os           "
echo "===================================="
echo "             FILE EXSITS            "
echo "------------------------------------"
echo "            LINUX PRACTICE          "
echo "------------------------------------"
#Check if the file eists or not (linux_practice)
if [ -d "$HOME/linux_practice" ]; then
    echo "File is exists!"
else
    echo "File dosen't exists!"
fi
echo "               SCRIPTS              "
echo "------------------------------------"
#Check if the file exists or not (Scripts)
if [ -d "$HOME/linux_practice/scripts" ]; then
    echo "File is exists!"
else
    echo "File dosen't exists!"

fi
echo "------------------------------------"
echo "                LOGS                "
echo "------------------------------------"
#Check if the files exists or not (logs)
if [ -d "$HOME/linux_practice/logs" ]; then
    echo "File is exists!"
else
    echo "File dosen't exists!"
fi
echo "===================================="
#check files in home count
echo "          Home Files Count          "
echo "------------------------------------"
files=$(ls ~ | wc -l)

if [ $files -gt 10 ]; then
    echo "Home has more than 10 files: $files"
else
    echo "Home has less than 10 files: $files"
fi
echo "===================================="
echo "             DISK USAGE             "
echo "------------------------------------"
#Disk usage
disk_usage=$(df -h / | tail -1 | awk '{print $5}')
echo "DISK USAGE IS       :$disk_usage    "
echo "===================================="
#Ping Check
echo "             PING CHECK             "
echo "------------------------------------"
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
