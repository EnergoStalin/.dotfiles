# Environment
export EDITOR=nvim
export VISUAL=nvim

export PROXY="http_proxy=http://127.0.0.1:9051 https_proxy=http://127.0.0.1:9051"

alias svim='sudo nvim --clean'
alias v='nvim'
alias t='tmux'

# Aliases
alias ls='ls --color'
alias vim='nvim'
alias c='clear'

#scrcpy
alias sscrcpy='scrcpy -S --no-cleanup'
alias scrcpyao='sscrcpy --no-video --require-audio'

# Android 13
alias realmerescanmedia='adb shell content call --method scan_volume --uri content://media --arg external_primary'
alias termuxstart='adb -e shell am start -n com.termux/.HomeActivity'

alias grepi='grep -i'

# Upgrade
alias yayy="$PROXY yay -Sy"
alias pkgupgrade='sudo pacman -Suyy --noconfirm && yayy && yay -Su --noconfirm'

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
