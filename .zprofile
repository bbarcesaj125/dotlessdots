# Env variables
PATH="$PATH:$HOME/.appimages:$(ruby -e 'print Gem.user_dir')/bin"
# Ruby EVs
export GEM_HOME="$HOME/.gem"
# QGtkStyle
export QT_QPA_PLATFORMTHEME="gtk2"
