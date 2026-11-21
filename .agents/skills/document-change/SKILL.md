---
name: document-change
description: Use after landing a non-trivial script, configuration, or
  system change, to record it in the private system changelog, the
  machine-state docs, or the public script index. Also use when unsure
  where a change should be documented.
---

# Documenting changes

## Where things live

- Private repo: `~/Projects/machine-priv` (plain Git, remote on GitHub).
  It hosts sensitive and system-level documentation for the whole
  machine, of which the pia tunnel setup is one part.
  - `CHANGELOG.md` — system changelog for what Git does not track
    (`/etc` files, sudoers, service states, cross-repo wiring).
  - `docs/machine-state.md` — current state of everything outside Git.
  - `docs/public-scrub.md` — the word list that public text is
    scrubbed against. Never quote it in public files.
- Public repo: dotlessdots (bare repo, `$HOME` worktree, `dotfiles`
  frontend). `README.md` holds the script index. Git history is the
  changelog for tracked files; no separate changelog is kept there.

## Workflow

1. Classify the change:
   - Machine or system state (`/etc`, sudoers, services, installed
     files, unit states) or private-repo files -> private changelog.
   - dotlessdots scripts or configs -> public script index if a script
     was added, renamed, or changed purpose; otherwise nothing (git
     history covers it).
   - Both -> both repos, committed separately in each. Never commit a
     private-repo file to dotlessdots or vice versa.
2. Verify facts before writing: run the relevant commands (file
   existence and modes, `systemctl is-enabled/is-active`,
   `sudo -l`). Never document from memory.
3. For public text, scrub against `~/Projects/machine-priv/docs/public-scrub.md`.
   If it cannot be read, write generic wording ("a systemd-managed VPN
   tunnel") and say so in the response. Commit subjects in the public
   repo follow the same scrub rules.
4. Update the changelog using the entry template:

   ```
   ## YYYY-MM-DD — short title
   What:       bullet list of changed files/scripts/units
   Machine:    /etc or service state not in Git (mode, owner, scope)
   Verify:     commands that prove the change is in effect
   Notes:      deliberate omissions, related commits elsewhere
   ```

   Prepend under the header; never rewrite old entries.
5. If durable machine state changed (a new `/etc` file, a service
   enablement), update `docs/machine-state.md` in the same private
   commit, including the new Verify command and a fresh
   "Last verified" date.
6. Commit:
   - machine-priv: plain `git add` / `git commit`. A code change and its
     changelog entry go in one commit; docs-only changes get their own.
   - dotlessdots: follow the `commit` skill (staging, message format,
     trailer). A README index update rides along with the script
     change commit; never push without explicit approval.
7. Skip the changelog entirely for trivial changes: typo fixes,
   one-line value tweaks, formatting. The `commit` skill's threshold
   applies.
