#!/usr/bin/env bash
set -euo pipefail
export PATH=/usr/bin

# Block D-Bus/socket activation of resolved while Xray owns port 53.
touch /run/xray-dns-owned
systemctl stop systemd-resolved.service systemd-resolved-varlink.socket systemd-resolved-monitor.socket
