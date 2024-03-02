export EDITOR=nvim
export VISUAL=nvim

alias fzfd='FZF_DEFAULT_COMMAND="find . -type d -not -path '"'"'*.git*'"'"' -and -not -path '"'"'*node_modules*'"'"'" fzf'
alias fzff='FZF_DEFAULT_COMMAND="find . -type f -not -path '"'"'*.git*'"'"' -and -not -path '"'"'*node_modules*'"'"'" fzf'

alias scrcpy='scrcpy --turn-screen-off --no-cleanup'
alias scrcpyao='scrcpy --no-video'
alias cwd='pwd | xclip -selection clipboard'

export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/ssh-agent.socket

