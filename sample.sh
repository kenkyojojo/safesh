#!/usr/bin/ksh
HOSTNAME=$(hostname)
HOSTC=$(echo $HOSTNAME|cut -c1-3)
WKLPAR="WKL"
SHDIR="/home/se/safechk/safesh"
LOGDIR="/home/se/safechk/safelog"
LOG="${LOGDIR}/passwd_emerg.sh.log"
tlog="$SHDIR/tlog.sh"

set -A MUSER root 

#{{{creative_log
creative_log () {
	if [[ ! -f $LOG ]];then
		touch $LOG
		chmod 777 $LOG
	fi
}
#}}}

#{{{main
main () {

	$tlog "#==============Start==================#"	$LOG
	if [[ "$HOSTC" = "$WKLPAR" ]];then
		#check exec user is root
		user_check
		exec_status=$?
		if [[ $exec_status -eq "0"  ]];then	
			reset_user_passwd
		else
			$tlog "[ERR] $USER permission denied" $LOG
			exit 1
		fi
	else
		$tlog "[ERR] $HOSTC permission denied" $LOG
		exit 1
	fi
	$tlog "#==============Finish=================#"	$LOG
}
#}}}

main
