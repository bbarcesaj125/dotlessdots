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

## Skills

- Use `add-dotfile` when changing a tracked dotfile.
- Use `write-shell-script` when writing or modifying a Bash script.
- Use `commit` when staging or committing changes.
- Load the relevant skill before starting; its task-specific workflow
  complements these global rules.

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
- Commit only when the user asks you to commit or approves the changes.
- Follow the `commit` skill for grouping, messages, and pre-commit checks.
- Never rewrite history (`rebase`, `commit --amend`, `filter-repo`, `stash`) unless explicitly requested.
- Never run destructive Git write operations:
  - `dotfiles reset`
  - `dotfiles checkout`
- Read-only operations are allowed:
  - `dotfiles status`
  - `dotfiles diff`
  - `dotfiles log`
  - `dotfiles ls-files`

### Pushing

- Never push automatically.
- When a task is complete and committed, offer to push the commit.
- If I explicitly approve the push, execute `dotfiles push`.
- Never push without explicit approval for that specific operation.
- Approval to commit is not approval to push, and approval for one push does not cover later commits.
- Run `dotfiles push` as a standalone command; never chain it or embed it in a script.
- Before pushing, show the commits that will be pushed, for example
  `dotfiles log --oneline @{u}..HEAD`.

### Plan Mode

For any substantial modification or new implementation (e.g., creating a new script, adding a new feature or cache system, refactoring architecture, or modifying multiple related configuration files):
- Never modify or create files immediately.
- Present a clear, structured plan first (goal, architecture & file layout, design decisions, edge cases, and step-by-step approach).
- Wait for explicit user approval before executing the changes.
- Trivial one-line bug fixes, typo corrections, or minor value adjustments do not require a formal plan.

## General Standards

- Prefer minimal, targeted changes.
- Preserve existing configuration and conventions.
- Avoid rewriting entire files when a small modification is sufficient.
- Avoid unnecessary dependencies.
- Prefer native application features over additional tools.
- Comment why something is configured, not simply what it does.
- Do not introduce complexity without a concrete benefit.
- Use ASCII section headers when a file is long enough to benefit from
  sections:
  - Top-level: `# =============================================================================`
  - Subsection: `# --- Section ---`
  - Match the file's comment syntax and existing style.
  - Keep header width and capitalization consistent.
  - Do not add headers to short files or files that already have an
    established structure.
