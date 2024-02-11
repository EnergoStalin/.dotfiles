#!/bin/bash

if timeout 1s xset q &>/dev/null; then
    echo "Xorg detected"
fi
