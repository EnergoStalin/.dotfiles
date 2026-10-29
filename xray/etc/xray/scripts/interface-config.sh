#!/usr/bin/env bash
set -euo pipefail

XRAY_DIR=/etc/xray
INTERFACE_TIMEOUT=${XRAY_INTERFACE_TIMEOUT:-10}

if [[ ! "$INTERFACE_TIMEOUT" =~ ^[0-9]+$ ]]; then
  echo "XRAY_INTERFACE_TIMEOUT must be a non-negative integer (seconds)" >&2
  exit 1
fi
deadline=$((SECONDS + 10#$INTERFACE_TIMEOUT))

IFACE=
while :; do
  for family in -4 -6; do
    candidate=$(ip "$family" route show default | awk '
      {
        metric = 0
        for (i = 1; i <= NF; i++) {
          if ($i == "metric") metric = $(i + 1)
          if ($i == "dev") {
            iface = $(i + 1)
            if (iface ~ /^(enp|eno|wlan)/ && (!found || metric < best_metric)) {
              best_iface = iface
              best_metric = metric
              found = 1
            }
          }
        }
      }
      END { if (found) print best_iface }
    ')
    if [[ -n "$candidate" ]]; then
      IFACE=$candidate
      break
    fi
  done

  [[ -n "$IFACE" ]] && break
  if (( SECONDS >= deadline )); then
    echo "No active eth/wlan interface after ${INTERFACE_TIMEOUT}s" >&2
    exit 1
  fi
  sleep 1
done

tmp=$(mktemp -t ".interface.XXXXXX")

jq -n --arg iface "$IFACE" '{
  inbounds: [{
    tag: "tun",
    protocol: "tun",
    sniffing: {
      enabled: true,
      destOverride: ["http", "tls", "quic"]
    },
    settings: {
      autoOutboundsInterface: $iface
    }
  }]
}' > "$tmp"

INTERFACE_FILE="$XRAY_DIR/99-interface.json"

install -g xray -m 0664 "$tmp" "$INTERFACE_FILE"
