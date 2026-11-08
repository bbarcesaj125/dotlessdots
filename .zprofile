# =============================================================================
# Environment
# =============================================================================

# Ruby user-installed gems.
export GEM_HOME="$(ruby -e 'puts Gem.user_dir')"

# User-local executables.
export PATH="$PATH:$HOME/.appimages:$GEM_HOME/bin:$HOME/.local/bin"
