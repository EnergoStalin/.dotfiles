export EDITOR=vim
export VISUAL=vim

alias fzfd='FZF_DEFAULT_COMMAND="find . -type d -not -path '"'"'*.git*'"'"' -and -not -path '"'"'*node_modules*'"'"'" fzf'
alias fzff='FZF_DEFAULT_COMMAND="find . -type f -not -path '"'"'*.git*'"'"' -and -not -path '"'"'*node_modules*'"'"'" fzf'

alias scrcpy='scrcpy --turn-screen-off --no-cleanup'
alias scrcpyao='scrcpy --no-video'

export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/ssh-agent.socket

if [[ -z "$(mount | grep 'gdrive')" ]]; then
    rclone mount --daemon --drive-use-trash=false gdrive: ~/remote/gdrive
fi

if [[ -z "$(mount | grep '/yd')" ]]; then
    rclone mount --daemon --yandex-hard-delete yd: ~/remote/yd
fi

if [[ -z "$(mount | grep 'gdshared')" ]]; then
    rclone mount --daemon --drive-shared-with-me 'gdrive:' ~/remote/gdshared
fi

