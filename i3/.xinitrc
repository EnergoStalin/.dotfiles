[[ -f ~/.zshenv ]] && . ~/.zshenv
[[ -f ~/.profile ]] && . ~/.profile

export GTK_THEME=Adwaita:dark
export XCURSOR_SIZE=24

systemctl --user import-environment EDITOR VISUAL PNPM_HOME PATH DISPLAY XAUTHORITY GTK_THEME XCURSOR_SIZE
systemctl start --user --wait i3-session.service
