#!/bin/bash

[ $(pgrep -x "tint2") ] && killall tint2 || tint2
