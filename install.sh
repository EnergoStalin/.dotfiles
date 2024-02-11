#!/bin/bash

if timeout 1s xset q &>/dev/null; then
    cd xorg && stow -t "$HOME" */ && cd -
fi

if [[ -z "$(which stow)" ]]; then
    sudo apt update || true
    sudo apt install stow -y || true

    sudo pacman -Syy || true
    sudo pacman -S stow || true
fi

if ! [[ -z "$MINIMAL" ]]; then
    cd cross && stow -t "$HOME" */ && cd -
else [[ -z "$SERVER" ]]
    cd cross && stow -t "$HOME" tmux/ git/ vim/ && cd -
fi
