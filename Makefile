SHELL := bash
DOTFILES := ~/.dotfiles
GIT := ~/.config/git
NVIM := ~/.config/nvim
TMUX := ~/.config/tmux
ZELLIJ := ~/.config/zellij
ZSH := ~/.config/zsh

GIT_CLEAN = ${GIT}
NVIM_CLEAN = ${NVIM} ~/.local/share/nvim
TMUX_CLEAN = ${TMUX}/tmux.conf ${TMUX}/themes
ZELLIJ_CLEAN = ${ZELLIJ}
ZSH_CLEAN = ${ZSH}/.zshrc ${ZSH}/.zprofile ${ZSH}/aliases.zsh ${ZSH}/plugins ${ZSH}/themes ~/.zshenv

symlink = ln -invs $(1) $(2) || true
clean = echo "Cleaning... " ; rm -rf $(1) && echo "Done"

.PHONY: help git nvim tmux zellij zsh clean-nvim clean-tmux clean-zsh

help: ## Print this message
	@# https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

all: nvim git tmux zsh ## Install everything with neovim as editor

git: ## Setup git configuration
	@$(call symlink, ${DOTFILES}/git, ${GIT})

nvim: ## Setup neovim configuration
	@$(call symlink, ${DOTFILES}/nvim, ${NVIM})

tmux: ## Setup tmux configuration
	@mkdir -p ${TMUX}
	@$(call symlink, ${DOTFILES}/tmux/tmux.conf, ${TMUX}/tmux.conf)
	@$(call symlink, ${DOTFILES}/tmux/plugins, ${TMUX}/plugins)
	@if ! [ -f ${TMUX}/extended.tmux.conf ]; then touch ${TMUX}/extended.tmux.conf; fi

zellij: ## Setup zellij configuration
	@$(call symlink, ${DOTFILES}/zellij, ${ZELLIJ})

zsh: ## Setup zsh configuration
	@echo 'export ZDOTDIR=$$HOME/.config/zsh' > ~/.zshenv
	@$(call symlink, ${DOTFILES}/zsh/zshrc, ${ZSH}/.zshrc)
	@$(call symlink, ${DOTFILES}/zsh/zprofile, ${ZSH}/.zprofile)
	@$(call symlink, ${DOTFILES}/zsh/config, ${ZSH}/config)
	@$(call symlink, ${DOTFILES}/zsh/functions, ${ZSH}/functions)
	@$(call symlink, ${DOTFILES}/zsh/plugins, ${ZSH}/plugins)
	@$(call symlink, ${DOTFILES}/zsh/themes, ${ZSH}/themes)
	@if ! [ -f ${ZSH}/extended.zshrc ]; then touch ${ZSH}/extended.zshrc; fi
	@if ! [ -f ${ZSH}/extended_aliases.zsh ]; then touch ${ZSH}/extended_aliases.zsh; fi
	@mkdir -p ~/.local/state/zsh

clean-git: ## Remove git symlinks
	@$(call clean, ${GIT_CLEAN})

clean-nvim: ## Remove neovim symlinks and plugins
	@$(call clean, ${NVIM_CLEAN})

clean-tmux: ## Remove tmux symlinks and plugins
	@$(call clean, ${TMUX_CLEAN})

clean-zellij: ## Remove zellij symlinks
	@$(call clean, ${ZELLIJ_CLEAN})

clean-zsh: ## Remove zsh symlinks and plugins
	@$(call clean, ${ZSH_CLEAN})
