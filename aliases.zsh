if command -v nvim &> /dev/null; then
    ALIAS_EDITOR=nvim
else
    ALIAS_EDITOR=vim
fi

# zsh stuff
alias zshrc="$ALIAS_EDITOR ~/.zshrc"
alias rezsh="source ~/.zshrc"
alias aliases="$ALIAS_EDITOR ~/.zsh/aliases.zsh"

# ls
alias ls="ls --color=auto"
alias l="ls -lAh"
alias la="ls -A"
alias lo="ls -loh"

# grep
alias egrep="egrep --color=auto"
alias fgrep="fgrep --color=auto"
alias grep="grep --color=auto -P"

# du and df
alias dus="du -hs * | sort -hr"
alias du="du -h"
alias df="df -h"

# git
alias gc="git checkout"
alias gs="git status"
alias gd="git diff"
alias gu="git add -u"

# cd
alias ..2="../.."
alias ..3="../../.."
alias ..4="../../../.."
alias ..5="../../../../.."
alias ..6="../../../../../.."
alias ..7="../../../../../../.."

# Other
alias c="clear"
alias sqlite="sqlite3"
alias x="exit 0"
alias tm="tmux new -A -s shell"
alias nv="nvim"

