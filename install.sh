#!/bin/bash

TO_INSTALL=""
PACKAGES="$(find . -maxdepth 1 -not -name '.git' -and -not -name '.' -exec basename {} \;)"

for package in $PACKAGES; do
  if ! [[ -z "$(pacman -Qe | grep -i $package)" ]]; then
    TO_INSTALL="$package $TO_INSTALL"
  fi
done

echo "Installing configs for $TO_INSTALL"
stow -t ~ $TO_INSTALL
