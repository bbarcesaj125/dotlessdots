# Env variables
PATH="$PATH:$HOME/.appimages:$(ruby -e 'print Gem.user_dir')/bin:$HOME/Downloads/apache-maven-3.6.2/bin"
# Ruby EVs
export GEM_HOME="$HOME/.gem"
# QGtkStyle
export QT_QPA_PLATFORMTHEME="gtk2"
# Tomcat EVs
export CATALINA_HOME="/opt/apache-tomcat"
