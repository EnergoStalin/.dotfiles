#!/bin/bash

BASEDIR="$(basename "$PWD")"
PKGLIST="$(pacman -Qe)"

install() {
  local root="$1"
  local package="$2"
  shift 2

  if [[ -f "$package/prepare.sh" ]]; then
    sh "$package/prepare.sh" "$BASEDIR" "$root" "$package"
  fi

  set -o xtrace
  stow --verbose $@ --target "$root" "$package"
  set +o xtrace
}

installifneeded() {
  local root="$1"
  local package="$2"
  shift 2

  if grep -q "$package" <<< "$PKGLIST"; then
    install "$root" "$package" "$@"
  fi
}

installhome() {
  installifneeded "$HOME" "$@"
}

installconfig() {
  local root="${XDG_CONFIG_HOME:-$HOME/.config}"
  installifneeded "$root" "$@"
}

installhome stow

installconfig alacritty
installconfig autorandr
installconfig droidcam
installconfig ferium
installconfig flameshot
installconfig i3
installconfig lazygit
installconfig nvim
installconfig OpenTabletDriver
installconfig polybar
installconfig stow
installconfig tmux
installconfig xdg-desktop-portal
installconfig yazi
installconfig sc-controller

installhome vim
installhome zsh
installhome git
