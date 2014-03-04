#!/usr/bin/ksh
MSG=$1
LOG=$2
SITE=TSEOT1

tlog() {

	MSG=$1
	LOG=$2
	if [ $# -eq "2" ]; then
		dt=`date +"%y/%m/%d %H:%M:%S"`
		echo "$SITE [${dt}] $MSG" | tee  -a $LOG
	else
		usage
	fi 
}

usage() {

	echo "Please input the parameter"
	echo "Usage:"
	echo "./tlog.sh  The message you want to record  tlog.log"
	exit 1
}

tlog "$MSG" "$LOG"

