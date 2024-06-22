export EDITOR=nvim
export VISUAL=nvim

alias fzfd='FZF_DEFAULT_COMMAND="find . -type d -not -path '"'"'*.git*'"'"' -and -not -path '"'"'*node_modules*'"'"'" fzf'
alias fzff='FZF_DEFAULT_COMMAND="find . -type f -not -path '"'"'*.git*'"'"' -and -not -path '"'"'*node_modules*'"'"'" fzf'

alias scrcpy='scrcpy --turn-screen-off --no-cleanup'
alias scrcpyao='scrcpy --no-video'

alias realmerescanmedia='adb shell content call --method scan_volume --uri content://media --arg external_primary'
alias termuxstart='adb -e shell am start -n com.termux/.HomeActivity'
alias discordrecord='pw-record --channels 1 --rate 41000 --target "Chromium" ~/"$(date +%d%m%y%H%M%S).wav"'

alias grepi='grep -i'

alias n=nvim
alias t=tmux
alias pkgupgrade='sudo pacman -Suyy --noconfirm && sudo aura -Akuax --noconfirm'

export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/ssh-agent.socket

# git
fzfgitfile() {
  git log --all --full-history --oneline -- "$1" | \
    fzf --ansi \
      --multi \
      --preview='git show --stat --color {1}; git diff --color {1}' \
      --preview-window='70%' \
      --bind='enter:accept'
}

alias gitfsearch=fzfgitfile
