. ~/.profile

export GTK_THEME=Adwaita:dark
export XCURSOR_SIZE=24

systemctl --user import-environment DISPLAY XAUTHORITY GTK_THEME XCURSOR_SIZE
systemctl start --user --wait i3-session.service
