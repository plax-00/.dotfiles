SHELL := bash
DOTFILES := ~/.dotfiles
NVIM := ~/.config/nvim
TMUX := ~/.config/tmux
VIM := ~/.config/vim
VIMFILES := mappings sessions settings
ZSH := ~/.config/zsh

symlink = echo -n "Created symlink: "; ln -fvs $(1) $(2)

.PHONY: help nvim tmux vim vimfiles zsh

help:
	@echo help

nvim: vimfiles
	@$(call symlink, ${DOTFILES}/nvim, ${NVIM})
	@echo -n "Installing vim-plug... " && \
		sh -c 'curl -fLo "$${XDG_DATA_HOME:-$$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim' && \
		echo "Installed"
	@echo -n "Installing plugins... " && \
		nvim -Es -c PlugInstall -c qall || true && \
		echo "Installed"

tmux:
	mkdir -p ${TMUX}
	@$(call symlink, ${DOTFILES}/tmux/tmux.conf, ${TMUX}/tmux.conf)
	git clone https://github.com/khanghh/tmux-dark-plus-theme.git
	if ! [ -f ${TMUX}/extended.tmux.conf ]; then touch ${TMUX}/extended.tmux.conf; fi

vim: vimfiles
	@echo -n "Installing vim-plug... " && \
		curl -fLo ${VIM}/autoload/plug.vim --create-dirs --no-progress-meter \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim && \
		echo "Installed"
	@echo -n "Installing plugins... " && \
		vim -Es -c PlugInstall -c qall || true && \
		echo "Installed"

vimfiles:
	@$(call symlink, ${DOTFILES}/vim, ${VIM})

zsh:
	echo 'ZDOTDIR=$$HOME/.config/zsh' > ~/.zshenv
	mkdir -p ${ZSH}
	cd ${ZSH} && \
	git clone https://github.com/sindresorhus/pure.git
	@$(call symlink, ${DOTFILES}/zsh/zshrc, ${ZSH}/.zshrc)
	@$(call symlink, ${DOTFILES}/zsh/zprofile, ${ZSH}/.zprofile)
	@$(call symlink, ${DOTFILES}/zsh/aliases.zsh, ${ZSH}/aliases.zsh)
	mkdir -p ${ZSH}/plugins
	cd ${ZSH}/plugins && \
	git clone https://github.com/zsh-users/zsh-autosuggestions.git && \
	git clone https://github.com/zsh-users/zsh-history-substring-search.git && \
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
	if ! [ -f ${ZSH}/extended.zshrc ]; then touch ${ZSH}/extended.zshrc; fi
	if ! [ -f ${ZSH}/extended_aliases.zsh ]; then touch ${ZSH}/extended_aliases.zsh; fi
	mkdir -p ~/.local/state/zsh

zsh-clean:
	rm -rf ${ZSH}/.zshrc ${ZSH}/.zprofile ${ZSH}/aliases.zsh ${ZSH}/plugins ${ZSH}/pure


