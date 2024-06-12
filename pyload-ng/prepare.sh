#!/bin/env sh

export CONFIG="$2/$(basename "$(pwd)")"
export PYLOAD="$(which pyload)"

mkdir -p systemd/user

envsubst < pyload.service.template > systemd/user/pyload.service
