# zsh stuff
alias zshrc="cd $ZDOTDIR && $EDITOR $ZDOTDIR/.zshrc ; cd - &> /dev/null"
alias rezsh="source $ZDOTDIR/.zshrc"
alias aliases="cd $ZDOTDIR && $EDITOR config/aliases.zsh ; cd - &> /dev/null"
alias extal="cd $ZDOTDIR && $EDITOR extended_aliases.zsh ; cd - &> /dev/null"

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
alias gs="git status"
alias gd="git diff"
alias gu="git add -u"
alias gl="git log --oneline"
alias gg="lazygit"
alias gst="git stash"

function gc() {
    if [ $# -eq 0 ] && command -v fzf &> /dev/null; then
        local selected=`git branch --color | fzf --height=~30% --ansi | sed -E 's/^\*?\s*//' | sed -E 's/\s*$//'`
        if [ -z $selected ]; then return 1; fi
        git checkout $selected
    else
        git checkout "$@"
    fi
}

function gr() {
    if [ $# -eq 0 ] && command -v fzf &> /dev/null; then
        local selected=`git log --oneline --decorate --color | fzf --height=~30% --reverse --ansi | sed -E 's/\s.*//'`
        if [ -z $selected ]; then return 1; fi
        git rebase --interactive $selected
    else
        git rebase --interactive "$@"
    fi
}

# nvim
alias nv="nvim"
alias oil="VIM_NO_SESSION_LOAD=1 nvim ."

# Other
alias c="clear"
alias x="exit 0"
alias mv="mv -i"
alias sqlite3="sqlite3 -init $XDG_CONFIG_HOME/sqlite3/sqliterc"
alias sqlite="sqlite3"
alias tm="tmux -f ~/.config/tmux/tmux.conf new -A -s shell"
alias wget='wget --hsts-file="$XDG_DATA_HOME/wget-hsts"'
