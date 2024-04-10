export GTK_THEME=Adwaita:dark
export XCURSOR_SIZE=24

dbus-update-activation-environment --systemd DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_DESKTOP XDG_SESSION_TYPE

exec i3
