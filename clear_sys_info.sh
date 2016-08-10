#!/usr/bin/ksh
HOSTNAME=$(hostname)
HOSTC=$(echo $HOSTNAME|cut -c1-3)
WKLPAR="WKL"
SHDIR="/home/se/safechk/safesh"
LOGDIR="/home/se/safechk/safelog"
LOG="${LOGDIR}/clear_sys_info.sh.log"
tlog="$SHDIR/tlog.sh"


#{{{creative_log
creative_log () {
	if [[ ! -f $LOG ]];then
		touch $LOG
		chmod 777 $LOG
	fi
}
#}}}

#{{{clear system safechk and chk log
clear_log () {

}
#}}}

#{{{main
main () {

	creative_log

	$tlog "#==============Start==================#"	$LOG

	clear_log

	$tlog "#==============Finish=================#"	$LOG
}
#}}}

main
