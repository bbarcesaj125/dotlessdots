---
name: add-dotfile
description: Use when adding or changing a configuration file for a tool
  (Git, tmux, shell, editor, window manager, etc.) in my bare-repo dotfiles setup.
---

# Adding or changing a dotfile

1. Work directly on the actual configuration file under $HOME.
   Example: ~/.config/niri/config.kdl.

2. Plan Mode & Inspection:
   - For substantial changes (introducing new tools, major layout restructures, window manager / compositor adjustments, or multi-file changes), present a plan first and wait for approval.
   - Check whether the file already exists.
   - Inspect its current contents and formatting conventions.
   - Check its Git status using `dotfiles status` or `dotfiles ls-files`.
   - Preserve existing configuration and comments unless a change is necessary.

3. Never access sensitive files or directories:
   - ~/.ssh/
   - ~/.gnupg/
   - ~/.aws/
   - Browser profiles and application databases.
   - Password-manager data.

4. Keep secrets and credentials out of tracked configuration.
   Use application-supported includes for machine-specific settings.
   Never create or modify secret files.

5. Make minimal, targeted changes.
   Do not rewrite entire configuration files unnecessarily.
   Do not modify unrelated files.

6. Before creating, overwriting, or deleting files:
   - Explain what will change.
   - Ask for approval when the operation is destructive or potentially
     disruptive.
   - Never delete existing configuration without explicit approval.

7. If a package or service is required:
   - Identify the required package.
   - Provide the installation or systemctl command.
   - Never execute package installation or service-management commands.

8. Validate changes when possible:
   - Use the application's native configuration checker (e.g., `bash -n`, `hyprctl reload`, `sway -C`, `niri validate`, JSON/CSS linters).
   - Check syntax and file validity before considering the task complete.
   - Avoid restarting services or killing applications without explicit approval.

9. After making changes:
   - Run `dotfiles status`.
   - Run `dotfiles diff` for the relevant files.
   - Report every modified, created or deleted path.
   - Explain potential side effects and untested assumptions.

10. Never run Git write operations:
    - No add, commit, push, reset or checkout.
    - I handle reviewing and committing changes myself.