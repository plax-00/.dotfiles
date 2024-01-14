if command -v nvim &> /dev/null; then
    ALIAS_EDITOR=nvim
else
    ALIAS_EDITOR=vim
fi

# zsh stuff
alias zshrc="cd $ZDOTDIR && $ALIAS_EDITOR $ZDOTDIR/.zshrc ; cd - &> /dev/null"
alias rezsh="source $ZDOTDIR/.zshrc"
alias aliases="cd $ZDOTDIR && $ALIAS_EDITOR aliases.zsh ; cd - &> /dev/null"
alias extal="cd $ZDOTDIR && $ALIAS_EDITOR extended_aliases.zsh ; cd - &> /dev/null"

function makedots() { cd ~/.dotfiles && make $1 ; cd - &> /dev/null }

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
alias dusa='du -hs $(ls -A) | sort -hr'
alias du="du -h"
alias df="df -h"

# git
alias gc="git checkout"
alias gs="git status"
alias gd="git diff"
alias gu="git add -u"
alias gl="git log --oneline"
alias gr="git rebase --interactive"
alias gg="lazygit"
alias gst="git stash"

# cd
alias ..2="../.."
alias ..3="../../.."
alias ..4="../../../.."
alias ..5="../../../../.."
alias ..6="../../../../../.."
alias ..7="../../../../../../.."

# Other
alias c="clear"
alias x="exit 0"
alias mv="mv -i"
alias sqlite3="sqlite3 -init $XDG_CONFIG_HOME/sqlite3/sqliterc"
alias sqlite="sqlite3"
alias tm="tmux -f ~/.config/tmux/tmux.conf new -A -s shell"
alias nv="nvim"
alias wget='wget --hsts-file="$XDG_DATA_HOME/wget-hsts"'
