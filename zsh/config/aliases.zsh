# make aliases work with sudo
alias sudo='sudo '
alias s='pushln "sudo $(print ${history[@][1]})"'

alias dots="cd ~/.dotfiles && $EDITOR ; cd - &> /dev/null"
function makedots() {
    make -sC $HOME/.dotfiles $1
}

# globals
alias -g L="| less"
alias -g Lc="--color=always | less"
alias -g G="| grep"
alias -g Gi="| grep -i"
alias -g C="--color=always"
alias -g O="2>&1"
alias -g sot="stdoutisatty"

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

# nvim
alias nv="nvim"
alias oil="nvim ."

function clean-sessions () {
    for session in $XDG_DATA_HOME/nvim/sessions/*; do
        local bname=$(basename $session)
        [[ -d $(echo $bname | sed 's/__/\//g') ]] || (rm -rf "$session" && echo "removed $bname")
    done
}

# Other
alias c="clear"
alias x="exit 0"
alias mv="mv -i"
alias sqlite="sqlite3"
alias wget='wget --hsts-file="$XDG_DATA_HOME/wget-hsts"'


# needs this line in sudoers to work:
# Defaults env_keep += "SNAP_PAC_SKIP"
alias sps="SNAP_PAC_SKIP=y"
