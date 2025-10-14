# XDG directories
export XDG_DATA_HOME=$HOME/.local/share
export XDG_CONFIG_HOME=$HOME/.config
export XDG_STATE_HOME=$HOME/.local/state
export XDG_CACHE_HOME=$HOME/.cache
export XDG_RUNTIME_DIR=/run/user/$UID

# docker
export DOCKER_CONFIG=$XDG_CONFIG_HOME/docker

# go
export GOPATH="$XDG_DATA_HOME"/go
export GOMODCACHE="$XDG_CACHE_HOME"/go/mod

# less
export LESSHISTFILE=$XDG_CACHE_HOME/less/history
export LESSUTFCHARDEF=E000-F8FF:p,F0000-FFFFD:p,100000-10FFFD:p
export LESS="-Ri"

# ls (disable ugly folder highlighting)
eval ${(S)$(dircolors)/:ow=*:/:ow=01;34:}

# npm
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/config
export NPM_CONFIG_CACHE=$XDG_CACHE_HOME/npm
export NPM_CONFIG_PREFIX=$XDG_DATA_HOME/npm

# python
export PYTHON_COLORS=1
export PYTHON_HISTORY=$XDG_STATE_HOME/python_history

# rust
export CARGO_HOME=$XDG_DATA_HOME/cargo
export RUSTUP_HOME=$XDG_DATA_HOME/rustup

# sqlite
export SQLITE_HISTORY=$XDG_CACHE_HOME/sqlite_history

if command -v nvim &> /dev/null; then
    export EDITOR=nvim
    export VISUAL=nvim
    export MANPAGER='nvim +Man!'
else
    export EDITOR=vim
    export VISUAL=vim
fi

# zsh
export HISTFILE=$XDG_STATE_HOME/zsh/history
export HISTSIZE=5000
export SAVEHIST=5000
export KEYTIMEOUT=1
export WORDCHARS="${WORDCHARS//\/}"

# GUI
export ELECTRON_OZONE_PLATFORM_HINT="wayland"
export GTK_THEME="Adwaita:dark"

# PATH
path+=($HOME/.local/bin $CARGO_HOME/bin $XDG_DATA_HOME/npm/bin)
export PATH

if uwsm check may-start && [[ -z "$SSH_TTY" ]]; then
    exec uwsm start -- hyprland.desktop
fi
