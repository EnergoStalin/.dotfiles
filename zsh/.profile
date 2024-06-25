# Environment
export EDITOR=nvim
export VISUAL=nvim
export GTK_THEME=Adwaita:dark
export XCURSOR_SIZE=24

# Scrcpy
alias scrcpy='scrcpy --turn-screen-off --no-cleanup'
alias scrcpyao='scrcpy --no-video'

# Android 13
alias realmerescanmedia='adb shell content call --method scan_volume --uri content://media --arg external_primary'
alias termuxstart='adb -e shell am start -n com.termux/.HomeActivity'


alias grepi='grep -i'
alias n=nvim
alias t=tmux

# Upgrade
alias pkgupgrade='sudo pacman -Suyy --noconfirm && sudo aura -Akuax --noconfirm'

# fzf
export FZF_DEFAULT_OPTS='--bind=ctrl-u:preview-up+preview-up,ctrl-d:preview-down+preview-down'

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
