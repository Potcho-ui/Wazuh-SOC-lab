# ⚔️ Threat Emulation & Detection Validation

This directory documents the offensive methodology used to stress-test the SOC infrastructure. By simulating real-world attack vectors, we validate that the **Suricata** signatures and **Wazuh** rules are correctly triggered, parsed, and alerted.

---

## 🎯 Simulation Methodology

The testing process follows a structured **Attack-to-Detection** cycle:
1. **Preparation:** Ensuring the target endpoint is active and the Wazuh Agent is connected.
2. **Execution:** Running controlled exploits or scans from the `Kali-Attacker` node.
3. **Analysis:** Verifying the presence of telemetry in the raw logs (`eve.json` or `archives.log`).
4. **Validation:** Confirming the alert visibility and severity level on the Wazuh Dashboard.

---

## ☣️ Adversary Tactics & Techniques

The following scenarios were chosen to represent common stages of the **Cyber Kill Chain**:

### 1. Reconnaissance (T1595)
* **Goal:** Identify open ports and service versions on Windows/Linux targets.
* **Mechanism:** Using `Nmap` for stealthy SYN scans.
* **Defensive Proof:** Suricata signature match for "Potential SSH Scan" or "Nmap Scripting Engine".

### 2. Credential Access (T1110)
* **Goal:** Compromise user accounts via SSH brute-force.
* **Mechanism:** `Hydra` automation using the `rockyou.txt` wordlist.
* **Defensive Proof:** Wazuh Rule 5712 (SSHD Brute Force) - detection of 8+ failed logins within 2 minutes.

### 3. Impact / Denial of Service (T1498)
* **Goal:** Disrupt service availability through network volumetric flooding.
* **Mechanism:** `Hping3` ICMP flood.
* **Defensive Proof:** Suricata anomaly detection for high-frequency ICMP packets.

---

## 📂 Directory Contents

* `emulation-commands.md`: The complete technical reference of commands and flags used during testing.

> 💡 **Visual evidence of these detections can be found in the [Screenshots](../screenshots/README.md) directory.**
