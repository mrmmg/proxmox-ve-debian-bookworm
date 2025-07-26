#!/bin/bash
set -e

echo "=== Step 1: Configure Proxmox VE Repository ==="

echo "Adding Proxmox VE repo..."
echo "deb [arch=amd64] http://download.proxmox.com/debian/pve bookworm pve-no-subscription" > /etc/apt/sources.list.d/pve-install-repo.list

echo "Downloading Proxmox GPG key..."
wget https://enterprise.proxmox.com/debian/proxmox-release-bookworm.gpg -O /etc/apt/trusted.gpg.d/proxmox-release-bookworm.gpg

echo "Verifying GPG key checksum..."
EXPECTED="7da6fe34168adc6e479327ba517796d4702fa2f8b4f0a9833f5ea6e6b48f6507a6da403a274fe201595edc86a84463d50383d07f64bdde2e3658108db7d6dc87"
ACTUAL=$(sha512sum /etc/apt/trusted.gpg.d/proxmox-release-bookworm.gpg | awk '{print $1}')
if [ "$EXPECTED" != "$ACTUAL" ]; then
    echo "❌ GPG key checksum mismatch!"
    exit 1
fi

echo "Updating system..."
apt update && apt full-upgrade -y

echo "Installing Proxmox VE kernel..."
apt install -y proxmox-default-kernel

echo "✅ Pre-reboot setup complete."
echo "⚠️ Please reboot the system now via 'systemctl reboot', then run the second script: install_after_reboot.sh"
