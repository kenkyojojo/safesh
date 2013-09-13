#!/bin/ksh
#----------------------------------
# Set variable
#----------------------------------
SITE=TSEOA1
HOSTNAME=`hostname`
DATE=`date +%Y%m%d`
SHDIR=/home/se/safechk/safesh
SHCFG=/home/se/safechk/cfg
FILEDIR=/home/se/safechk/file/fileaudit
CHKDIR=/home/se/chk/fileaudit
LOGDIR=/home/se/safechk/safelog
LOG=$LOGDIR/security_summar_chk.log
ntpCHKLOG=$LOGDIR/ntp_chk.${DATE}
sysCHKLOG=$LOGDIR/sys_chk.${DATE}
autCHKLOG=$LOGDIR/aut_chk.${DATE}
NTPRESULT=/home/se/chk/ntp/ntp.result
SYSRESULT=/home/se/safechk/safelog/syschk.log
WKLPAR="WKLPARA1"
trailmod=1
GARVG=$1

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
	tlog "Step[2] $SHDIR/syschk_diff.sh Start" >> $LOG
		  $SHDIR/syschk_diff.sh
		  touch /tmp/${HOSTNAME}.systmp
		  scp -P 2222 /tmp/${HOSTNAME}.systmp $WKLPAR:/tmp 
		  rm -f /tmp/${HOSTNAME}.systmp
	tlog "Step[2] $SHDIR/syschk_diff.sh Finished" >> $LOG
}

#Run daily_check.sh
daily_check (){
	tlog "Step[3] $SHDIR/dailycheck/daily_check.sh Start" >> $LOG
		  $SHDIR/dailycheck/daily_check.sh
	tlog "Step[3] $SHDIR/dailycheck/daily_check.sh Finished" >> $LOG
}

#Run syschk_base.sh
daily_check_base (){
	tlog "Step[4] $SHDIR/syschk_base.sh Start" >> $LOG
		  $SHDIR/syschk_base.sh
	tlog "Step[4] $SHDIR/syschk_base.sh Finished" >> $LOG
}

#Run ntp
ntp (){
	tlog "Step[5] $SHDIR/ntp_manual.sh Start" >> $LOG
		  $SHDIR/ntp_manual.sh
		  touch /tmp/${HOSTNAME}.ntptmp
		  scp -P 2222 /tmp/${HOSTNAME}.ntptmp $WKLPAR:/tmp 
		  rm -f /tmp/${HOSTNAME}.ntptmp
	tlog "Step[5] $SHDIR/ntp_manual.sh Finished" >> $LOG
}

#check status
chk_satus (){
CHKTYPE=$1
TOTLECOUNT=`cat $SHCFG/host.lst| grep -v WKLPAR |awk '{print $1}'|wc -l `
COUNTNUM=0

	tlog "Step[6] check_status Start" >> $LOG
#cat /dev/null > $NTPCHKLOG
#cat /dev/null > $SYSCHKLOG

		cat /dev/null > ${CHKTYPE}CHKLOG
#COUNTNTP=0
#while [[ $COUNTNTP -lt $TOTLECOUNT ]]
		if [[ $CHKTYPE = "ntp" || $CHYTYPE = "sys" ]] ; then
			while [[ $COUNTNUM -lt $TOTLECOUNT ]]
			do
				for HOSTLST in `cd /tmp;ls -1 *.${CHKTYPE}tmp|awk -F '.' '{print $1}'`
				do
				echo "#-------------------------------------------------------------------------#" >> ${CHKTYPE}CHKLOG
						tlog $HOSTLST >> ${CHKTYPE}CHKLOG
						ssh -p 2222 $HOSTLST "cat ${CHKTYPE}RESULT" >> ${CHKTYPE}CHKLOG
						rm -f /tmp/${HOSTLST}.${CHKTYPE}tmp
						COUNTNUM=$(( $COUNTNUM+1 ))
				done
			done
			echo "#-------------------------------------------------------------------------#" >> ${CHKTYPE}CHKLOG
			cat ${CHKTYPE}RESULT >> ${CHKTYPE}CHKLOG
		else
			while [[ $COUNTNUM -lt $TOTLECOUNT ]]
			do
				for HOSTLST in `cd /tmp;ls -1 *.${CHKTYPE}tmp|awk -F '.' '{print $1}'`
				do
				echo "#-------------------------------------------------------------------------#" >> ${CHKTYPE}CHKLOG
						tlog $HOSTLST >> ${CHKTYPE}CHKLOG
						ssh -p 2222 $HOSTLST "cat ${CHKTYPE}RESULT" >> ${CHKTYPE}CHKLOG
						rm -f /tmp/${HOSTLST}.${CHKTYPE}tmp
						COUNTNUM=$(( $COUNTNUM+1 ))
				done
			done
			echo "#-------------------------------------------------------------------------#" >> ${CHKTYPE}CHKLOG
			cat ${CHKTYPE}RESULT >> ${CHKTYPE}CHKLOG
		fi

			tlog $HOSTNAME >> ${CHKTYPE}CHKLOG
#		COUNTSYS=0
#		while [[ $COUNTSYS -lt $TOTLECOUNT ]]
#		do
#			for HOSTLST in `cd /tmp;ls -1 *.systmp|awk -F '.' '{print $1}'`
#			do
#					ssh -p 2222 $HOSTLST "cat $SYSRESULT" >> $SYSCHKLOG
#					rm -f /tmp/${HOSTLST}.systmp
#					COUNTSYS=$(( $COUNTSYS+1 ))
#echo 1 $COUNTSYS
#			done
#echo 2 $COUNTSYS
#		done
#		cat $SYSRESULT >> $SYSCHKLOG

	tlog "Step[6] check_status Finished" >> $LOG
}

