.PHONY: check-env install-mac backup-mac backup-brew backup-vscode

export PATH := /opt/homebrew/bin:/usr/local/bin:$(PATH)

-include .env
export

DOTFILES := $(CURDIR)
MACOS_MANUAL := $(DOTFILES)/ansible/roles/macos/manual
VSCODE_USER := $(HOME)/Library/Application Support/Code/User
VSCODE_CLI := /Applications/Visual Studio Code.app/Contents/Resources/app/bin/code
ANSIBLE_ARGS ?=

LOAD_ENV := set -a; . ./.env; set +a;

check-env:
	@./etc/init_env.sh .env

install-mac: check-env
	@$(LOAD_ENV) \
	if ! command -v brew >/dev/null 2>&1; then \
		if [ -x /opt/homebrew/bin/brew ]; then \
			eval "$$(/opt/homebrew/bin/brew shellenv)"; \
		elif [ -x /usr/local/bin/brew ]; then \
			eval "$$(/usr/local/bin/brew shellenv)"; \
		else \
			echo "==> Homebrew not found. Installing Homebrew..."; \
			/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; \
			if [ -x /opt/homebrew/bin/brew ]; then \
				eval "$$(/opt/homebrew/bin/brew shellenv)"; \
			elif [ -x /usr/local/bin/brew ]; then \
				eval "$$(/usr/local/bin/brew shellenv)"; \
			fi; \
		fi; \
	fi; \
	if ! command -v ansible-playbook >/dev/null 2>&1; then \
		echo "==> Ansible not found. Installing via Homebrew..."; \
		brew install ansible; \
	fi; \
	mkdir -p "$(HOME)/.config"; \
	if [ ! -e "$(HOME)/.dotfiles" ]; then ln -s "$(DOTFILES)" "$(HOME)/.dotfiles"; fi; \
	echo "==> Running Ansible macOS setup..."; \
	cd "$(DOTFILES)/ansible" && ansible-playbook -i inventory.ini site.yml $(ANSIBLE_ARGS)



backup-mac: backup-brew backup-vscode
	@echo "Done. iTerm2 prefs sync automatically on quit (ansible/roles/macos/iterm2/prefs)."

backup-brew:
	brew bundle dump --force --file="$(MACOS_MANUAL)/Brewfile"

backup-vscode:
	mkdir -p "$(MACOS_MANUAL)/vscode"
	cp "$(VSCODE_USER)/settings.json" "$(MACOS_MANUAL)/vscode/settings.json"
	[ -f "$(VSCODE_USER)/keybindings.json" ] && \
		cp "$(VSCODE_USER)/keybindings.json" "$(MACOS_MANUAL)/vscode/keybindings.json" || true
	"$(VSCODE_CLI)" --list-extensions > "$(MACOS_MANUAL)/vscode/extensions.txt"
