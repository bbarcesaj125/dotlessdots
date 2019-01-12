#!/bin/bash

id=$(xprop -root | awk '/_NET_ACTIVE_WINDOW\(WINDOW\)/{print $NF}')
name=$(xprop -id $id | awk '/_NET_WM_NAME/{$1=$2="";print}')
name_=$(echo $name | sed -e 's/^"//' -e 's/"$//')
char_limit='85'

if [[ ! -z $name_ ]] 
then
	if [[ "${#name_}" -gt "$char_limit" ]]
	then
		if [ "${name_:81:1}" == "\\" ]
		then
			name_0="${name_:0:81}."
			name_1="$name_0"
		else
			name_1="${name_:0:82}"
		fi
		name_="${name_1}..."
	fi
else
	name_="Archlinux Desktop..."
fi

echo $name_ || exit 1

