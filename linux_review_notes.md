# Linux & Pentesting Review Notes

## Key Commands
- `pwd` — print working directory
- `ls -la` — list all files with details
- `grep -i 'error' file` — case-insensitive search
- `cmd | wc -l` — count lines
- `chmod +x script.sh` — add execute permission

## Nmap Cheatsheet
- `nmap -sV IP` — version detection
- `nmap -p- IP` — all 65535 ports
- `sudo nmap -A IP` — aggressive scan
- `nmap --script=smb-vuln-ms17-010 IP` — EternalBlue check

## Metasploit Workflow
1. `search exploit-name`
2. `use module`
3. `set RHOSTS target-IP`
4. `set LHOST your-IP`
5. `exploit`

## Metasploitable2 Vulnerabilities
| Port | Service | CVE |
|------|---------|-----|
| 21 | vsftpd 2.3.4 | CVE-2011-2523 |
| 139 | Samba | CVE-2007-2447 |
| 1524 | Bindshell | No CVE — open root shell |
| 3306 | MySQL | No password |
