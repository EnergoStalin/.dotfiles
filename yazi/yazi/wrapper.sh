#!/usr/bin/env sh

function _ya() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXX")"
  $@ --cwd-file="$tmp"
  if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    cd "$cwd"
  fi
  rm -f -- "$tmp"
}

function ya() { _ya yazi "$@" }
function sya() { _ya sudo -E yazi "$@" }