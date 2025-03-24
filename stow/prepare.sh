#!/usr/bin/env sh

set -euo pipefail

ln -sf "$(pwd)/.stow-global-ignore" "$HOME/.stow-global-ignore"
envsubst < .stowrc.template > .stowrc