#!bin/sh

ln -sf "$(pwd)/.stow-global-ignore" "$HOME/.stow-global-ignore"
envsubst < .stowrc.template > .stowrc
