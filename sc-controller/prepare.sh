#!/usr/bin/env sh
set -euo pipefail

export CONFIG="$2/scc"

envsubst < scc-daemon.service.template > systemd/user/scc-daemon.service