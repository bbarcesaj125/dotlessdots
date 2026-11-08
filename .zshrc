# =============================================================================
# 1. Environment
# =============================================================================

export ZSH="$HOME/.oh-my-zsh"
export EDITOR="vim"

# Use ripgrep for fzf file discovery, skipping VCS and dependency directories.
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2>/dev/null'

# =============================================================================
# 2. Oh My Zsh
# =============================================================================

ZSH_THEME="robbyrussell"
plugins=(git)

# Updates are handled manually.
zstyle ':omz:update' mode disabled

source "$ZSH/oh-my-zsh.sh"

# =============================================================================
# 3. History
# =============================================================================

# Oh My Zsh sets HISTSIZE, SAVEHIST, and the history options; only the history
# file location is overridden here.
HISTFILE="$HOME/.zhistory"

# =============================================================================
# 4. Aliases
# =============================================================================

# --- 4.1 Package management --------------------------------------------------

alias pkg-install='sudo pacman -S'
alias pkg-refresh='sudo pacman -Syy'
alias pkg-upgrade='sudo pacman -Syu'
alias pkg-remove='sudo pacman -R'
alias pkg-remove-deps='sudo pacman -Rs'
alias pkg-aur-upgrade='paru -Syu'

# --- 4.2 Zsh ----------------------------------------------------------------

alias zsh-edit='vim "$HOME/.zshrc"'
alias zsh-reload='source "$HOME/.zshrc"'

# --- 4.3 Editing -------------------------------------------------------------

alias xresources-edit='vim "$HOME/.Xresources"'
alias sudoedit-diff='SUDO_EDITOR=vimdiff sudoedit'

# --- 4.4 Git ----------------------------------------------------------------

alias git-add='git add'
alias git-commit='git commit -a'
alias git-push='git push'

# =============================================================================
# 5. Functions
# =============================================================================

# Refresh the Pacman mirrorlist using the given number of mirrors.
reflect() {
  sudo reflector --verbose --latest "$1" --sort rate --save /etc/pacman.d/mirrorlist
}

# =============================================================================
# 6. Tools
# =============================================================================

source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
