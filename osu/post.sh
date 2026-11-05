#!/usr/bin/env sh
set -eu

target=$2
data="$target/.local/share"

# On Hyprland, xdg-mime needs perl-file-mimeinfo's mimetype command to
# honor these extension globs; its file(1) fallback reports plain ZIP.
if ! command -v mimetype >/dev/null 2>&1; then
    printf '%s\n' 'osu: install perl-file-mimeinfo for xdg-open/Chromium file handling.' >&2
fi

# The installer runs this hook even when Stow fails; check the deployed files.
cmp -s .local/share/mime/packages/osu-lazer.xml "$data/mime/packages/osu-lazer.xml"
cmp -s .local/share/applications/osu-lazer.desktop "$data/applications/osu-lazer.desktop"
cmp -s .local/share/applications/osu-url.desktop "$data/applications/osu-url.desktop"

update-mime-database "$data/mime"
update-desktop-database "$data/applications"
xdg-mime default osu-lazer.desktop application/x-osu-beatmap-archive
xdg-mime default osu-lazer.desktop application/x-osu-skin-archive
xdg-mime default osu-url.desktop x-scheme-handler/osu
