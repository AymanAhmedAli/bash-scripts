#!/bin/bash
# ================================
# myloop.sh - Loop Examples
# Author: Ayman Ahmed
# ================================

echo "===== Number Loop ====="
for i in {1..10}; do
    echo "Number: $i"
done

echo "===== File Count Check ====="
files=$(ls ~ | wc -l)
if [ $files -gt 10 ]; then
    echo "[+] Home has $files files (more than 10)"
else
    echo "[-] Home has $files files (less than 10)"
fi
