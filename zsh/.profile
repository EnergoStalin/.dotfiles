export EDITOR=nvim
export VISUAL=nvim

alias fzfd='FZF_DEFAULT_COMMAND="find . -type d -not -path '"'"'*.git*'"'"' -and -not -path '"'"'*node_modules*'"'"'" fzf'
alias fzff='FZF_DEFAULT_COMMAND="find . -type f -not -path '"'"'*.git*'"'"' -and -not -path '"'"'*node_modules*'"'"'" fzf'

alias scrcpy='scrcpy --turn-screen-off --no-cleanup'
alias scrcpyao='scrcpy --no-video'

alias termuxstart='adb -e shell am start -n com.termux/.HomeActivity'
alias discordrecord='pw-record --channels 1 --rate 41000 --target "Chromium" ~/"$(date +%d%m%y%H%M%S).wav"'

alias cwd='pwd | xclip -selection clipboard'
alias grepi='grep -i'

alias n=nvim
alias t=tmux
alias pkgupgrade='sudo pacman -Suyy --noconfirm && sudo aura -Akuax --noconfirm'

export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/ssh-agent.socket

