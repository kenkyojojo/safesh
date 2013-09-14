#!/bin/ksh
#---------------------------------------------------------------------
# Set variable
#---------------------------------------------------------------------
SITE=TSEOA1
HOSTNAME=`hostname`
DATE=`date +%Y%m%d`
SHDIR=/home/se/safechk/safesh
SHCFG=/home/se/safechk/cfg
FILEDIR=/home/se/safechk/file/fileaudit
CHKDIR=/home/se/chk/
LOGDIR=/home/se/safechk/safelog
LOG=$LOGDIR/security_summar_chk.log
WKLPAR="WKLPARA1"
trailmod=1
GARVG=$1

echo "#-------------------------------------------------------------------------#" >> $LOG

#---------------------------------------------------------------------
# Show running step status
#---------------------------------------------------------------------
tlog() {
	msg=$1
    if [ "$trailmod" = "1" ]; then
	   	dt=`date +"%y/%m/%d %H:%M:%S"`
  		echo "$SITE [${dt}] $msg"
    fi 
} 

#---------------------------------------------------------------------
#scp the TYPE_tmp file to wklpar for the check point.
#---------------------------------------------------------------------
chk_pointfile () {

HST=`echo $HOSTNAME | cut -c1-3`
TYPE=$1

	if [[ $HST = "WKL" ]] ; then
	  	touch /tmp/${HOSTNAME}.${TYPE}tmp
	else
	  	touch /tmp/${HOSTNAME}.${TYPE}tmp
	  	scp -P 2222 /tmp/${HOSTNAME}.${TYPE}tmp $WKLPAR:/tmp 
	  	rm -f /tmp/${HOSTNAME}.${TYPE}tmp
	fi
}

#---------------------------------------------------------------------
#Run syschk_diff.sh
#---------------------------------------------------------------------
syschk_compare () {
SYSLOG=/home/se/safechk/file/syschk
	tlog "Step[2] $SHDIR/syschk_diff.sh Start" >> $LOG
		  $SHDIR/syschk_diff.sh
		  tail -2 $SYSLOG/syschk_diff.log > $LOGDIR/syschk.log
		  chk_pointfile sys
	tlog "Step[2] $SHDIR/syschk_diff.sh Finished" >> $LOG
}

#---------------------------------------------------------------------
#Run daily_check.sh
#---------------------------------------------------------------------
daily_check (){
	tlog "Step[3] $SHDIR/dailycheck/daily_check.sh Start" >> $LOG
		  $SHDIR/dailycheck/daily_check.sh
	tlog "Step[3] $SHDIR/dailycheck/daily_check.sh Finished" >> $LOG
}

#---------------------------------------------------------------------
#Run syschk_base.sh
#---------------------------------------------------------------------
syschk_base (){
BASDIR=/home/se/safechk/file/syschk/base
	tlog "Step[4] $SHDIR/syschk_base.sh Start" >> $LOG
		  $SHDIR/syschk_base.sh
		  ls -rlt $BASDIR/syschk* | tail -2  > $LOGDIR/syschk_base.log 
		  chk_pointfile sba
	tlog "Step[4] $SHDIR/syschk_base.sh Finished" >> $LOG
}

#---------------------------------------------------------------------
#Run ntp 
#---------------------------------------------------------------------
ntp (){
HST=`echo $HOSTNAME | cut -c1-3`

	tlog "Step[5] $SHDIR/ntp_manual.sh Start" >> $LOG

		if [[ $HST = "WKL" ]] ; then
			cp -p ${CHKDIR}/ntp/ntp.result $LOGDIR/ntp.log
		  	chk_pointfile ntp
		else
	    	$SHDIR/ntp_manual.sh
		  	chk_pointfile ntp
		fi
	tlog "Step[5] $SHDIR/ntp_manual.sh Finished" >> $LOG
}

#---------------------------------------------------------------------
#check the action finished status and summarize the report to safelog directoy in the wklpar.
#---------------------------------------------------------------------
chk_status (){

#The chk's report file only in wklpar lpar.

ntp_CHKLOG=$LOGDIR/ntp_chk.${DATE}
sys_CHKLOG=$LOGDIR/sys_chk.${DATE}
aut_CHKLOG=$LOGDIR/aut_chk.${DATE}
atr_CHKLOG=$LOGDIR/atr_chk.${DATE}
adm_CHKLOG=$LOGDIR/adm_chk.${DATE}
sba_CHKLOG=$LOGDIR/sba_chk.${DATE}

#The result's report file  are collect all lpar data. 

ntp_RESULT=$LOGDIR/ntp.log
sys_RESULT=$LOGDIR/syschk.log
aut_RESULT=$LOGDIR/fileaudit_scopy.log
atr_RESULT=$LOGDIR/fileaudit_base.log 
adm_RESULT=$LOGDIR/seadm_chk.log
sba_RESULT=$LOGDIR/syschk_base.log
###########################################################################
CHKTYPE=$1
TOTLECOUNT=`cat $SHCFG/host.lst |awk '{print $1}'|wc -l `

#rm -f "/tmp/*.${CHKTYPE}tmp"

case $CHKTYPE in 
    ntp)
