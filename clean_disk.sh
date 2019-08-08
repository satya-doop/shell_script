#!/bin/bash
#Authon: Satya
#Email: s.prakashsharma1989@gmail.com

LOG_DIR=/var/lib
ROOT_UID=0
LINES=50
E_XCD=86
E_NOTROOT=87

if [ "$UID" -ne "$ROOT_UID" ]
then
	echo "Switch to root user to run the script"
	exit $E_NOTROOT
fi

if [ -n "$1" ]
then
	lines=$1
else
	lines=$LINES
fi

cd /var/log || {
	echo "Cannot change to necessary directory " >&2
	exit $E_XCD;
}

tail -n $lines messages > mesg.tmp
mv mesg.temp messages

find . -maxdepth 3 -type f name '*.log' -exec truncate --size 0 "{}" \;
