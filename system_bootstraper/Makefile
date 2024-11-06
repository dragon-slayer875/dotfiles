.PHONY: sudo-timeout mirrors update zsh fonts deps aur-deps install-all git-ssh unpack configs clean
.DEFAULT_GOAL := help

CONFIGS_REPO := git@github.com:dragon-slayer875/dotfiles.git

FONTS := ttf-cascadia-code-nerd \
				 noto-fonts-emoji

DEPS := git \
				ffmpeg \
				kitty \
				go \
				neovim \
				xclip \
				ripgrep \
				fd \
				fzf \
				zoxide \
				eza \
				yt-dlp \
				zsh \
				stow \
				yay

AUR_DEPS := envycontrol \
						visual-studio-code-bin \
						heroic-games-launcher-bin \
						google-chrome \
						postman-bin \
						googledot-cursor-theme

sudo-timeout: ## Changes sudo timeout
	sudo EDITOR=vi visudo

mirrors: ## Updates mirrors
	sudo reflector --verbose --age 2 --latest 10 --sort rate --save /etc/pacman.d/mirrorlist

update: mirrors ## Updates mirrors and then the whole system
	sudo pacman --no-confirm -Syu

zsh: ## Changes default shell to zsh and installs ohmyzsh
	chsh -s $(which zsh)
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

fonts: ## Installs fonts
	sudo pacman --no-confirm --needed -S $(FONTS)

deps: ## Installs packages from arch repos
	sudo pacman --no-confirm --needed -S $(DEPS)

aur-deps: ## Installs packages from AUR
	yay --needed -S $(AUR_DEPS)

install-all: update fonts deps ## Installs all updates and non GUI packages
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash

git-ssh: ## Sets some general git values and sets up ssh for git
	@if [ -z "$${GIT_USER_NAME}" ] || [ -z "$${GIT_USER_EMAIL}" ]; then \
		echo "Environment variables GIT_USER_NAME and GIT_USER_EMAIL must be set."; \
		echo "Please set them in an .env file or as environment variables when running this target."; \
	else \
		git config --global user.name "$${GIT_USER_NAME}"; \
		git config --global user.email "$${GIT_USER_EMAIL}"; \
		git config --global init.defaultBranch main; \
		git config --global color.ui auto; \
		ssh-keygen -t ed25519 -N ""; \
		cat ~/.ssh/id_ed25519.pub; \
		echo "Go to https://github.com/settings/keys and paste the key in there"; \
		echo "`ssh -T git@github.com` this is for testing the ssh connection"; \
	fi

unpack: install-all ## Installs all non GUI based packages, changes shell and sets config files
	make zsh
	make configs

configs: ## Clones config repo and uses stow to put the files at the right locations
	git clone $(CONFIGS_REPO)
	cd dotfiles
	stow zsh
	stow kitty
	stow nvim
	nvm install --lts
	nvm use --lts

clean: ## Cleans required directories based on mode
ifeq ($(mode), nvim)
	rm -rf ~/.config/nvim
	rm -rf ~/.local/state/nvim
	rm -rf ~/.local/share/nvim
	rm -rf ~/.cache/nvim
else
	# Set a cleaning mode by setting 'mode' variable
endif

help: ## Prints help for targets with comments
	@cat $(MAKEFILE_LIST) | grep -E '^[a-zA-Z_-]+:.*?## .*$$' | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