#	TOTLECOUNT=`cat $SHCFG/host.lst| grep -v WKLPAR |awk '{print $1}'|wc -l `
	CHKLOG=$ntp_CHKLOG
	RESULT=$ntp_RESULT
	cat /dev/null > $CHKLOG
    ;;        

    sys)
	CHKLOG=$sys_CHKLOG
	RESULT=$sys_RESULT
	cat /dev/null > $CHKLOG
    ;;        

    aut)
	CHKLOG=$aut_CHKLOG
	RESULT=$aut_RESULT
	cat /dev/null > $CHKLOG
    ;;        

    atr)
	CHKLOG=$atr_CHKLOG
	RESULT=$atr_RESULT
	cat /dev/null > $CHKLOG
    ;;        

    adm)
	CHKLOG=$adm_CHKLOG
	RESULT=$adm_RESULT
	cat /dev/null > $CHKLOG
    ;;        

    sba)
	CHKLOG=$sba_CHKLOG
	RESULT=$sba_RESULT
	cat /dev/null > $CHKLOG
    ;;        
esac


	tlog "Step[6] check_status $CHKTYPE Start" >> $LOG
	COUNTNUM=0
			while [[ $COUNTNUM -lt $TOTLECOUNT ]]
			do
#echo $CHKTYPE
#echo $COUNTNUM:$TOTLECOUNT
				for HOSTLST in `cd /tmp;ls -1 *.${CHKTYPE}tmp|awk -F '.' '{print $1}'`
				do
				echo "#-------------------------------------------------------------------------#" >> $CHKLOG
					tlog $HOSTLST >> "$CHKLOG"

				    	echo "ssh -p 2222 $HOSTLST cat $RESULT >> $CHKLOG"
				        ssh -p 2222 $HOSTLST "cat $RESULT" >> $CHKLOG

						echo "rm -f /tmp/${HOSTLST}.${CHKTYPE}tmp"
						rm -f /tmp/${HOSTLST}.${CHKTYPE}tmp
						COUNTNUM=$(( $COUNTNUM+1 ))
				done
			done

#			echo "#-------------------------------------------------------------------------#" >> $CHKLOG

	tlog "Step[6] check_status $CHKTYPE Finished" >> $LOG
}

#---------------------------------------------------------------------
# Fileaudit cp current status to overwrite the base status ,and change the fileaudit.status to OK status.
#---------------------------------------------------------------------
fileaudit_base (){

BASEFILE=$FILEDIR/base/${HOSTNAME}_file_attr.bas
CURRENT=$FILEDIR/check/${HOSTNAME}_`date +%Y%m%d_file_attr.chk`

	tlog "Step[7] fileaudit current overwrite base Start" >> $LOG
		  cp $CURRENT $BASEFILE
		  echo "Check_exist OK" >  ${CHKDIR}/fileaudit/fileaudit.status
		  echo "Check_modified OK" >> ${CHKDIR}/fileaudit/fileaudit.status
		  ls -rlt $BASEFILE | tail -1  > $LOGDIR/fileaudit_base.log 
		  chk_pointfile atr
	tlog "Step[7] fileaudit current overwrite base Finished" >> $LOG
}

#---------------------------------------------------------------------
# scp fileaudit failed report file to wklpar use daily_coyp.sh script.
#---------------------------------------------------------------------
fileaudit_scopy (){

	tlog "Step[8] $SHDIR/dailycheck/daily_copy.sh Start" >> $LOG
		  $SHDIR/dailycheck/daily_copy.sh
		  tail -2 $LOGDIR/dailycheck.log > $LOGDIR/fileaudit_scopy.log
		  chk_pointfile aut
	tlog "Step[8] $SHDIR/dailycheck/daily_copy.sh Finished" >> $LOG
}

#---------------------------------------------------------------------
# su command to change the seadm user and running his cron job. It's execute the check.sh script in the /home/se/chk/ directory.
#---------------------------------------------------------------------
Hardware_chk (){

	tlog "Step[9] Running seadm's Hardware_chk  Start" >> $LOG
		  su - seadm -c "crontab -l |tail -1|cut -c 14-| ksh"
		  chk_pointfile adm
	tlog "Step[9] Running seadm's Hardware_chk Finished" >> $LOG
		  tail -2 $LOG > $LOGDIR/seadm_chk.log
}

#---------------------------------------------------------------------
#Run ssh_rcmd to remte the lpar and execute the script use the ssh and add the -f pararmeter to running in the background .
#---------------------------------------------------------------------
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

