---
name: add-dotfile
description: Use when adding or changing a configuration file for a tool
  (Git, tmux, shell, editor, window manager, etc.) in my bare-repo dotfiles setup.
---

# Adding or changing a dotfile

## Workflow

1. Inspect before editing:
   - Confirm the file exists.
   - Read its current contents and formatting conventions.
   - Check its Git status with `dotfiles status` or `dotfiles ls-files`.

2. Dotfile-specific standards:
   - Keep machine-specific settings in untracked config files or
     application-supported includes.
   - Track a `config.example` with placeholders when useful.
   - Add local config paths to `.gitignore`.

3. Validate when possible:
   - Zsh: `zsh -n <file>`
   - Bash: use the `write-shell-script` skill.
   - Niri: `niri validate -c ~/.config/niri/config.kdl`
   - Use other native checkers where available.
   - If a checker is unavailable, state which checks were skipped.

4. After changes:
   - Run `dotfiles status`.
   - Run `dotfiles diff` for the relevant files.
   - Report every modified, created, or deleted path.
   - Explain potential side effects and untested assumptions.
