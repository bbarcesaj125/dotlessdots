# This is my Zshell Config (A work in progress ...)
# ZSH path
ZSH=$HOME/.oh-my-zsh

# Zshell modules
autoload -U compinit promptinit colors && colors
compinit
promptinit

# Color prompt
PROMPT="%{$fg[red]%}%n%{$reset_color%}@%{$fg[blue]%}%m %{$fg_no_bold[yellow]%}%1~ %{$reset_color%}%#"
RPROMPT="[%{$fg_no_bold[yellow]%}%?%{$reset_color%}]"

# ZSH theme 
ZSH_THEME="duellj"

# Store last used commands
HISTFILE=~/.zhistory
setopt APPEND_HISTORY          # append rather than overwrite history file.
HISTSIZE=1200                  # lines of history to maintain memory
SAVEHIST=1000                  # lines of history to maintain in history file.
setopt HIST_EXPIRE_DUPS_FIRST  # allow dups, but expire old ones when I hit HISTSIZE
setopt EXTENDED_HISTORY        # save timestamp and runtime information

# Auto DIR
setopt AUTO_CD

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
alias Yu="yay -Syu"
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
			wget --random-wait "$link" -O ../Temp/"${"$(basename -- "$file")"%.*}"/"$LEADING_ZERO""$COUNTER"."$EXT" 2>&1 | tee -a wgetlog.log
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

# Source Zsh
source $ZSH/oh-my-zsh.sh

# Fzf
#export FZF_DEFAULT_COMMAND='ag --hidden --ignore node_modules -g ""'
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null'
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
