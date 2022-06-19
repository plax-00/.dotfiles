#tmux
if [ "$TMUX" = "" ]; then tmux new -A -s shell; fi

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=5000
SAVEHIST=5000
setopt autocd extendedglob
bindkey -v
# End of lines configured by zsh-newuser-install

# The following lines were added by compinstall
zstyle :compinstall filename '$HOME/.zshrc' 
autoload -Uz compinit
compinit
# End of lines added by compinstall


######################
# User configuration #
######################

ZSH=$HOME/.zsh

HYPHEN_INSENSITIVE="true"

setopt hist_ignore_all_dups # remove older duplicate entries from history
setopt hist_reduce_blanks # remove superfluous blanks from history items
setopt hist_ignore_space #ignores commands with a leading space

# Pure theme
fpath+=$ZSH/pure
autoload promptinit; promptinit
prompt pure


# Disables ugly folder highlighting
export LS_COLORS=$LS_COLORS:'ow=1;34:';

# Fix vi mode backspace bug
bindkey "^?" backward-delete-char


################## Plugins ##################
ls $ZSH/plugins | while IFS= read -r plugin; do
	source $ZSH/plugins/$plugin/$plugin.zsh
done

# Autosuggest settings
bindkey '`' autosuggest-accept
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# History substring search settings
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

#############################################

# fzf
if command -v fzf &> /dev/null; then
	source /usr/share/doc/fzf/examples/key-bindings.zsh
	source /usr/share/doc/fzf/examples/completion.zsh
	bindkey '^O' fzf-cd-widget
	bindkey '^K' fzf-file-widget
	export FZF_ALT_C_COMMAND="find . $HOME -type d"
	export FZF_CTRL_T_COMMAND="find . $HOME"

	if command -v fdfind &> /dev/null; then
		export FZF_ALT_C_COMMAND="fdfind . $HOME --type d --hidden"
		export FZF_CTRL_T_COMMAND="fdfind . $HOME --hidden"
	fi

fi

# Extended zshrc
source $ZSH/extended.zshrc

# Aliases
source $ZSH/aliases.zsh
if [ -f $ZSH/extended_aliases.zsh ]; then
	source $ZSH/extended_aliases.zsh
fi
