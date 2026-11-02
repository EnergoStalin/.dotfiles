#!/usr/bin/env sh
set -euo pipefail

while ! ip link show dev xray0 > /dev/null 2>&1; do
  sleep .1;
done

# Interface-bound clients (libtorrent) need an IPv4 source on the TUN itself.
# This benchmark-range /32 is local to the tunnel, not a physical LAN address.
ip -4 address replace 198.18.0.1/32 dev xray0
ip -4 route replace default dev xray0
ip -6 route replace default dev xray0
