#!/usr/bin/env bash

function run {
  if ! pgrep -f $1 ;
  then
    $@&
  fi
}

run setxkbmap -layout de -option compose:prsc
run mpd
run /usr/bin/lxqt-policykit-agent 
run nm-applet 
run redshift -l 44.05158:4.77797
# run picom 
(sleep 1s && run pasystray) 
# (sleep 1s && run pulseeffects --gapplication-service)
(sleep 2s && run conky) 
(sleep 4s && run parcellite) 
