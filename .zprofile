# Ruby EVs
export GEM_HOME="$(ruby -e 'puts Gem.user_dir')"
# Env variables
PATH="$PATH:$HOME/.appimages:$GEM_HOME/bin:$HOME/.local/bin"
# QGtkStyle
export QT_QPA_PLATFORMTHEME="gtk2"
# Tomcat EVs
export CATALINA_HOME="/opt/apache-tomcat"
