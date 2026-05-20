# 🏗️ Infrastructure Design & Visual Assets

This directory contains the visual representations of the SOC laboratory's design. These diagrams illustrate how the different security layers interact and how data flows from the endpoints to the central dashboard.

---

## 🖼️ Visual Documentation

### 1. Network Architecture
The file `network-architecture.png` provides a high-level view of the virtual environment.
* **Segmented Topology:** Built on a VMware Host-Only network to ensure 100% isolation.
* **Nodes:** Displays the interconnection between the **Wazuh Manager**, the **Suricata Gateway**, and the various **monitored endpoints** (Windows and Linux).
* **Traffic Flow:** Shows how the Kali-Attacker node interacts with the target subnet.

### 2. SOC Detection Workflow
The file `soc-workflow.png` details the logical pipeline of a security event.
* **Capture:** Traffic sniffing by Suricata via the `ens33` interface.
* **Ingestion:** Real-time monitoring of the `eve.json` file by the Wazuh Logcollector.
* **Correlation:** How the Wazuh Analysis Engine matches network events with host-based telemetry.
* **Alerting:** The final visualization of verified threats on the Kibana-based dashboard.

---

## 🛰️ Technical Specifications
* **Hypervisor:** VMware Workstation Pro
* **Network Mode:** Host-Only (Private Subnet: `192.168.10.0/24`)
* **Detection Engines:** Signature-based (Suricata) & Rule-based (Wazuh)

> 💡 **For the detailed IP inventory and system specifications, please refer to the [Main README](../README.md#lab-architecture).**
