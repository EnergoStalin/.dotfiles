export EDITOR=vim
export VISUAL=vim

export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/ssh-agent.socket

if [[ -z "$(mount | grep gdrive)" ]]; then
    rclone mount --daemon gdrive: ~/remote/gdrive
fi
