#!/bin/bash
user_home=$HOME
name="ayman"
files_count=$(ls ~ | wc -l)
hostname=$(hostname)
date=$(date)
kernal_Version=$(uname -r)
echo "hello $name!"
echo "Today Is : $date"
echo "Today folder is : $user_home"
echo "File home Count: $files_count"
echo "host name is : $hostname"
echo "kernal Version is : $kernal_Version"
