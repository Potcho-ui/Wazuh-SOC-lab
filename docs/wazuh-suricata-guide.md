# 🛠️ Full Deployment Guide: End-to-End SOC Laboratory

This comprehensive guide documents every step, command, and configuration required to build a professional-grade SOC Laboratory, from network architecture design to security alert validation within the SIEM.

---

## 🏗️ 1. Architecture & Virtual Environment

The lab is deployed using **VMware Workstation** within an isolated **Host-Only** network to ensure a secure and controlled environment for malware analysis and threat emulation.

### 💻 Infrastructure Specifications (Subnet: 192.168.10.0/24)
| Machine Name | Operating System | IP Address | Role |
| :--- | :--- | :--- | :--- |
| **SIEM-WAZUH** | Ubuntu Server 24.04 | 192.168.10.10 | Central Manager (Wazuh + Indexer) |
| **Network-IDS** | Ubuntu Server / Desktop | 192.168.10.15 | Suricata IDS Gateway |
| **PC-Client1** | Windows 10 | 192.168.10.30 | Monitored Windows Endpoint |
| **Ubuntu-Client** | Ubuntu Desktop 24.04 | 192.168.10.50 | Monitored Linux Endpoint |
| **Kali-Attacker** | Kali Linux | 192.168.10.100 | Threat Emulation Platform |

---

## 💾 2. Network IDS Deployment (Suricata)

Suricata is installed on the gateway to inspect network traffic for malicious patterns using the **Emerging Threats (ET)** rule set.

### Installation & Basic Setup
```bash
sudo add-apt-repository ppa:oisf/suricata-stable
sudo apt update && sudo apt install suricata jq -y
```

### Traffic Inspection Configuration

Edit the main configuration file: 
```bash
sudo nano /etc/suricata/suricata.yaml
```

Ensure the EVE JSON output is enabled and the correct network interface is selected (e.g., ens33):
```YAML
outputs:
  - eve-log:
      enabled: yes
      filetype: regular
      filename: eve.json
      types:
        - alert

af-packet:
  - interface: ens33 # Replace with your actual interface
    cluster-id: 99
    cluster-type: cluster_flow
    defrag: yes
```
    
### Update Signatures & Start Service
```Bash
sudo suricata-update
sudo systemctl enable suricata && sudo systemctl start suricata
```

## 🎛️ 3. SIEM Deployment & Agent Enrollment (Wazuh)

### Central Manager Installation

On the SIEM-WAZUH machine, run the automated installation script:
```Bash
curl -sO [https://packages.wazuh.com/4.x/wazuh-install.sh](https://packages.wazuh.com/4.x/wazuh-install.sh)
sudo bash wazuh-install.sh -a
```

### Endpoint Agent Deployment

On the target machines (Windows/Linux), install the Wazuh Agent and point it to the Manager's IP:
```Bash
# Example for Ubuntu Client
wget [https://packages.wazuh.com/4.x/apt/pool/main/w/wazuh-agent/wazuh-agent_4.x_amd64.deb](https://packages.wazuh.com/4.x/apt/pool/main/w/wazuh-agent/wazuh-agent_4.x_amd64.deb)
sudo WAZUH_MANAGER='192.168.10.10' dpkg -i wazuh-agent_4.x_amd64.deb
sudo systemctl enable wazuh-agent && sudo systemctl start wazuh-agent
```

## 🔄 4. Log Ingestion Pipeline (Integration)

This is the critical step where Wazuh is configured to ingest Suricata's network alerts.

### Configure Wazuh Logcollector

On the machine where Suricata is running, modify the Wazuh Agent configuration: 
```bash
sudo nano /var/ossec/etc/ossec.conf
```

Add the following block:
```XML
<ossec_config>
  <localfile>
    <log_format>json</log_format>
    <location>/var/log/suricata/eve.json</location>
  </localfile>
</ossec_config>
```

### Apply Changes
```Bash
sudo systemctl restart suricata
sudo systemctl restart wazuh-agent
```

## ⚔️ 5. Threat Emulation & SOC Validation

To verify the operational integrity of the detection pipeline, controlled simulations were conducted from the Kali-Attacker machine. Each scenario was designed to trigger specific detection engines and validate the alerting workflow.

### Scenario A: Network Reconnaissance

Action: A stealthy port scan and OS fingerprinting attempt were performed against the Windows endpoint (192.168.10.30).

Command: 
```bash
sudo nmap -sS -O 192.168.10.30 
```

Expected Outcome: Suricata IDS identifies the semi-open SYN scan patterns and generates a signature match alert in the EVE JSON log.


### Scenario B: Authentication Abuse (Brute Force)

Action: A high-volume dictionary attack was launched against the SSH service of the Linux endpoint (192.168.10.50) using the rockyou.txt wordlist.

Command: 
```bash 
hydra -l user -P rockyou.txt ssh://192.168.10.50
```

Expected Outcome: The Wazuh Agent on the target machine monitors failed authentication logs, triggering Wazuh Rule 5712 (SSHD Brute Force) once the threshold is exceeded.


### Scenario C: Denial of Service (ICMP Flood)

Action: A volumetric network attack was simulated by flooding the Linux endpoint (192.168.10.50) with high-velocity ICMP Echo Requests.

Command: 
```bash 
sudo hping3 --icmp --flood 192.168.10.50
```

Expected Outcome: Suricata detects the abnormal surge in ICMP traffic and triggers an anomaly-based alert for a potential DoS condition.

## 📊 6. Visualization & Monitoring

### Login to the Wazuh Dashboard (https://192.168.x.x).

### Navigate to Security Events or Discover.

### Use filters like location: suricata or search for Rule IDs 86600 - 86604.

### Verification: Real-time alerts should appear, confirming the successful integration of host and network telemetry.

## 🛑 Security Disclaimer:

This lab was built strictly for educational purposes in a private, isolated environment. No unauthorized networks were targeted.
