#!/bin/bash

if timeout 1s xset q &>/dev/null; then
    cd xorg && stow -t "$HOME" */ && cd -
fi

cd cross && stow -t "$HOME" */ && cd -
