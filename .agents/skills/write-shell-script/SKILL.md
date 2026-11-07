---
name: write-shell-script
description: Use when creating or modifying Bash scripts in my Arch Linux
  dotfiles setup.
---

# Writing shell scripts

Global rules in `AGENTS.md` take precedence over this skill.

1. Plan Mode:
   - For new scripts or substantial refactors, do NOT write code immediately.
   - Present a plan detailing: CLI interface, dependencies, file paths (config/state/cache), data flow, and error handling.
   - Await explicit approval before creating or modifying files.

2. Create or edit scripts directly in their intended location:
   - Prefer ~/.local/bin/ for personal executable scripts.

3. Follow these conventions:
   - `#!/usr/bin/env bash`
   - `set -euo pipefail`
   - Quote variable expansions: `"$var"` and `"${array[@]}"`.
   - Use `[[ ]]` instead of `[ ]`.
   - Prefer `$(...)` over backticks.
   - Use descriptive variable names.
   - Use `read -r`.
   - Prefer `printf` over `echo` for data.
   - Declare function-local variables with `local`.
   - Use `--` before paths that may begin with `-`.
   - Provide standard `--help` / `-h` and `--dry-run` options where practical.
   - Keep scripts simple and readable.

4. Stream Discipline & Subshells:
   - Separate human UI from machine data: All status logs, progress messages, warnings, and prompts MUST go to stderr (`echo "..." >&2`). Stdout must remain pure for command substitutions (`data=$(func)`).
   - Subshell persistence: Remember variable changes in subshells (`$(...)`, `cmd | while`) do not propagate to the parent. Use state files or `${XDG_RUNTIME_DIR:-/tmp}` for shared state.

5. File & Path Safety:
   - Use `mktemp` for temporary files and clean them up automatically:
     ```bash
     temp_file=$(mktemp)
     trap 'rm -f "$temp_file"' EXIT
     ```
   - Never hardcode fixed temporary paths in `/tmp`.
   - Avoid loose globs (e.g., `*Server 1*` colliding with `Server 10`). Use regex (`=~`) or structured delimiter extraction (`cut`, `awk`).
   - Strip trailing slashes when building paths or URLs: `${var%/}`.
   - Avoid destructive operations (`rm -rf` or unanchored wildcards).

6. Interactive Menus & Processes:
   - Avoid `exec` inside menu loops or launchers if the user is expected to return to the menu after completion.
   - For interactive fuzzy pickers (`fzf`, `fuzzel`), embed hidden machine data via tab-separated lines.
   - fzf: `--delimiter=$'\t' --with-nth=...`
   - fuzzel: `fuzzel --dmenu --prompt 'Select: '`

7. Storage & XDG Locations:
   - Config: `${XDG_CONFIG_HOME:-$HOME/.config}/<app>/`
   - State (history, favorites): `${XDG_STATE_HOME:-$HOME/.local/state}/<app>/` or `${XDG_CONFIG_HOME}/<app>/`
   - Cache (ephemeral, re-fetchable): `${XDG_CACHE_HOME:-$HOME/.cache}/<app>/`
   - Runtime: `${XDG_RUNTIME_DIR:-/tmp}/<app>_${UID}/`

8. Compatibility:
   - Target Arch Linux.
   - Check required commands with `command -v`.
   - Identify the Arch package providing missing commands.
   - Make scripts idempotent.

9. Validation:
   Run the following checks when available:
   - `bash -n script.sh`
   - `shellcheck script.sh`
   - `shfmt -d -i 2 script.sh`
   - `script --help`
   - `script --dry-run` for state-changing scripts
   If a checker is unavailable, state which checks were skipped.

10. Minimal template:

    ```bash
    #!/usr/bin/env bash
    set -euo pipefail

    usage() {
        printf 'Usage: %s [OPTIONS]\n' "$(basename "$0")" >&2
    }

    die() {
        printf 'Error: %s\n' "$*" >&2
        exit 1
    }

    require_cmd() {
        command -v "$1" >/dev/null 2>&1 || die "missing required command: $1"
    }

    main() {
        require_cmd jq
        # ...
    }

    main "$@"
    ```

11. `set -e` pitfalls:
    - `read` returns non-zero at EOF even when it read data.
    - `grep` returns 1 when there is no match.
    - `(( expr ))` returns 1 when the result is 0.
    - Pipelines and command substitutions propagate failures with `pipefail`.
    - Handle expected non-zero exits with `if`, `|| true`, or explicit checks.
