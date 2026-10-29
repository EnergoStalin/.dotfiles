#!/usr/bin/env sh
set -euo pipefail

while ! ip link show | grep xray0; do
  sleep .1;
done

ip route add default dev xray0
ip -6 route add default dev xray0