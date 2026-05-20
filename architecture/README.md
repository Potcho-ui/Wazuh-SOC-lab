# 🏗️ System Design & Data Flow

This directory focuses on the technical communication between the different layers of the SOC Lab. While the general overview is available in the main README, this section details how telemetry is routed.

---

## 🛰️ Network Infrastructure
The laboratory environment is built on a virtualized **Host-Only** network. This setup allows for:
* **Total Isolation:** No traffic leaks to the host machine or external internet.
* **Promiscuous Mode:** The `Network-IDS` interface is configured to sniff all traffic traversing the `192.168.10.0/24` subnet.

---

## 🔄 Technical Data Pipeline

The integration between Suricata and Wazuh is the backbone of this architecture. Here is the technical breakdown of the data flow:

1. **Traffic Capture:** Suricata monitors the `ens33` interface on the `SIEM-WAZUH` node.
2. **Log Serialization:** Alerts are written in JSON format to `/var/log/suricata/eve.json`.
3. **Internal Collection:** The local Wazuh Agent (running on the same manager node) is configured as a **Logcollector**.
4. **Analysis Engine:** The Manager parses the JSON fields (src_ip, dest_ip, alert.signature) and compares them against the `ids` decoders.
5. **Dashboard Indexing:** Verified alerts are sent to the **Wazuh Indexer** for long-term storage and visualization.

---

## 📁 Directory Content
* `network-diagram.png`: A visual representation of the VM interactions and traffic flow.
* `service-mapping.md`: (Optional) Detailed list of open ports and services for each node.

> 💡 **For a full list of IP addresses and OS versions, please refer to the [Main README](../README.md#lab-architecture).**
