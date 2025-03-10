#!/usr/bin/env bash

if [ -n "$(env -i zsh -c 'echo $ZDOTDIR')" ]; then
    exit 0
fi

zshenv='if [[ -z "$XDG_CONFIG_HOME" ]] then;
    export XDG_CONFIG_HOME="$HOME/.config"
fi

if [[ -d "$XDG_CONFIG_HOME/zsh" ]] then;
    export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
fi'

sudo_prompt() {
    local reply
    read -rp "Edit system-wide config? [y/N]: " reply
    case $reply in
        [Yy])
            sudo -k
            sudo -v
            ;;
        *)
            false
            ;;
    esac
}

if sudo_prompt; then
    echo "$zshenv" | sudo tee -a /etc/zsh/zshenv &> /dev/null
else
    echo "$zshenv" >> "$HOME/.zshenv"
fi
