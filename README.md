# dotfiles-public

Scrubbed mirror of my dotfiles for bootstrapping a new Mac: Homebrew, Neovim, zsh, tmux, iTerm2.

## Setup

```sh
xcode-select --install
git clone https://github.com/solomonxie/dotfiles-public
cd dotfiles-public
make install-mac
```

- `make check-env` runs first: prompts for any missing value (defaults from `id -un` / git config), writes `.env`, rejects a username mismatch
- Clone anywhere; install links the checkout to `~/.dotfiles`, the stable path the configs source from
- `~/.ssh` and `~/.config` are left untouched
- No sudo; everything stays in the user's Homebrew

| Path | Content |
|---|---|
| `ansible/roles/macos` | packages, system defaults, symlinks, iTerm2 prefs (`manual/` = shell equivalent) |
| `zsh/` `vim/` `tmux/` `etc/` | shell, Neovim, tmux, git/tig configs |

Left out vs the private repo: terraform/AWS, cloud scripts, legacy Linux roles, the headless-server role, secrets (`.env`, SSH keys, tokens).
