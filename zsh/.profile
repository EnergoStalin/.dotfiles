# Environment
export EDITOR=nvim
export VISUAL=nvim

alias svim='sudo nvim --clean'
alias v='nvim'
alias t='tmux'

#scrcpy
alias sscrcpy='scrcpy -S --no-cleanup'
alias scrcpyao='sscrcpy --no-video --require-audio'

# Android 13
alias realmerescanmedia='adb shell content call --method scan_volume --uri content://media --arg external_primary'
alias termuxstart='adb -e shell am start -n com.termux/.HomeActivity'

alias grepi='grep -i'

# Upgrade
alias pkgupgrade='sudo pacman -Suyy --noconfirm && yay -Syu --noconfirm'

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

if which youtubeuploader > /dev/null; then
  # Upload video to youtube
  ytosusendf() {
    youtubeuploader \
      -title "$1" \
      -filename "$3" \
      -privacy public \
      -tags osu \
      -description \
      "profile: https://osu.ppy.sh/users/12830952\nmap: $2\nskin: baconBoiCK1.0_blue\nhttps://ordr.issou.best/#/skins"
  }

  alias ytosusend=ytosusendf
fi
