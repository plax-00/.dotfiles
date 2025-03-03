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

autoload -Uz mkconf


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
export PURE_PROMPT_SYMBOL=
export PURE_PROMPT_VICMD_SYMBOL=

# Autosuggest settings
bindkey '`' autosuggest-accept
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# History substring search settings
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

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
for ext in $ZDOTDIR/extended/*(N) ; do
    source $ext
done

# zoxide
zoxide --version &> /dev/null && eval "$(zoxide init --cmd cd zsh)"
