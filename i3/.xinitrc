[[ -f ~/.zshenv ]] && . ~/.zshenv
[[ -f ~/.profile ]] && . ~/.profile

export GTK_THEME=Adwaita:dark
export XCURSOR_SIZE=24

ENV_TO_IMPORT="EDITOR VISUAL PNPM_HOME PATH DISPLAY XAUTHORITY GTK_THEME XCURSOR_SIZE DBUS_SESSION_BUS_ADDRESS"

dbus-update-activation-environment --systemd $ENV_TO_IMPORT

systemctl --user import-environment $ENV_TO_IMPORT
systemctl start --user --wait i3-session.service
