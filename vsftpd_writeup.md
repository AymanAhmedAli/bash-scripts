# vsftpd 2.3.4 Backdoor — Security Analysis
**CVE:** CVE-2011-2523  
**Target:** Metasploitable2 (172.26.154.66)  
**Tool:** Metasploit — exploit/unix/ftp/vsftpd_234_backdoor  
**Result:** Root shell ✅

---

## Background
vsftpd 2.3.4 (aka "Smiley Face Backdoor") was a malicious 
backdoor injected into the source code by an attacker in 2011.
It opens port 6200/TCP as a root shell when triggered.

---

## How to Trigger
The backdoor activates when an FTP login attempt is made 
with a username ending in :) (smiley face).
Example: `user:)` as username → port 6200 opens → root shell

---

## Prevention (Defender Perspective)

### 1. Patch Management
- Upgrade vsftpd immediately
- `apt-get install --only-upgrade vsftpd`
- Always verify package integrity after download

### 2. Firewall Configuration
- Block port 6200 inbound/outbound
- `iptables -A INPUT -p tcp --dport 6200 -j DROP`
- `iptables -A OUTPUT -p tcp --sport 6200 -j DROP`

### 3. Principle of Least Privilege
- Run vsftpd as a limited user, not root
- Configure chroot jail in vsftpd.conf
- Disable anonymous FTP access

---

## Indicators of Compromise (IOCs)

### Network Signs
- Sudden open port 6200/TCP: `netstat -antp | grep 6200`
- Suspicious outbound connections from FTP service

### Log Signs
- FTP login attempts with username containing :)
- Check: `/var/log/vsftpd.log` and `/var/log/auth.log`

### Process Signs
- New /bin/sh or /bin/bash process owned by root
- Check: `ps aux | grep sh`
- Linked to port 6200

### SIEM/Wazuh Alerts
- Alert on FTP login with unusual username pattern
- Alert on new process spawned under root from port 6200
- Alert on unexpected outbound connection from port 6200

---

## Why Still Exists in the Real World?

1. **Legacy & ICS Systems** — Medical devices, industrial
   controllers, and old cameras run embedded firmware
   that vendors no longer update

2. **Shadow IT** — Forgotten servers running in the background
   with no regular vulnerability scanning

3. **"If it works, don't touch it"** — Fear of breaking
   compatibility leads to avoiding security patches

---

## Lesson Learned
Attackers and defenders must understand both sides.
A pentester finds the vulnerability — a security engineer
prevents it, detects it, and responds to it.
