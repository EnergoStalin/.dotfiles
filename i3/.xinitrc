#!/bin/sh

set -a;

export GTK2_RC_FILES=/usr/share/themes/Adwaita-dark/gtk-2.0/gtkrc
export QT_STYLE_OVERRIDE=Adwaita-Dark

ENV_TO_IMPORT="EDITOR VISUAL PNPM_HOME PATH DISPLAY XAUTHORITY GTK_THEME GTK2_RC_FILES QT_STYLE_OVERRIDE XCURSOR_SIZE DBUS_SESSION_BUS_ADDRESS"

dbus-update-activation-environment --systemd $ENV_TO_IMPORT
systemctl --user import-environment $ENV_TO_IMPORT

unset ENV_TO_IMPORT

systemctl --user --wait start i3-session.service
systemctl --user stop graphical-session.target
