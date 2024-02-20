#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

cd "$SCRIPT_DIR"

curl -sLO https://raw.githubusercontent.com/sxyazi/yazi/main/yazi-config/preset/theme.toml
curl -sLO https://raw.githubusercontent.com/sxyazi/yazi/main/yazi-config/preset/yazi.toml
curl -sLO https://raw.githubusercontent.com/sxyazi/yazi/main/yazi-config/preset/keymap.toml

cd -
