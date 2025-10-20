#!/usr/bin/env bash

[[ -n "$(env -i zsh -c 'echo $ZDOTDIR')" ]] && exit 0

read -d '' zshenv << 'EOF'
[[ -z "$XDG_CONFIG_HOME" ]] && export XDG_CONFIG_HOME="$HOME/.config"
[[ -d "$XDG_CONFIG_HOME/zsh" ]] && export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
EOF

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
    echo "$zshenv" > "$HOME/.zshenv"
fi
