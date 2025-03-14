export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.utf8

eval $(starship init zsh)

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Load starship theme
# line 1: `starship` binary as command, from github release
# line 2: starship setup at clone(create init.zsh, completion)
# line 3: pull behavior same as clone, source init.zsh
zinit ice as"command" from"gh-r" \
          atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
          atpull"%atclone" src"init.zsh"
zinit light starship/starship

# Add in snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::command-not-found

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

# Source yazi wrapper if exists
[[ -f ~/.config/yazi/wrapper.sh ]] && source ~/.config/yazi/wrapper.sh

# Aliases
alias svim="sudo -E HOME='$HOME' nvim"

alias ls='ls --color'
alias ll='ls -l'
alias la='ls -a'
alias lla='ll -a'
alias vim='nvim'
alias vimp='vim +"set nomodified"'

#scrcpy
alias sscrcpy='scrcpy --turn-screen-off --no-cleanup'
alias scrcpyao='nohup scrcpy --turn-screen-off --no-cleanup --no-video --require-audio >& /dev/null &'

# Android 13
alias realmerescanmedia='adb shell content call --method scan_volume --uri content://media --arg external_primary'

function adbintent {
  adb shell dumpsys package $1 | grep -m 1 -A1 android.intent.action.MAIN | awk 'NR==2 {print $2}'
}

alias droidcam='APP=com.dev47apps.droidcam; adb shell am start-activity -W $(adbintent $APP) >& /dev/null && sleep 2 && droidcam-cli -size=1920x1080 -v adb 4747 && adb shell am force-stop $APP && unset APP'
alias realmeaudiobook='adb shell "svc bluetooth enable && am start-activity -W $(adbintent de.ph1b.audiobook) && input keyevent 26"'

alias grepi='grep -i'

alias feh='feh --auto-zoom --scale-down'

# Upgrade
function LOCAL_PROXY {
  local proxy="http://127.0.0.1:$1"
  echo "http_proxy=$proxy https_proxy=$proxy all_proxy=$proxy"
}
function yayy {
  eval "$(LOCAL_PROXY 9051) yay $@"
}
alias pkgupgrade="sudo pacman -Suyy --noconfirm && yayy -Su --noconfirm"

# fzf
export FZF_DEFAULT_OPTS='--bind=ctrl-u:preview-up+preview-up,ctrl-d:preview-down+preview-down'

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
