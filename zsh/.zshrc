###############################
#           Options           #
###############################

setopt auto_cd
setopt extended_glob
setopt hist_ignore_all_dups   # remove older duplicate entries from history
setopt hist_reduce_blanks     # remove superfluous blanks from history items
setopt hist_ignore_space      # ignores commands with a leading space
setopt hist_no_functions      # no function definitions in history
setopt hist_verify            # verify !! expansion
setopt share_history          # share history between shell instances
setopt correct                # spellcheck commands
setopt correct_all            # spellcheck arguments too
setopt menu_complete          # automatically open completion menu on ambiguous completions

# completion settings
source $ZDOTDIR/config/completion.zsh

# autoload functions
fpath+=$ZDOTDIR/functions
autoload -Uz $ZDOTDIR/functions/**/*(.N) &> /dev/null
for widget in $ZDOTDIR/functions/zle/*(.N); do
    zle -N $(basename $widget)
done


###############################
#           Plugins           #
###############################

# bootstrap antidote
ANTIDIR=${ZDOTDIR:-~}/antidote
if [[ ! -d $ANTIDIR ]]; then
    git clone --depth=1 https://github.com/mattmc3/antidote.git $ANTIDIR
fi

# load plugins
zstyle ':antidote:bundle' use-friendly-names on
source $ANTIDIR/antidote.zsh
antidote load $ZDOTDIR/config/plugins.txt $ANTIDIR/plugins.zsh

# Pure theme
autoload promptinit; promptinit
prompt pure

# Autosuggest settings
bindkey '`' autosuggest-accept
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# History substring search settings
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# edit commands in vim with history
function zvm_after_lazy_keybindings() {
    zvm_define_widget edit-command-line-history
    zvm_bindkey vicmd 'V' edit-command-line-history
}

# fzf
if command -v fzf &> /dev/null; then
    fzf --zsh &> /dev/null && source <(fzf --zsh)

    bindkey '^O' fzf-cd-widget
    bindkey '^K' fzf-file-widget
    export FZF_ALT_C_COMMAND="find . $HOME -type d"
    export FZF_CTRL_T_COMMAND="find . $HOME"

    if command -v fdfind &> /dev/null; then
        export FZF_ALT_C_COMMAND="fdfind . $HOME --type d --hidden"
        export FZF_CTRL_T_COMMAND="fdfind . $HOME --hidden"
    fi

    if command -v fd &> /dev/null; then
        export FZF_ALT_C_COMMAND="fd . $HOME --type d --type l --hidden"
        export FZF_CTRL_T_COMMAND="fd . $HOME --hidden"
    fi

fi


###############################
#        Miscellaneous        #
###############################

# Aliases
source $ZDOTDIR/config/aliases.zsh

# Extended config
for ext in $XDG_CONFIG_HOME/extended/zsh/*(N) ; do
    source $ext
done

# zoxide
if zoxide --version &> /dev/null; then
    eval "$(zoxide init --cmd cd zsh)"
    bindkey '^O' zoxide-query
fi
