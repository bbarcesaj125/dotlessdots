#!/bin/bash
getLetter=$(xmodmap -pke | grep 'keycode  59' | awk '{print $5}')

if [ $getLetter == "semicolon" ] 
then
	echo "fr"
else
	echo "yu"
fi
