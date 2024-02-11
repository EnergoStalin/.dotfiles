export EDITOR=vim
export VISUAL=vim

export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/ssh-agent.socket

if [[ -z "$(mount | grep 'gdrive')" ]]; then
    rclone mount --daemon --drive-use-trash=false gdrive: ~/remote/gdrive
fi

if [[ -z "$(mount | grep '/yd')" ]]; then
    rclone mount --daemon --yandex-hard-delete yd: ~/remote/yd
fi
