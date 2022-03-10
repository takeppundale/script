#!/bin/sh

SID=XXXXXX
USER=XXXXXX
PASS=XXXXXX
SERVER=192.168.100.100
DOROOP=yes
SLEEP_TIME=500		# msec

while [ $DOROOP=yes ]
do
	DATE_FROM=$(date --date "12 minutes ago 30 seconds" "+%Y%m%d%H:%M" | awk -F: '{ $2 = int($2 / 10) * 10; if ($2 == 0) {$2 = "00"} print $1$2 0 0}')
	DATE_TO=$(date --date "2 minutes ago 30 seconds" "+%Y%m%d%H:%M" | awk -F: '{ $2 = int($2 / 10) * 10; if ($2 == 0) {$2 = "00"} print $1$2 0 0}')
#	echo ${DATE_TO}
#	echo ${DATE_FROM}

	FILE_NAME=${SID}_${DATE_FROM}_${DATE_TO}_1.csv
#	echo ${FILE_NAME}
	lftp -u $USER,$PASS $SERVER -e "get report/$FILE_NAME; bye"

	usleep ${SLEEP_TIME}
done