#---------------------------------------------------------------------
#The usage in the script, you  need to have the parameter,show the parameter use function
#---------------------------------------------------------------------
usage () {

	tlog "Please insert boot/down/base/audit/Hardware_chk Parameter."
	echo ""
	echo "boot parameter: Run the ssh_rcmd, ntp , syschk_compare, daily_check, chk_status ntp ,chk_status sys function."
	echo "Useage:security_summar_chk.sh boot"
	echo ""
	echo "down parameter: Run the ssh_rcmd, syschk_base , chk_status sba."
	echo "Useage:security_summar_chk.sh down"
	echo ""
	echo "base parameter: Run the ssh_rcmd, fileaudit_base."
	echo "Useage:security_summar_chk.sh base"
	echo ""
	echo "audit parameter: Run the ssh_rcmd, fileaudit_scop."
	echo "Useage:security_summar_chk.sh audit"
	echo ""
	echo "hardware_chk parameter: Run the ssh_rcmd, hardware_chk."
	echo "Useage:security_summar_chk.sh hardware_chk"
	echo ""
	echo "ntp parameter: Run the ssh_rcmd, ntp"
	echo "Useage:security_summar_chk.sh ntp "
	echo ""
	echo "sys parameter: Run the ssh_rcmd, syschk_compare"
	echo "Useage:security_summar_chk.sh sys"
	echo ""
	echo "daily_check parameter: Run the ssh_rcmd, daily_check"
	echo "Useage:security_summar_chk.sh daily_check

	exit 1
}

#---------------------------------------------------------------------
#Start Function 
#---------------------------------------------------------------------
main () {
MODEARGV=$1
HST=`echo $HOSTNAME | cut -c1-3`

	case $MODEARGV in 
		boot) #Test OK
			if [[ $HST = "WKL" ]];then
				ssh_rcmd $SHDIR/security_summar_chk.sh boot
				#
				ntp > /dev/null 2>&1 &
				syschk_compare > /dev/null 2>&1 & 	 
				daily_check > /dev/null 2>&1 &
				#
				chk_status ntp > /dev/null 2>&1 &
				chk_status sys > /dev/null 2>&1 &
			else
				ntp > /dev/null 2>&1 &
				syschk_compare > /dev/null 2>&1 &	
				daily_check > /dev/null 2>&1  &
			fi
		;;
		down) # Test OK
			if [[ $HST = "WKL" ]];then
				ssh_rcmd $SHDIR/security_summar_chk.sh down
				syschk_base > /dev/null 2>&1 & 
				chk_status sba > /dev/null 2>&1 &
			else
				syschk_base > /dev/null 2>&1 &	 
			fi
		;;
		base) #Test OK
			if [[ $HST = "WKL" ]];then
				ssh_rcmd $SHDIR/security_summar_chk.sh base
				fileaudit_base > /dev/null 2>&1 &	 
				chk_status atr > /dev/null 2>&1 &
			else
				fileaudit_base > /dev/null 2>&1 &	 
			fi
		;;
		audit) #Test OK
			if [[ $HST = "WKL" ]];then
				ssh_rcmd $SHDIR/security_summar_chk.sh audit
				fileaudit_scopy > /dev/null 2>&1 &
				chk_status aut > /dev/null 2>&1 &
				#chk_status aut &
			else
				fileaudit_scopy > /dev/null 2>&1 &	 
			fi
		;;	
		hardware_chk) #Test OK
			if [[ $HST = "WKL" ]];then
				ssh_rcmd $SHDIR/security_summar_chk.sh hardware_chk
				Hardware_chk > /dev/null 2>&1 	 
				chk_status adm > /dev/null 2>&1 &
				#chk_status adm &
			else
				Hardware_chk > /dev/null 2>&1 	 
			fi
		;;
		ntp) #Test OK
			if [[ $HST = "WKL" ]];then
				ssh_rcmd $SHDIR/security_summar_chk.sh ntp
				ntp > /dev/null 2>&1 &
				chk_status ntp > /dev/null 2>&1 &
			else
				ntp > /dev/null 2>&1 &
			fi
		;;
		sys) #Test OK
			if [[ $HST = "WKL" ]];then
				ssh_rcmd $SHDIR/security_summar_chk.sh sys
				syschk_compare > /dev/null 2>&1 & 	 
				chk_status sys > /dev/null 2>&1 &
			else
				syschk_compare > /dev/null 2>&1 & 	 
			fi
		;;

		daily_check) #Test OK
			if [[ $HST = "WKL" ]];then
				ssh_rcmd $SHDIR/security_summar_chk.sh daily_check
				daily_check > /dev/null 2>&1 & 	 
			else
				daily_check > /dev/null 2>&1 & 	 
			fi
		;;

		*)
			usage
		;;

	esac
}

main $GARVG
