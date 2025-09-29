# make aliases work with sudo
alias sudo='sudo '
alias S='sudo $(print ${history[@][1]})'

alias dots="cd ~/.dotfiles && $EDITOR ; cd - &> /dev/null"
function makedots() {
    make -sC $HOME/.dotfiles $1
}

# globals
alias -g L="| less"
alias -g G="| grep"
alias -g Gi="| grep -i"
alias -g C="--color=always"

# ls
alias ls="eza"
alias l="ls -lA"
alias la="ls -A"
alias lo="ls -lo"

# grep
alias egrep="egrep --color=auto"
alias fgrep="fgrep --color=auto"
alias grep="grep --color=auto -P"

# du and df
alias dus="du -hs (*|.*) | sort -hr"
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
alias oil="nvim ."

function clean-sessions () {
    for session in $XDG_DATA_HOME/nvim/sessions/*; do
        local bname=$(basename $session)
        [[ -d $(echo $bname | sed 's/__/\//g') ]] || (rm -rf "$session" && echo "removed $bname")
    done
}

# typst
function typ () {
    if [ $# -eq 0 ]; then return 1; fi

    local pdf="$1.pdf"
    local typ="$1.typ"

    if [ ! -f $typ ]; then return 1; fi

    if [ ! -f $pdf ]; then
        typst compile $typ
    fi

    local pid=$(&> /dev/null zathura $pdf & echo "$!")
    trap "kill $pid" EXIT
    nvim $typ
}

# Other
alias c="clear"
alias x="exit 0"
alias mv="mv -i"
alias sqlite="sqlite3"
alias wget='wget --hsts-file="$XDG_DATA_HOME/wget-hsts"'

function mkc() {
    if [ $# -eq 0 ]; then return 1; fi
    mkdir -p "$1" && cd "$1"
}
