#!/usr/bin/env sh

set -euo pipefail

run() {
  local hook="$1"
  shift

  local package="$1"

  if [[ -f "$package/$hook.sh" ]]; then
    local wd="$(pwd)"
    cd "$package"

    echo sh "$hook.sh" $@
    sh "$hook.sh" $@

    cd "$wd"
  fi
}

install() {
  local root="$1"
  local package="$2"
  shift 2

  run prepare "$package" "$root"

  echo stow --verbose $@ --target "$root" "$package"
  stow --verbose $@ --target "$root" "$package"

  run post "$package" "$root"
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

_installifpkg() {
  local root="$1"
  local package="$2"
  shift 2

  if pacman -Qi "$package" &> /dev/null; then
    install "$root" "$package" "$@"
  fi
}

_installconfig() {
  _installifpkg "$(getconfig)" "$@"
}

installhome() {
  _installifpkg "$HOME" "$@"
}

getconfig() {
  echo "${XDG_CONFIG_HOME:-$HOME/.config}"
}

installconfig() {
  _installconfig "$@"
}

mkdir -p .local/bin

installhome stow &

# installconfig autorandr &
installconfig droidcam &
installconfig ferium &
installconfig flameshot &
installconfig lazygit &
installconfig neovim &
installconfig opentabletdriver &
# installconfig polybar &
installconfig stow &
installconfig tmux &
installconfig xdg-desktop-portal &
installconfig yazi &
installconfig sc-controller &
installconfig starship &
installconfig polkit-gnome &
installconfig qbittorrent &
installconfig gpu-screen-recorder-git &
installconfig kitty &
installconfig btop &

installconfig waybar &
installconfig uwsm &
installconfig hyprland &

# Workaround for nvim builded from source
installifexec "$(getconfig)" neovim nvim &

# Workaround for wakatime installed by neovim
installifexec "$HOME" wakatime ~/.wakatime/wakatime-cli &
#
# Workaround for nix installed by script
installifexec "$(getconfig)" nix ~/.nix-profile/bin/nix &

installhome feh &
installhome vim &
installhome zsh &
installhome git &
# installhome i3 &
installhome wireplumber &

wait $(jobs -p)