#!/usr/bin/env bash
set -euo pipefail

XRAY_DIR=/etc/xray

IFACE=
for family in -4 -6; do
  IFACE=$(ip -j "$family" route show default | jq -r '
    map(select(.dev // "" | test("^(en|eth|wl)")))
    | min_by(.metric // 0)
    | .dev // empty
  ')
  if [[ -n "$IFACE" ]]; then
    break
  fi
done

# Fail immediately; systemd retries failed starts without waiting for connectivity.
if [[ -z "$IFACE" ]]; then
  echo "No Ethernet/Wi-Fi default route" >&2
  exit 1
fi

tmp=$(mktemp -t ".interface.XXXXXX")
trap 'rm -f "$tmp"' EXIT

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
