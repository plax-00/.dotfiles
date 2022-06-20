#!/usr/bin/bash

dotfiles=(.zshrc .vimrc .tmux.conf)

function main() {
	# Create symlinks in home directory
	for file in "${dotfiles[@]}"; do
		if [ -f ~/$file ]; then
			mv ~/$file ~/$file.old
		fi
		ln -s ~/.dotfiles/$file ~/$file
	done

	# Install zsh plugins and create aliases symlink
	mkdir -p ~/.zsh
	cd ~/.zsh
	git clone https://github.com/sindresorhus/pure.git

	ln -s ~/.dotfiles/aliases.zsh ~/.zsh/aliases.zsh

	mkdir -p ~/.zsh/plugins
	cd ~/.zsh/plugins
	git clone https://github.com/zsh-users/zsh-autosuggestions.git
	git clone https://github.com/zsh-users/zsh-history-substring-search.git
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git

	# Install tmux theme
	mkdir -p ~/.tmux
	cd ~/.tmux
	git clone https://github.com/khanghh/tmux-dark-plus-theme.git

	# Install vim-plug and theme
	mkdir -p ~/.vim
	cd ~/.vim
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	vim -E -c PlugInstall -c qall &> /dev/null

	# Create empty extended files if they don't exist
	if ! [ -f ~/.zsh/extended.zshrc ]; then touch ~/.zsh/extended.zshrc; fi
	if ! [ -f ~/.zsh/extended_aliases.zsh ]; then touch ~/.zsh/extended_aliases.zsh; fi
	if ! [ -f ~/.tmux/extended.tmux.conf ]; then touch ~/.tmux/extended.tmux.conf; fi
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
	main
else
	read -p "This is intended to be run as an initial install of dotfiles and plugins. Continue? (y/n) " -n 1
	echo ""
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		main
	fi
fi

unset dotfiles
unset main
