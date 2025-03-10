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

.ONESHELL:
.SHELLFLAGS = -ec

.PHONY: help
help: ## Print this message
	@# https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: all
all: git nvim tmux zellij zsh ## Install and setup everything

.PHONY: git
git: ## Setup git configuration
	@$(call symlink,${DOTFILES}/git,${GIT})

.PHONY: nvim
nvim: ## Setup neovim configuration
	@$(call symlink,${DOTFILES}/nvim,${NVIM})

.PHONY: tmux
tmux: ## Setup tmux configuration
	@mkdir -p ${TMUX}
	@$(call symlink,${DOTFILES}/tmux/tmux.conf,${TMUX}/tmux.conf)
	@if ! [ -f ${TMUX}/extended.tmux.conf ]; then touch ${TMUX}/extended.tmux.conf; fi

.PHONY: zellij
zellij: ## Setup zellij configuration
	@$(call symlink,${DOTFILES}/zellij,${ZELLIJ})

.PHONY: zsh
zsh: ## Setup zsh configuration
	@$(call symlink,${DOTFILES}/zsh,${ZSH})
	@$(SHELL) ${DOTFILES}/scripts/zsh/zshenv.sh
	@mkdir -p $$HOME/.local/state/zsh

.PHONY: clean
clean: ## Clean symlinks and other files
	@PS3="Select target to clean: "
	select target in $$( grep -E '^clean-.*$$' $(MAKEFILE_LIST) | sed -E 's/^clean-(.*):.*/\1/' ); do
		$(MAKE) --silent clean-$$target
		break
	done

.PHONY: clean-all
clean-all: clean-git clean-nvim clean-tmux clean-zellij clean-zsh

.PHONY: clean-git
clean-git:
	@$(call clean,git,${GIT_CLEAN})

.PHONY: clean-nvim
clean-nvim:
	@$(call clean,nvim,${NVIM_CLEAN})

.PHONY: clean-tmux
clean-tmux:
	@$(call clean,tmux,${TMUX_CLEAN})

.PHONY: clean-zellij
clean-zellij:
	@$(call clean,zellij,${ZELLIJ_CLEAN})

.PHONY: clean-zsh
clean-zsh:
	@$(call clean,zsh,${ZSH_CLEAN})
