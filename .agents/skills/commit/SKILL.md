---
name: commit
description: Use when staging or committing changes in any of my
  repositories, including grouping changes and writing commit messages.
---

# Committing changes

## Workflow

1. Start from the working tree:
   - Dotlessdots (the bare repo): run `dotfiles status` and `dotfiles diff`.
   - Any other repo: run `git status` and `git diff` in that repository.
   - List unrelated pre-existing changes and leave them alone.

2. Group changes into logical, self-contained commits:
   - One commit per logical change, grouped by intent rather than by file.
   - Keep tightly coupled changes together; splitting them would leave a
     commit that does not work alone (e.g. a script and its config, a rename
     and its references).
   - Keep unrelated changes in separate commits.
   - Each commit should validate on its own and be revertable alone.
   - Prefer one coherent commit over several tiny commits that each need
     separate staging, review, and messages.
   - Map changes to groups once, then stage and review each group in a single
     pass instead of re-reading diffs repeatedly.

3. Stage explicit paths per group:
   - Dotlessdots: use `dotfiles add <path>...`.
   - Other repos: use `git add <path>...` with explicit paths.
   - Never use `add -A` or `add -u`.
   - If one file mixes unrelated changes, commit it once rather than splitting
     hunks, unless the split is clean and clearly worthwhile.

4. Review before committing:
   - Run `dotfiles diff --cached` or `git diff --cached` and show or summarize
     it.
   - Confirm only intended files are staged.
   - Check for secrets, credentials, tokens, private IPs, and machine-specific
     paths.
   - Run the relevant validator.

5. Commit with a message that follows the conventions below, including the
   required co-author trailer.

## Commit messages

- Use the imperative mood: `add`, `fix`, `remove`, `refactor`.
- Keep the subject short (50 characters or fewer) and lowercase.
- Use `<scope>: <summary>` when a scope helps.
- One logical change per commit.
- Add a body unless the change is self-explanatory from the subject and diff.
- In the body, record the reason: what was wrong, why this approach, and what
  was deliberately left alone. Do not restate the diff.
- Wrap body lines at 72 characters. Keep it to a short paragraph or a few
  lines, not a changelog.
- Skip the body for typo fixes, one-line bug fixes, and value tweaks. Never
  pad it with filler.
- Avoid vague subjects such as `update` or `changes`.
- End every commit with this trailer as the final paragraph:
  `Co-authored-by: commit-ghost <354659923+commit-ghost@users.noreply.github.com>`
- Pass each paragraph as its own `-m` so the blank lines stay blank:
  `dotfiles commit -m "scope: summary" -m "Why the change was needed." -m "Co-authored-by: ..."`
  or, in other repos, the same with `git commit`.
- Keep the trailer last; GitHub only recognizes trailers at the end of the
  message.

## Pushing

Never push as part of committing. Dotlessdots follows the Pushing rules in
`AGENTS.md` (`dotfiles push` standalone, explicit approval per push). Other
repos follow the same principle: no push without explicit approval for that
specific push.
