# ⚙️ Configuration Files

This directory contains the essential configuration blocks used to integrate the security engines of the lab.

---

## 🛠️ Configuration Details

### 1. Wazuh Ingestion Policy (`ossec.conf`)
* **Path:** `/var/ossec/etc/ossec.conf`
* **Role:** Enables the Wazuh Logcollector to ingest Suricata's JSON alerts.
* **Target File:** `/var/log/suricata/eve.json`

---

## 🚀 How to Apply

1.  **Backup** your current config:
    ```bash
    sudo cp /var/ossec/etc/ossec.conf /var/ossec/etc/ossec.conf.bak
    ```
2.  **Add** the XML block provided in this folder to your `ossec.conf` file.
3.  **Permissions:** Ensure Wazuh can read Suricata logs:
    ```bash
    sudo usermod -aG suricata wazuh
    ```
4.  **Restart** the service:
    ```bash
    sudo systemctl restart wazuh-manager
    ```

---
