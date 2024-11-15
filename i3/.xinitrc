ENV_TO_IMPORT="EDITOR VISUAL PNPM_HOME PATH DISPLAY XAUTHORITY GTK_THEME XCURSOR_SIZE DBUS_SESSION_BUS_ADDRESS"

dbus-update-activation-environment --systemd $ENV_TO_IMPORT

systemctl --user import-environment $ENV_TO_IMPORT
systemctl --user --wait start i3-session.service
systemctl --user stop graphical-session.target
