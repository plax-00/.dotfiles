# https://thevaluable.dev/zsh-completion-guide-examples/
# :completion:<function>:<completer>:<command>:<argument>:<tag>

zmodload zsh/complist
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"

zstyle ':completion:*' completer _complete _ignored
zstyle ':completion:*' format '%F{yellow}%B%U%d:%u%f%b'
zstyle ':completion:*' menu select=2
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ${(s.:.)${LS_COLORS}}
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
