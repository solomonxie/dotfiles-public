# tmux

- `tmux.conf` -> `~/.tmux.conf`
- `com.local.tmux.plist` -> `~/Library/LaunchAgents/` (copied by ansible macos role)

## Why use launchd to manage Tmux Server?

Which ever terminal we launch Tmux server, MacOS treats it as "Coalition", even if the pid is detached, when the terminal app is fully quit or foced quit, the Tmux server will be killed as well.
So we use Launchd to launch tmux server instead, which won't build coalition with Terminal apps.

- launchd jobs get a bare PATH, so the plist sets one; otherwise tpm/resurrect silently fail to load
- bare `tmux -D` only loads tmux.conf on first client contact; the job runs `tmux start-server` to trigger it, and continuum then restores
- ansible installs the file only; it never loads it (a running default server would make the job respawn-loop)

Migrate once: `Prefix Ctrl-s`, `tmux kill-server`, then

```sh
launchctl bootstrap gui/$(id -u) ~/Library/LaunchAgents/com.local.tmux.plist
launchctl bootout gui/$(id -u)/com.local.tmux      # stop
launchctl kickstart -k gui/$(id -u)/com.local.tmux # restart
launchctl print gui/$(id -u)/com.local.tmux        # status
```

After editing the plist: `bootout` then `bootstrap`.