# Fileaudit cp current status to overwrite the base status ,and change the fileaudit.status to OK status.
fileaudit_base (){

BASEFILE=$FILEDIR/base/${HOSTNAME}_file_attr.bas
CURRENT=$FILEDIR/check/${HOSTNAME}_`date +%Y%m%d_file_attr.chk`

	tlog "Step[7] fileaudit current overwrite base Start" >> $LOG
		  cp $CURRENT $BASEFILE
		  echo "Check_exist OK" >  $CHKDIR/fileaudit.status
		  echo "Check_modified OK" >> $CHKDIR/fileaudit.status
	tlog "Step[7] fileaudit current overwrite base Finished" >> $LOG
}

# scp fileaudit failed report file to wklpar use startcopy.sh
fileaudit_scopy (){

	tlog "Step[8] $SHDIR/startcopy.sh Start" >> $LOG
		  $SHDIR/startcopy.sh
		  touch /tmp/${HOSTNAME}.audtmp
		  scp -P 2222 /tmp/${HOSTNAME}.audtmp $WKLPAR:/tmp 
		  rm -f /tmp/${HOSTNAME}.audtmp
	tlog "Step[8] $SHDIR/startcopy.sh Finished" >> $LOG
}

#Run ssh_rcmd
ssh_rcmd () {
ARGV=$1
SARGV=$2

    tlog "Step[1] Start to running remote command " >> $LOG
		for HOSTLST in `cat $SHCFG/host.lst|grep -v WKL`
		do
    		tlog "$HOSTLST remote command Start" >> $LOG
			ssh -f -p 2222 $HOSTLST $ARGV $SARGV > /dev/null 2>&1
    		tlog "$HOSTLST remote command Finished" >> $LOG
		done
    tlog "Step[1] Running remote command Finished" >> $LOG
}

#Start Function 
main () {
MODEARGV=$1
HST=`echo $HOSTNAME | cut -c1-3`

	case $MODEARGV in 
		boot)
			if [[ $HST = "WKL" ]];then
				ssh_rcmd $SHDIR/security_summar_chk.sh boot
				syschk_check > /dev/null 2>&1 & 	 
				daily_check > /dev/null 2>&1  &
				chk_satus ntp > /dev/null 2>&1  
				chk_satus sys > /dev/null 2>&1  
			else
				ntp > /dev/null 2>&1 &
				syschk_check > /dev/null 2>&1 &	
				daily_check > /dev/null 2>&1  &
			fi
		;;
		down)
			if [[ $HST = "WKL" ]];then
				ssh_rcmd $SHDIR/security_summar_chk.sh down
				daily_check_base > /dev/null 2>&1 &	 
			else
				daily_check_base > /dev/null 2>&1 & 	 
			fi
		;;
		base)
			if [[ $HST = "WKL" ]];then
				ssh_rcmd $SHDIR/security_summar_chk.sh base
				fileaudit_base > /dev/null 2>&1 &	 
			else
				fileaudit_base > /dev/null 2>&1 &	 
			fi
		;;
		audit)
			if [[ $HST = "WKL" ]];then
				ssh_rcmd $SHDIR/security_summar_chk.sh audit
				sleep 90
				fileaudit_scopy > /dev/null 2>&1 &	 
			else
				fileaudit_scopy > /dev/null 2>&1 &	 
			fi
		;;
		*)
			tlog "Please insert boot/down/base/audit Parameter."
			tlog "Please insert boot/down/base/audit Parameter." >> $LOG
			exit 1
		;;

	esac
}

main $GARVG