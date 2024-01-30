SHELL := bash
DOTFILES := ~/.dotfiles
NVIM := ~/.config/nvim
TMUX := ~/.config/tmux
VIM := ~/.config/vim
VIMFILES := mappings sessions settings
ZSH := ~/.config/zsh

NVIM_CLEAN = ${NVIM}/*.link.vim ${NVIM} ~/.local/share/nvim
TMUX_CLEAN = ${TMUX}/tmux.conf ${TMUX}/themes
VIM_CLEAN = ${VIM}/autoload/plug.vim ${VIM}/plugged ${VIM}
ZSH_CLEAN = ${ZSH}/.zshrc ${ZSH}/.zprofile ${ZSH}/aliases.zsh ${ZSH}/plugins ${ZSH}/themes ~/.zshenv

symlink = ln -invs $(1) $(2) || true
clean = echo "Cleaning... " ; rm -rf $(1) && echo "Done"

.PHONY: help nvim tmux vim zsh clean-nvim clean-tmux clean-vim clean-zsh

help: ## Print this message
	@# https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

all: nvim tmux zsh ## Install everything with neovim as editor

allv: vim tmux zsh ## Install everything with vim as editor

nvim: ## Setup neovim configuration
	@$(call symlink, ${DOTFILES}/nvim, ${NVIM})
	@for file in ${VIMFILES}; do \
		$(call symlink, ${DOTFILES}/vim/$$file.vim, ${NVIM}/$$file.link.vim); \
	done

tmux: ## Setup tmux configuration
	@mkdir -p ${TMUX}
	@$(call symlink, ${DOTFILES}/tmux/tmux.conf, ${TMUX}/tmux.conf)
	@$(call symlink, ${DOTFILES}/tmux/plugins, ${TMUX}/plugins)
	@if ! [ -f ${TMUX}/extended.tmux.conf ]; then touch ${TMUX}/extended.tmux.conf; fi

vim: ## Setup vim configuration
	@$(call symlink, ${DOTFILES}/vim, ${VIM})
	@echo -n "Installing vim-plug... " && \
		curl -fLo ${VIM}/autoload/plug.vim --create-dirs --no-progress-meter \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim && \
		echo "Installed"

zsh: ## Setup zsh configuration
	@echo 'export ZDOTDIR=$$HOME/.config/zsh' > ~/.zshenv
	@$(call symlink, ${DOTFILES}/zsh/zshrc, ${ZSH}/.zshrc)
	@$(call symlink, ${DOTFILES}/zsh/zprofile, ${ZSH}/.zprofile)
	@$(call symlink, ${DOTFILES}/zsh/aliases.zsh, ${ZSH}/aliases.zsh)
	@$(call symlink, ${DOTFILES}/zsh/zle.zsh, ${ZSH}/zle.zsh)
	@$(call symlink, ${DOTFILES}/zsh/plugins, ${ZSH}/plugins)
	@$(call symlink, ${DOTFILES}/zsh/themes, ${ZSH}/themes)
	@if ! [ -f ${ZSH}/extended.zshrc ]; then touch ${ZSH}/extended.zshrc; fi
	@if ! [ -f ${ZSH}/extended_aliases.zsh ]; then touch ${ZSH}/extended_aliases.zsh; fi
	@mkdir -p ~/.local/state/zsh

clean-nvim: ## Remove neovim symlinks and plugins
	@$(call clean, ${NVIM_CLEAN})

clean-tmux: ## Remove tmux symlinks and plugins
	@$(call clean, ${TMUX_CLEAN})

clean-vim: ## Remove vim symlinks and plugins
	@$(call clean, ${VIM_CLEAN})

clean-zsh: ## Remove zsh symlinks and plugins
	@$(call clean, ${ZSH_CLEAN})
