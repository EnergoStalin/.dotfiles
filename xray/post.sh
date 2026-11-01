#!/usr/bin/env sh
set -euo pipefail

sudo chown -R :xray /etc/xray
sudo chmod 2775 /etc/xray

sudo systemctl unmask systemd-resolved.service
sudo systemctl enable systemd-resolved.service
sudo systemctl daemon-reload
# Keep clients on the same endpoint regardless of which resolver owns port 53.
printf 'nameserver 127.0.0.1\n' | sudo tee /etc/resolv.conf > /dev/null
if systemctl is-active --quiet NetworkManager.service; then
  sudo nmcli general reload conf
fi

# Prefer enabled NetworkManager; use networkd only as a fallback.
# Wait-online services are managed separately. Xray retries offline starts,
# but other services may still delay boot if wait-online services are enabled.
if systemctl is-enabled --quiet NetworkManager.service; then
  sudo systemctl enable NetworkManager-dispatcher.service
elif systemctl is-enabled --quiet systemd-networkd.service; then
  if systemctl cat networkd-dispatcher.service > /dev/null 2>&1; then
    sudo systemctl enable networkd-dispatcher.service
  fi
fi

sudo systemctl restart xray
