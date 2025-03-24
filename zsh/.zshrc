export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.utf8

export FZF_DEFAULT_OPTS='--bind=ctrl-u:preview-up+preview-up,ctrl-d:preview-down+preview-down'
export PATH="$(dirname $(realpath "$0"))/scripts:$PATH"

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

alias grepi='grep -i'

alias xc='xclip -selection clipboard'
alias xp='xclip -selection clipboard -o'
alias hc='fc -ln -1 | tr -d "\n" | xcopy'

#scrcpy
alias sscrcpy='scrcpy --turn-screen-off --no-cleanup'
alias scrcpyao='scrcpy --turn-screen-off --no-cleanup --no-video --require-audio >& /dev/null & disown'

# Upgrade
function yayy { sprox 9051 yay $@ }
alias pkgupgrade="sudo pacman -Suyy --noconfirm && yayy -Su --noconfirm"