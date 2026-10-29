#!/usr/bin/env sh
set -euo pipefail

sudo chown -R :xray /etc/xray
sudo chmod 2775 /etc/xray

sudo systemctl daemon-reload
sudo systemctl restart xray
