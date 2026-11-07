# Dotfiles Agent Instructions

## Environment

- OS: Arch Linux.
- Login shell: zsh.
- Shell scripts: Bash.
- Init system: systemd.
- Dotfiles are managed through a bare Git repository:
  `~/.dotfiles.git`
- The repository uses `$HOME` as its working tree.
- Use the `dotfiles` command to interact with the repository.
- Personal executables belong in `~/.local/bin/`.
- Prefer XDG locations such as `~/.config/` where supported.

## Hard Rules

### Filesystem

- Work directly on my existing dotfiles under `$HOME`.
- Only modify files relevant to the requested task.
- Never access sensitive files or directories, including:
  - `~/.ssh/`
  - `~/.gnupg/`
  - `~/.aws/`
  - Browser profiles and databases.
  - Password-manager data.
  - Application credentials and tokens.
- Never inspect or modify files outside the scope of the task.
- Never overwrite or delete existing files without explicit approval.
- Never create unnecessary backup files or duplicate configurations.
- Never introduce secrets, credentials or tokens into tracked files.

### System Operations

- Never run `sudo`.
- Never run `pacman`, `yay` or `paru`.
- Never run `systemctl` or modify running services.
- Never modify `/etc/`, `/usr/` or `/boot/`.
- Never use destructive commands such as `rm -rf`.
- Never execute remote scripts through `curl | sh`.
- Never perform recursive permission changes.
- If a package, service or system-level change is required, explain why and provide the commands for me to execute.

### Git Operations

- The agent may stage files with `dotfiles add` and commit with `dotfiles commit`.
- Stage and commit only files relevant to the requested task.
- Never stage unrelated pre-existing changes; list them and leave them alone.
- Before committing, show or summarize the staged diff.
- Commit only when the user asks you to commit or approves the changes.
- Never rewrite history (`rebase`, `commit --amend`, `filter-repo`, `stash`) unless explicitly requested.
- Never run other Git write operations, in particular:
  - `dotfiles push`
  - `dotfiles reset`
  - `dotfiles checkout`
- Read-only operations are allowed:
  - `dotfiles status`
  - `dotfiles diff`
  - `dotfiles log`
  - `dotfiles ls-files`

I review the history and push changes myself.

### Plan Mode

For any substantial modification or new implementation (e.g., creating a new script, adding a new feature or cache system, refactoring architecture, or modifying multiple related configuration files):
- Never modify or create files immediately.
- Present a clear, structured plan first (goal, architecture & file layout, design decisions, edge cases, and step-by-step approach).
- Wait for explicit user approval before executing the changes.
- Trivial one-line bug fixes, typo corrections, or minor value adjustments do not require a formal plan.

## Commit Messages

- Use the imperative mood: `add`, `fix`, `remove`, `refactor`.
- Keep the subject short (50 characters or fewer) and lowercase.
- Use `<scope>: <summary>` when a scope helps.
- One logical change per commit.
- Add a body only when the reason is not obvious.
- Avoid vague subjects such as `update` or `changes`.

## Pre-Commit Checklist

- Run `dotfiles status` and `dotfiles diff`.
- Confirm only intended files are staged.
- Check for secrets, credentials, tokens, private IPs, and machine-specific paths.
- Run the relevant validator.
- Use a commit message that follows the conventions above.

## Configuration Standards

- Prefer minimal, targeted changes.
- Preserve existing configuration and conventions.
- Avoid rewriting entire files when a small modification is sufficient.
- Avoid unnecessary dependencies.
- Prefer native application features over additional tools.
- Use XDG locations whenever supported.
- Keep machine-specific settings separate where the application supports configuration includes.
- Keep machine-specific values in untracked config files.
- Track a `config.example` with placeholders when useful.
- Add local config paths to `.gitignore`.
- Comment why something is configured, not simply what it does.
- Do not introduce complexity without a concrete benefit.

## Shell Script Standards

For Bash scripts:

- Use `#!/usr/bin/env bash`.
- Use `set -euo pipefail`.
- Quote variable expansions.
- Prefer `[[ ]]` over `[ ]`.
- Prefer `$(...)` over backticks.
- Use descriptive variable names.
- Make scripts idempotent.
- Check required commands with `command -v`.
- Output stream separation: Send human-facing feedback, logs, warnings, and interactive prompts to stderr (`>&2`). Keep stdout strictly reserved for raw data payloads meant for command substitution (`var=$(...)`).
- Subshell awareness: Remember that subshells (`$(...)`, pipes `|`) cannot modify parent shell variables. Use file-based runtime sync under `${XDG_RUNTIME_DIR:-/tmp}` when state must cross subshell boundaries.
- Temporary file safety: Always use `mktemp` for temporary files and clean them up via `trap 'rm -f "$temp_file"' EXIT`. Never hardcode fixed paths in `/tmp`.
- String and pattern matching: Avoid loose substring globs (e.g., `*Server 1*` colliding with `Server 10`). Use exact matching, regex (`=~`), or delimiter-based fields (`cut`, `awk`).
- URL and path hygiene: Always strip trailing slashes (`${var%/}`) when concatenating paths or URLs to prevent duplicate slashes.
- Process lifecycle: Avoid `exec` when a command or media player is expected to return to a caller, menu, or loop.
- XDG Directory Standard:
  - Config: `${XDG_CONFIG_HOME:-$HOME/.config}/<app>/`
  - State (history, favorites): `${XDG_STATE_HOME:-$HOME/.local/state}/<app>/` or `${XDG_CONFIG_HOME}/<app>/`
  - Cache (ephemeral downloads, API responses): `${XDG_CACHE_HOME:-$HOME/.cache}/<app>/`
  - Runtime (volatile session state): `${XDG_RUNTIME_DIR:-/tmp}/<app>_${UID}/`
- Include meaningful error messages sent to stderr.
- Provide `--dry-run` for operations that modify system state, where practical.
- Avoid destructive operations and broad filesystem modifications.

Scripts should pass:

```bash
bash -n script.sh
shellcheck script.sh
shfmt -d -i 2 script.sh
```
