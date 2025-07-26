#!/bin/bash

INTERFACES_FILE="/etc/network/interfaces"

echo "Enter IP address in the format x.x.x.x/x (example: 192.168.1.1/24):"
read -r IP_CIDR

# Basic validation
if [[ ! "$IP_CIDR" =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}/[0-9]{1,2}$ ]]; then
    echo "❌ Invalid IP format. Use x.x.x.x/x (e.g. 192.168.1.10/24)"
    exit 1
fi

echo ""
echo "Adding the following to $INTERFACES_FILE:"
echo ""
echo "auto vmbr0
iface vmbr0 inet static
        address  $IP_CIDR
        bridge-ports none
        bridge-stp off
        bridge-fd 0"
echo ""

# Confirm before writing
read -rp "Proceed with adding this configuration? [y/N]: " CONFIRM
if [[ "$CONFIRM" =~ ^[Yy]$ ]]; then
    echo "" >> "$INTERFACES_FILE"
    echo "auto vmbr0" >> "$INTERFACES_FILE"
    echo "iface vmbr0 inet static" >> "$INTERFACES_FILE"
    echo "        address  $IP_CIDR" >> "$INTERFACES_FILE"
    echo "        bridge-ports none" >> "$INTERFACES_FILE"
    echo "        bridge-stp off" >> "$INTERFACES_FILE"
    echo "        bridge-fd 0" >> "$INTERFACES_FILE"
    echo "✅ Configuration added successfully."
else
    echo "❌ Operation cancelled."
fi
