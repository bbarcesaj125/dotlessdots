#!/bin/bash
while read p; do
	curl $p | grep "btn-primary" |  cut -d'"' -f2 >> ~/Downloads/links2.txt
done <~/Downloads/links.txt
