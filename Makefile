.PHONY: check-env install-mac

export PATH := /opt/homebrew/bin:/usr/local/bin:$(PATH)

-include .env
export

DOTFILES := $(CURDIR)
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
