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
