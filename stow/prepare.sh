#!bin/sh

BASEDIR="$1"
ROOT="$2"
PACKAGE="$3"

cd "$(dirname "$0")"

ln -sf "$BASEDIR/stow/.stow-global-ignore" "$HOME/.stow-global-ignore"
envsubst < .stowrc.template > .stowrc
