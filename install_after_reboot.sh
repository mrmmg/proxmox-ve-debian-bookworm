#!/bin/bash
set -e

echo "=== Step 2: Installing Proxmox VE Packages ==="

echo "Installing Proxmox VE core packages..."
apt install -y proxmox-ve postfix open-iscsi chrony

echo "Removing default Debian kernel..."
apt remove -y linux-image-amd64 'linux-image-6.1*'

echo "Updating grub..."
update-grub

echo "Removing os-prober (optional but recommended)..."
apt remove -y os-prober

echo "✅ Proxmox VE installation is complete."
echo "You can access the web interface at: https://<your-ip>:8006"