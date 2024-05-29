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

  mkdir -p "$root"
  stow $@ --target "$root" "$package"
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
  local package="$1"
  installifneeded "${XDG_CONFIG_HOME:-$HOME/.config}/$package" "$@"
}

installconfigoverride() {
  local package="$1"
  local override="$2"
  shift 2

  installconfig "${XDG_CONFIG_HOME:-$HOME/.config}/$override" "$package" "$@"
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

installhome vim
installhome zsh
installhome git

installconfigoverride sc-controller scc
