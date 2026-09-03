# CCNA & Network Security Notes

---

## 1. GPO (Group Policy Objects)

**Definition:**
A GPO is a set of rules applied to Organizational Units (OUs)
inside Windows Server Active Directory to control user and
computer behavior across the domain.

**Computer Configuration vs User Configuration:**

| | Computer Configuration | User Configuration |
|---|---|---|
| Applied to | The machine itself | The user account |
| Triggered | At startup | At login |
| Follows | The device | The user (any device) |
| Example | Disable USB on all PCs | Unified desktop background |

**Real-world examples at NAWY:**
- Enforce unified desktop background for all users
- Disable CMD for non-IT staff
- Force Windows Firewall to be always ON
- Block software installation for regular employees
- Enforce password complexity policy

**Security Use Cases:**
- Disable USB ports to prevent data exfiltration
- Restrict access to Control Panel
- Deploy security software automatically
- Force screen lock after inactivity

---

## 2. STP (Spanning Tree Protocol)

**Definition:**
Layer 2 protocol that prevents network loops in redundant
switch topologies by creating a loop-free logical tree.

**Why We Need It:**
Without STP, redundant links cause:
- Broadcast Storms — ARP requests loop forever
- MAC Table Instability — same MAC appears on multiple ports
- Multiple Frame Copies — devices receive duplicate packets

**How STP Works:**
1. Root Bridge Election — lowest Bridge ID (Priority + MAC)
2. Calculate best path (lowest cost) to Root Bridge
3. Block redundant ports (Blocking State)
4. If active link fails → blocked port activates automatically

**STP Versions:**
- STP  — original, slow (30-50 seconds convergence)
- RSTP — Rapid STP, fast (under 1 second)
- PVST — Per-VLAN STP (Cisco) — separate STP per VLAN

**Security — STP Attack (BPDU Spoofing):**
- Attacker sends fake BPDUs to become Root Bridge
- All traffic flows through attacker = Layer 2 MITM

**Defense:**
- BPDU Guard on access ports
- Root Guard on uplink ports

---

## 3. ACL (Access Control List)

**Definition:**
A set of rules applied on router/switch interfaces to
permit or deny network traffic based on defined criteria.
Think of it as a security guard with a rulebook —
every packet is checked and either allowed or blocked.

**Standard ACL vs Extended ACL:**

| | Standard ACL | Extended ACL |
|---|---|---|
| Inspects | Source IP only | Source + Destination + Protocol + Port |
| Control | Low (all or nothing) | High (very granular) |
| Cisco Numbers | 1-99, 1300-1999 | 100-199, 2000-2699 |
| Best placed | Near destination | Near source |

**Examples:**

Standard ACL scenario:
Block entire Accounting department (192.168.10.0/24)
from accessing HR network completely.

Extended ACL scenario:
Allow employee (10.0.0.5) to browse web server
(HTTP port 80/443) but block FTP (port 21) to same server.

**Golden Rule — Implicit Deny:**
Every ACL ends with a hidden "deny all" rule.
If a packet doesn't match any rule → it gets blocked.
Always add "permit ip any any" at the end if you only
want to block specific traffic.

**FortiGate vs Cisco ACL:**
FortiGate policies are more granular:
Source IP + Destination + Port + User + Application
= This is the NGFW advantage over traditional ACLs

---

## Key Takeaways

- GPO = control user/computer behavior across AD domain
- STP = prevent Layer 2 loops in redundant networks
- ACL = filter traffic based on IP, port, protocol
- Always remember: Implicit Deny at end of every ACL
- STP attack = fake Root Bridge = Layer 2 MITM
- Extended ACL near source, Standard ACL near destination

