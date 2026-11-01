#!/usr/bin/env bash
set -euo pipefail
export PATH=/usr/bin

# Remove only our firewall. This deliberately permits direct traffic while inactive.
status=0
nft destroy table inet xray_killswitch || status=$?
rm -f /run/xray-dns-owned
# Do not wait on a unit ordered before Xray from inside its stop job.
# Nor resurrect the resolver during system shutdown.
if [[ $(systemctl is-system-running 2>/dev/null || true) != stopping ]]; then
  systemctl --no-block start systemd-resolved.service
fi
exit "$status"
