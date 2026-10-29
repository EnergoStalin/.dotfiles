#!/usr/bin/env sh
set -euo pipefail

sudo chown -R :xray /etc/xray
sudo chmod 2775 /etc/xray

sudo systemctl daemon-reload

if systemctl cat NetworkManager.service &> /dev/null; then
  sudo systemctl enable NetworkManager-dispatcher.service
fi

if systemctl cat networkd-dispatcher.service &> /dev/null; then
  sudo systemctl enable networkd-dispatcher.service
fi

sudo systemctl restart xray
