#!/bin/bash
# ================================
# shadow_monitor.sh - /etc/shadow Monitor
# Author: Ayman Ahmed
# Usage: ./shadow_monitor.sh
# Run automatically: add to crontab
# ================================

TARGET="/etc/shadow"
HASH_FILE="/var/log/.shadow_hash.txt"
LOG_FILE="/var/log/shadow_monitor.log"
ALERT_EMAIL="admin@yourcompany.com"

# ================================
# First run — create initial hash
# ================================
if [ ! -f "$HASH_FILE" ]; then
    md5sum "$TARGET" > "$HASH_FILE"
    echo "[$(date)] First run — baseline hash created" >> "$LOG_FILE"
    exit 0
fi

# ================================
# Compare hashes
# ================================
CURRENT_HASH=$(md5sum "$TARGET")
OLD_HASH=$(cat "$HASH_FILE")

if [ "$CURRENT_HASH" != "$OLD_HASH" ]; then
    echo "[$(date)] ALERT: /etc/shadow was modified!" >> "$LOG_FILE"
    echo "SECURITY ALERT: /etc/shadow modified at $(date)" | \
        mail -s "ALERT: /etc/shadow modified!" "$ALERT_EMAIL"
    echo "$CURRENT_HASH" > "$HASH_FILE"
else
    echo "[$(date)] OK: No changes detected" >> "$LOG_FILE"
fi
