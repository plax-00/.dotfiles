SHELL := bash
DOTFILES := $$HOME/.dotfiles
GIT := $$HOME/.config/git
NVIM := $$HOME/.config/nvim
TMUX := $$HOME/.config/tmux
ZELLIJ := $$HOME/.config/zellij
ZSH := $$HOME/.config/zsh

GIT_CLEAN = ${GIT}
NVIM_CLEAN = ${NVIM} $$HOME/.local/share/nvim
TMUX_CLEAN = ${TMUX}/tmux.conf
ZELLIJ_CLEAN = ${ZELLIJ}
ZSH_CLEAN = ${ZSH} $$HOME/.cache/antidote

symlink = ln -invs $(1) $(2) || true
clean = echo "Cleaning $(1)... " ; rm -rf $(2) && echo "Done"

.PHONY: help all git nvim tmux zellij zsh clean clean-all clean-git clean-nvim clean-tmux clean-zellij clean-zsh

.ONESHELL:
.SHELLFLAGS = -ec

help: ## Print this message
	@# https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

all: git nvim tmux zellij zsh ## Install and setup everything

git: ## Setup git configuration
	@$(call symlink,${DOTFILES}/git,${GIT})

nvim: ## Setup neovim configuration
	@$(call symlink,${DOTFILES}/nvim,${NVIM})

tmux: ## Setup tmux configuration
	@mkdir -p ${TMUX}
	@$(call symlink,${DOTFILES}/tmux/tmux.conf,${TMUX}/tmux.conf)
	@if ! [ -f ${TMUX}/extended.tmux.conf ]; then touch ${TMUX}/extended.tmux.conf; fi

zellij: ## Setup zellij configuration
	@$(call symlink,${DOTFILES}/zellij,${ZELLIJ})

zsh: ## Setup zsh configuration
	@$(call symlink,${DOTFILES}/zsh,${ZSH})
	@$(SHELL) ${DOTFILES}/scripts/zsh/zshenv.sh
	@mkdir -p $$HOME/.local/state/zsh

clean: ## Clean symlinks and other files
	@PS3="Select target to clean: "
	select target in $$( grep -E '^clean-.*$$' $(MAKEFILE_LIST) | sed -E 's/^clean-(.*):.*/\1/' ); do
		$(MAKE) --silent clean-$$target
		break
	done

clean-all: clean-git clean-nvim clean-tmux clean-zellij clean-zsh

clean-git:
	@$(call clean,git,${GIT_CLEAN})

clean-nvim:
	@$(call clean,nvim,${NVIM_CLEAN})

clean-tmux:
	@$(call clean,tmux,${TMUX_CLEAN})

clean-zellij:
	@$(call clean,zellij,${ZELLIJ_CLEAN})

clean-zsh:
	@$(call clean,zsh,${ZSH_CLEAN})
