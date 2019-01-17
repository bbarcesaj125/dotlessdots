#!/bin/bash

# This script changes the xgamma settings based on the sunrise and the sunset times in your city.
# At sunset, the script will automatically change xgamma settings so that the screen
# will have a reddish tone (i.e., think RedShift),
# and will change them back to their default values at sunrise.


DATE=$(date +"%s")
DATE_CURL_SUNSET=$(curl -s 'https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%3D619967&format=xml&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys' | grep -o 'sunset.*$' | cut -d \" -f2)
DATE_CURL_SUNRISE=$(curl -s 'https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%3D619967&format=xml&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys' | grep -o 'sunrise.*$' | cut -d \" -f2)
GAMMA_DEFAULT="-> Red  1.000, Green  1.000, Blue  1.000"
GAMMA_ACTUAL="$(xgamma -d :0 2>&1 >/dev/null)"

wget -q --tries=10 --timeout=20 --spider http://google.com
if [[ $? -eq 0 ]];
then
	:
else
	DATE_CURL_SUNSET="7:30 pm" 
	DATE_CURL_SUNRISE="7:00 am" 
fi

if ([ "$DATE" -ge `date --date="$DATE_CURL_SUNSET" +%s` ] || [ "$DATE" -le `date --date="$DATE_CURL_SUNRISE" +%s` ]) && [ "$GAMMA_ACTUAL" = "$GAMMA_DEFAULT" ];
then
	xgamma -rgamma 1.3 -ggamma 1 -bgamma 0.7
	notify-send -t 1970 "Yo! I'm the <i>sun</i> .. I'm setting .. Maybe I have already done so .. Arrrgh .. See ya!"
elif  [ "$DATE" -le `date --date="$DATE_CURL_SUNSET" +%s` ] && [ "$DATE" -ge `date --date="$DATE_CURL_SUNRISE" +%s` ] && [ "$GAMMA_ACTUAL" != "$GAMMA_DEFAULT" ]; 
then
	xgamma -gamma 1
	notify-send -t 1970 "Yo! I'm the <i>sun</i> .. I'm rising or maybe it is morning already .. Yay .. Have a good day sir!"
fi
