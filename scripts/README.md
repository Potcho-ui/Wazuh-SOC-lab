# 📜 Automation & Emulation Scripts

This directory contains the automation tools used to validate the SOC's detection capabilities. These scripts simplify the execution of threat emulation scenarios.

---

## 🛠️ Script Overview

### 1. `emulate-attacks.sh`
* **Type:** Interactive Bash Script.
* **Role:** Provides a menu-driven interface to launch controlled attacks from the **Kali-Attacker** node.
* **Simulations Included:** * **Reconnaissance:** Nmap Stealth SYN Scan.
    * **Brute Force:** SSH dictionary attack via Hydra.
    * **DoS:** Volumetric ICMP flooding via Hping3.

---

## 🚀 How to Run

1.  **Navigate** to the scripts directory:
    ```bash
    cd scripts/
    ```
2.  **Set executable permissions**:
    ```bash
    chmod +x emulate-attacks.sh
    ```
3.  **Execute** with root privileges:
    ```bash
    sudo ./emulate-attacks.sh
    ```

---

## ⚠️ Prerequisites
The following tools must be installed on the attacking machine:
* `nmap`
* `hydra` (and the `rockyou.txt` wordlist)
* `hping3`

---
> 💡 **Tip:** Always monitor the **Wazuh Dashboard** in real-time while running these scripts to observe alert generation.
