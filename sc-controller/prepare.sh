#!/bin/env sh

export CONFIG="$2/scc"

envsubst < scc-daemon.service.template > systemd/user/scc-daemon.service
