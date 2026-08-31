# Metasploitable2 Lab Notes

## Target: 192.168.184.144
## Attacker: Kali 192.168.184.145

## Exploit 1: vsftpd 2.3.4 Backdoor
- Port: 21
- CVE: CVE-2011-2523
- Tool: Metasploit
- Module: exploit/unix/ftp/vsftpd_234_backdoor
- Result: root shell via Meterpreter

## Exploit 2: Bindshell
- Port: 1524
- Tool: netcat
- Command: nc 192.168.184.144 1524
- Result: root shell - no credentials needed!

## Lessons Learned
- Always run nmap first
- Check for known CVEs on service versions
- Some ports give direct root access

## Exploit 3: Samba usermap_script
- Port: 139
- CVE: CVE-2007-2447
- Module: exploit/multi/samba/usermap_script
- Result: root shell ✅

## Exploit 4: MySQL No Password
- Port: 3306
- Tool: mysql --skip-ssl
- Command: mysql --skip-ssl -h 192.168.184.144 -u root
- Result: root access with no password ✅
- Found: All databases including dvwa, owasp10
- Users: root, guest — both with empty passwords!

## Exploit 5: UnrealIRCd 3.2.8.1 Backdoor
- Port: 6667
- CVE: CVE-2010-2075
- Module: exploit/unix/irc/unreal_ircd_3281_backdoor
- Result: root shell via Meterpreter ✅

## Password Cracking: John the Ripper
- Tool: John the Ripper
- Wordlist: rockyou.txt
- Target: /etc/shadow from Metasploitable2
- Cracked passwords:
  - klog     : 123456789
  - sys      : batman
  - service  : service
- Remaining 4 hashes not cracked (complex passwords)

## Session 2 — Aug 31, 2026
- New network setup: Bridged adapter
- Kali IP: 172.26.156.155
- Metasploitable IP: 172.26.154.66
- Re-exploited vsftpd 2.3.4 successfully
- Key lesson: LHOST must be Kali IP not Ubuntu IP
- Cracked passwords: batman, 123456789, service

## 🏆 TryHackMe
- **Blue** — Hacking Windows via EternalBlue ✅
- **cat linux.txt** badge — Linux Competency ✅
- **Active Directory Basics** ✅
- **Metasploit: Introduction** ✅
- **Defensive Security & SIEM** ✅
- 30+ rooms completed
- Platinum Rank 🏆
- Blue badge — top 10%
- 30+ day streak
