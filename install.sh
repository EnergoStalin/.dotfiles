#!/bin/bash

PIPXPKGLIST="$(which pipx 2> /dev/null && pipx list | grep package | awk '{print $2}')"
PACMANPKGLIST="$(pacman -Qeq)"

prepare() {
  local package="$1"

  if [[ -f "$package/prepare.sh" ]]; then
    local wd="$(pwd)"
    cd "$package"

    set -o xtrace 2> /dev/null
    sh "prepare.sh" $@
    { set +o xtrace; } 2> /dev/null

    cd "$wd"
  fi
}

install() {
  local root="$1"
  local package="$2"
  shift 2

  prepare "$package" "$root"

  set -o xtrace 2> /dev/null
  stow --verbose $@ --target "$root" "$package"
  { set +o xtrace; } 2> /dev/null
}

installifexec() {
  local root="$1"
  local package="$2"
  local exe="$3"
  shift 3

  if which "$exe" > /dev/null; then
    install "$root" "$package" "$@"
  fi
}

_installifneeded() {
  local root="$1"
  local package="$2"
  local pkglist="$3"
  shift 3

  if grep -q "$package" <<< "$pkglist"; then
    install "$root" "$package" "$@"
  fi
}

_installconfig() {
  _installifneeded "$(getconfig)" "$@"
}

installhome() {
  _installifneeded "$HOME" "$@" "$PACMANPKGLIST"
}

getconfig() {
  echo "${XDG_CONFIG_HOME:-$HOME/.config}"
}

installconfig() {
  _installconfig "$@" "$PACMANPKGLIST"
}

pipxinstallconfig() {
  _installconfig "$@" "$PIPXPKGLIST"
}

installhome stow

installconfig alacritty
installconfig autorandr
installconfig droidcam
installconfig ferium
installconfig flameshot
installconfig lazygit
installconfig neovim
installconfig opentabletdriver
installconfig polybar
installconfig stow
installconfig tmux
installconfig xdg-desktop-portal
installconfig yazi
installconfig sc-controller
installconfig starship

# Workaround for nvim builded from source
installifexec "$(getconfig)" neovim nvim

installhome vim
installhome zsh
installhome git
installhome i3

pipxinstallconfig pyload-ng
