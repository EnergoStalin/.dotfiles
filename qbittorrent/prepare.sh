#!/bin/env sh

CONFIG=$2
PWD_ESCAPED="$(pwd | sed 's/\//\\\//g')"

curl -sLO https://github.com/dracula/qbittorrent/raw/master/dracula.qbtheme

patch_theme() {
  sed -E 's/(General\\CustomUIThemePath=).*$/\1'$PWD_ESCAPED'\/dracula.qbtheme/' \
    -i "$CONFIG/qBittorrent/qBittorrent.conf"
}

patch_theme
