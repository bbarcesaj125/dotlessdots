# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/yusarch/.oh-my-zsh"

# Zshell modules
autoload -U compinit promptinit colors && colors
compinit
promptinit

# Color prompt
#PROMPT="%{$fg[red]%}%n%{$reset_color%}@%{$fg[blue]%}%m %{$fg_no_bold[yellow]%}%1~ %{$reset_color%}%#"
#RPROMPT="[%{$fg_no_bold[yellow]%}%?%{$reset_color%}]"

# Prompt glitch fix (see https://github.com/ohmyzsh/ohmyzsh/issues/6985)
export LC_ALL=en_US.UTF-8
# TERM environment variable
export TERM="xterm-256color"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Store last used commands
HISTFILE=~/.zhistory
setopt APPEND_HISTORY          # append rather than overwrite history file.
HISTSIZE=1200                  # lines of history to maintain memory
SAVEHIST=1000                  # lines of history to maintain in history file.
setopt HIST_EXPIRE_DUPS_FIRST  # allow dups, but expire old ones when I hit HISTSIZE
setopt EXTENDED_HISTORY        # save timestamp and runtime information

# Auto DIR
#setopt AUTO_CD

# Sudo inserting at the start of the line (Using Alt+D)
insert_sudo () { zle beginning-of-line; zle -U "sudo " }
zle -N insert-sudo insert_sudo
bindkey "^[d" insert-sudo

# Some aliases
# Ls aliases
alias ls='ls --color'
# Dev aliases
alias vz='vim ~/.zshrc'
alias sz='source ~/.zshrc'
# Xboard FICS
alias xchess='xboard -ics -icshost freechess.org'
# Manjaro/Arch Aliases
alias pS="sudo pacman -S"
alias pSyy="sudo pacman -Syy"
alias pSyu="sudo pacman -Syu"
alias pR="sudo pacman -R"
alias pRs="sudo pacman -Rs"
alias Pu="paru -Syu"
# Commonly edited dotfiles
alias vXres="vim ~/.Xresources"
# Vimdiff sudoedit
alias vdiffsudit="SUDO_EDITOR=vimdiff sudoedit"
# Git aliases
alias gitpush="git push origin master"
alias gitadd="git add -f"
alias gitcommit="git commit -a"
# Dev aliases
# Vbox and SSH
alias sshubuntu="ssh -p 3022 yusubuntu@127.0.0.1"
alias vboxheadless="vboxmanage startvm Ubuntu\ Server --type headless"
alias vboxpoweroff="vboxmanage controlvm Ubuntu\ Server poweroff"
alias mongossh="ssh -4 -p 3022 -L 27017:localhost:27017 yusubuntu@127.0.0.1"
# Tomcat
alias tomstart="$CATALINA_HOME/bin/startup.sh"
alias tomstop="$CATALINA_HOME/bin/shutdown.sh"
# Dotfiles management
alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME"

# Functions
# Sopcast helper
sop () {
	sp-sc "$1" 55050 55051
}

mpvsop () {
	mpv http://localhost:55051
}

# Kissmanga Downloader
kissme () {
	DIR1="$HOME/Documents/Documents/Manga/mangaDownload/Links/"
	DIR2="$HOME/Documents/Documents/Manga/mangaDownload/Temp/"
	DIR3="$HOME/Documents/Documents/Manga/"
	COUNTER=0
	LEADING_ZERO="00"

	cd "$DIR1"
	for file in ./*.txt
	do
		echo "$file"
		mkdir ../Temp/"${"$(basename -- "$file")"%.*}"
		echo "${"$(basename -- "$file")"%.*}"

		while IFS="" read -r link || [ -n "$link" ]
		do
			EXT="${link##*.}"
			wget --random-wait "$link" -O ../Temp/"${"$(basename -- "$file")"%.*}"/"$LEADING_ZERO""$COUNTER"."$EXT" # 2>&1 | tee -a wgetlog.log
			((COUNTER++))
		done <<< "$(sed "s/\r$//" < "$file")"
		# See https://stackoverflow.com/a/1521498 & https://stackoverflow.com/a/51549655
		COUNTER=0
	done

	rm ./*.txt

	cd "$DIR2"
	tar cfv "$1".cbt */
	mv ./*.cbt "$DIR3"
	rm -r "$DIR2"*/
	cd ~
}

nodewrapper () {
	DIR="$HOME/Documents/Documents/Manga/mangaDownload/Links/"
	cd "$DIR"
	echo "$1"
	node $HOME/.scripts/mangaScrapper.js "$1" "$2" 2>&1 | tee -a nodelog.log
	cd ~
}

# Zip directories into individual zip files
zipme () {
	for i in */;
	do zip -r "${i%/}.zip" "$i";
	done
}

# Reflector
reflect() {
	sudo reflector --verbose --latest $1 --sort rate --save /etc/pacman.d/mirrorlist
}

# GTA IV Launcher
gtaiv () {
	cd ~/.win32/drive_c/Program\ Files/Rockstar\ Games/Grand\ Theft\ Auto\ IV/
	killall compton
	WINEDEBUG=-all primusrun wine ./LaunchGTAIV.exe >/dev/null 2>&1
	compton --config ~/.config/compton.conf -b &
	cd
}

# LO Cryptofolio
cryptofolio () {
	trap 'kill $!' SIGINT SIGTERM INT EXIT
	python ~/.scripts/coinMarketCapFetch.py &
	sleep 5s && localc ~/Dropbox/UbuntuOneStuff/Investment/Cryptofolio.ods
}

# Binance Fetcher
binance () {
	trap 'kill $!' SIGINT SIGTERM INT EXIT
	python ~/.scripts/binanceDataFetcher.py &
	sleep 5s && localc ~/Dropbox/UbuntuOneStuff/Investment/binanceData.csv
}

# Export EDITOR EV
export EDITOR=vim

# Wine Env Variables

#export WINEPREFIX=$HOME/.win32/
#export WINEARCH=win32


# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# Fzf
#export FZF_DEFAULT_COMMAND='ag --hidden --ignore node_modules -g ""'
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null'
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

# User configuration
# Python EV
export PYTHONPATH="/home/yusarch/Documents/Programming/Python/rt_movie_cover"

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
