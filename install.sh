#!/bin/bash

TO_INSTALL=""
PACKAGES="$(find . -maxdepth 1 -type d -not -name '.git' -and -not -name '.' -exec basename {} \;)"
PKGLIST="$(pacman -Qe)"

for package in $PACKAGES; do
  if ! [[ -z "$(echo \"$PKGLIST\" | grep -i $package)" ]]; then
    TO_INSTALL="$package $TO_INSTALL"
  fi
done

echo "Installing configs for $TO_INSTALL"
stow -t ~ $TO_INSTALL
