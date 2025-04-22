#!/usr/bin/env sh
set -euo pipefail

CONFIG=$2
PWD_ESCAPED="$(pwd | sed 's/\//\\\//g')"

curl -sLO https://github.com/dracula/qbittorrent/raw/master/dracula.qbtheme

patch_theme() {
  p="$CONFIG/qBittorrent/qBittorrent.conf"
  grep "$p" -e CustomUIThemePath && \
  sed -E 's/(General\\CustomUIThemePath=).*$/\1'$PWD_ESCAPED'\/dracula.qbtheme/' -i "$p" || \
  cat <<-EOF >> "$p"
[Preferences]
General\\UseCustomUITheme=true
General\\CustomUIThemePath=$PWD/dracula.qbtheme
EOF
}

patch_theme