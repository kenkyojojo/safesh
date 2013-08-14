#!/bin/ksh
#----------------------------------
# Set variable
#----------------------------------
SITE=TSEOB1
HOSTNAME=`hostname`
DATE=`date +%Y%m%d`
SHDIR=/home/se/safechk/safesh
SHCFG=/home/se/safechk/cfg
LOGDIR=/home/se/safechk/safelog
LOG=$LOGDIR/security_summar_chk.log
trailmod=1


echo "#-------------------------------------------------------------------------#" >> $LOG

#-----------------------
# Show running step status
#-----------------------
tlog() {
	msg=$1
    if [ "$trailmod" = "1" ]; then
	   	dt=`date +"%y/%m/%d %H:%M:%S"`
  		echo "$SITE [${dt}] $msg"
    fi 
} 


#Run syschk_diff.sh
syschk_check () {
	tlog "Step 1 $SHDIR/syschk_diff.sh Start" >> $LOG
		  $SHDIR/syschk_diff.sh
	tlog "Step 1 $SHDIR/syschk_diff.sh Finished" >> $LOG
}

#Run daily_check.sh
daily_check (){
	tlog "Step 2 $SHDIR/dailycheck/daily_check.sh Start" >> $LOG
		  $SHDIR/dailycheck/daily_check.sh
	tlog "Step 2 $SHDIR/dailycheck/daily_check.sh Finished" >> $LOG
}

#Run ssh_rcmd
ssh_rcmd () {
ARGV=$1

    tlog "Step 3 Start to running remote command " >> $LOG
		for HOSTLST in `cat $SHCFG/host.lst|grep -v WKL`
		do
    		tlog "$HOSTLST remote command start" >> $LOG
			ssh -f -p 2222 $HOSTLST $ARGV > /dev/null 2>&1
    		tlog "$HOSTLST remote command finish" >> $LOG
		done
    tlog "Step 3 Running remote command Finish" >> $LOG
}

#Start Function 
main () {
HST=`echo $HOSTNAME | cut -c1-3`
	if [[ $HST = "WKL" ]];then
		ssh_rcmd $SHDIR/security_summar_chk.sh
		syschk_check > /dev/null 2>&1 &	 
		daily_check > /dev/null 2>&1 &
	else
		syschk_check > /dev/null 2>&1 &	
		daily_check > /dev/null 2>&1 &
	fi
}

main
