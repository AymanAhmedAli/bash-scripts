# Networking Security Notes
## Core Concepts & Security Analysis

---

## 1. Firewall Types

### Stateless Firewall
- Works at Layer 3 & 4 using ACLs
- Inspects each packet independently (no context)
- Checks: Source/Destination IP, Port, Protocol
- **Attacker View:** Easy to bypass via Packet Crafting
  or sending packets that appear to be part of
  an existing connection

### Stateful Firewall
- Maintains a State Table of all active connections
- Only allows packets that match an existing
  connection request from inside
- **Attacker View:** Hard to bypass from outside.
  Forces attacker to use Reverse Shell techniques
  (victim initiates the connection outward)

### Next-Generation Firewall (NGFW)
- Deep Packet Inspection (DPI) — inspects Layer 7
- Application Awareness — blocks apps like Tor/BitTorrent
  even if they change ports
- IPS/IDS — real-time attack prevention
- SSL/TLS Inspection — decrypts and inspects
  encrypted traffic
- Identity Awareness — rules based on AD user,
  not just IP

**FortiGate = Full NGFW:**
- Stateful + DPI + App Control + SSL Inspection
- IPS/IDS + FortiGuard Threat Intelligence
- Identity Awareness with Active Directory

**Attacker Techniques Against NGFW:**
- HTTPS Tunneling — malicious data inside HTTPS
- Living off the Land — use built-in tools
  (PowerShell, WMI, certutil)
- Reverse Shell — connection initiated from inside
  bypasses outbound rules

---

## 2. ARP (Address Resolution Protocol)

**Function:** Maps IP addresses to MAC addresses
on the local network

**Security Issue:** Designed with "blind trust" —
no authentication required

### ARP Spoofing / Poisoning Attack
- Attacker sends fake Gratuitous ARP replies
- Tells victim: "I am the Router"
- Tells Router: "I am the victim"
- Result: Man-in-the-Middle (MITM) attack —
  all traffic passes through attacker first

### Defense
- **DAI (Dynamic ARP Inspection):** Validates ARP
  packets against DHCP Snooping binding table
- **Static ARP:** Manually bind critical IPs
  (like gateway) to their MAC addresses
- **Wireshark Detection:** Filter:
  `arp.duplicate-address-detected`

---

## 3. VLANs

**Function:** Logically segment a physical network
into isolated virtual networks

**Example:**
- VLAN 10 → HR      → 192.168.10.0/24
- VLAN 20 → IT      → 192.168.20.0/24
- VLAN 30 → Finance → 192.168.30.0/24

**Benefits:**
- Security: departments cannot see each other
- Performance: reduces broadcast traffic
- Management: easier network administration

### VLAN Hopping Attack
**Switch Spoofing:**
- Attacker makes device act as a Switch
- Negotiates Trunk port → sees all VLANs

**Double Tagging:**
- Attacker sends packet with double VLAN tag
- Switch strips first tag → packet reaches
  target VLAN

**Defense:**
- Disable unused Trunk ports
- Change Native VLAN from default (1)
- Enable VLAN Access Control Lists

---

## 4. Routing

### Static vs Dynamic Routing
| | Static | Dynamic |
|---|---|---|
| Configuration | Manual by engineer | Auto-discovered |
| Updates | Manual | Automatic |
| Best for | Small networks | Large networks |

### Dynamic Routing Protocols
**IGP (Interior — within organization):**
- OSPF — Open Shortest Path First (most common)
- EIGRP — Cisco proprietary
- RIP — old and slow

**EGP (Exterior — between organizations):**
- BGP — Border Gateway Protocol (runs the Internet)

**Security Note — BGP Hijacking:**
- Attacking BGP routers can redirect Internet
  traffic globally — one of the most dangerous
  attacks at Internet scale

---

## 5. NAT vs PAT

**NAT Function:** Translates private IPs to
public IP for Internet access

**Why NAT:**
- IPv4 exhaustion (only 4.3 billion addresses)
- Hides internal network structure
- Cost efficiency

| | NAT | PAT (NAT Overload) |
|---|---|---|
| Mapping | 1 private IP = 1 public IP | Many private IPs = 1 public IP |
| Differentiator | Pool of public IPs | Unique Port number per device |
| Use case | Servers needing fixed IP | Home/office routers (default) |

**Security Note:**
- NAT hides internal IPs but is NOT a Firewall
- Reverse Shell bypasses NAT because connection
  starts from inside the network

---

## Lesson Learned
Understanding both attacker and defender perspectives
on each protocol is what separates a security engineer
from a regular network engineer.
