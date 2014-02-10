#!/bin/ksh
USER=`whoami`
HOSTNAME=`hostname`
CFGDIR=/home/se/safechk/cfg
LOGDIR=/home/se/safechk/safelog
LOG="$LOGDIR/apdir_operator.log"
SHDIR=/home/se/safechk/safesh
CFGFILE=$CFGDIR/ap_dir.cfg
tlog=$SHDIR/tlog.sh

#---------------------------------------------------------------------
# Show running step status
#---------------------------------------------------------------------
#trailmod=1
tlog() {
	msg=$1
    if [ "$trailmod" = "1" ]; then
	   	dt=`date +"%y/%m/%d %H:%M:%S"`
  		echo "$SITE [${dt}] $msg" | tee  -a $LOG
    fi 
}
# Use the scp dir config file to the ALL LPAR .
SCP_CMD() {
#set -x 

	$tlog "Step[2] SPC_CMD function  Start" $LOG


	for hosts in `cat /home/se/safechk/cfg/host.lst|grep -v $HOSTNAME`
	do
		$tlog "scp -P 2222 $dirname/$filename $USER@$hosts:$dirname/$filename" $LOG
		       scp -P 2222 $dirname/$filename $USER@$hosts:$dirname/$filename  > /dev/null 2>&1
	done

	$tlog "Step[2] SPC_CMD function Finished" $LOG
}

# Use the ssh command to execute to  ALL LPAR .
SSH_CMD() {
#set -x 

	$tlog "Step[3] SSH_CMD function  Start" $LOG

	filename=`basename $0`
	dirname=`dirname $0`
	if [[ $dirname = '.' ]] ; then
		dirname=`pwd`
	fi

	for hosts in `cat /home/se/safechk/cfg/host.lst|grep -v $HOSTNAME`
	do
		$tlog "ssh -p 2222 -f $USER@$hosts $dirname/$filename $1"  $LOG
		   	   ssh -p 2222 -f $USER@$hosts $dirname/$filename $1 > /dev/null 2>&1
	done

	$tlog "Step[3] SSH_CMD function  Finished" $LOG
}

DIR_ACT () {
#set -x 

	$tlog "Step[4] DIR_ACT function Start" 

	if  [[ $MODE = MKDIR ]]; then
		if [[ $USER = "root" ]]; then
			$tlog "mkdir $DIR " $LOG
				   mkdir $DIR  
			$tlog "chown $OWNER  $DIR" $LOG
				   chown $OWNER  $DIR 
			$tlog "chmod $PERMIT $DIR" $LOG
				   chmod $PERMIT $DIR
		else
			$tlog "mkdir $DIR " $LOG
				   mkdir $DIR  
			$tlog "chmod $PERMIT $DIR" $LOG
				   chmod $PERMIT $DIR
		fi
	else 
		$tlog "Please setting the correct action type" $LOG
	fi

	$tlog "Step[4] DIR_ACT function Finished" $LOG
}



main() {
#set -x 

	$tlog "#---------------------------------------------------------------------#"  $LOG
	$tlog "Step[1] main function Start" $LOG


	#Check has one parameter
	if [[ $# != 1 ]];then 
		$tlog "Please input a parameter" $LOG
		$tlog "Usage:$0 op_dir.cfg" $LOG
		exit 1
	fi

	#Check dir config file is exist
	dir_cfg=$1
	if [[ ! -f $dir_cfg ]];then
		$tlog "The $dir_cfg file is not exits" $LOG
		$tlog "Please the check the $dir_cfg" $LOG
		exit 1
	fi

	filename=`basename $dir_cfg`
	dirname=`dirname $dir_cfg`
	if [[ $dirname = '.' ]] ; then
		dirname=`pwd`
		dir_cfg=$dirname/$dir_cfg
	fi
	#delete windowns ^M
	cat $dir_cfg | col -b > ${dir_cfg}.bak
	mv ${dir_cfg}.bak ${dir_cfg}

	#If lpar hostname is WKL then use scp dir config to the all lpar,and ssh command to remote lpar.
	hostname=`echo $HOSTNAME | cut -c1-3`
	if [[ $hostname = "WKL" ]]; then
		SCP_CMD $dir_cfg
		SSH_CMD $dir_cfg
	fi

	#Confirm lpar type , and set the variable
	while read MODE HOST DIR PERMIT OWNER 
	do
			COMMENT=`echo $MODE | grep '^#' |wc -l | awk '{print $1}'`
			WHITESP=`echo $MODE | grep '^$' |wc -l | awk '{print $1}'`
			if [[ $COMMENT != 0 ]] || [[ $WHITESP != 0 ]] ;then
				continue
			fi

		case $hostname in 
			DAP)
				if [[ $HOST = "DAP" ]]; then
					DIR_ACT
				fi
			;;
			DAR)
				if [[ $HOST = "DAR" ]]; then
					DIR_ACT
				fi
			;;
			TS[1-2])
				if [[ $HOST = "TS" ]]; then
					DIR_ACT
				fi
			;;
			LOG)
				if [[ $HOST = "LOG" ]]; then
					DIR_ACT
				fi
			;;
			MDS)
				if [[ $HOST = "MDS" ]]; then
					DIR_ACT
				fi
			;;
			FIX)
				if [[ $HOST = "FIX" ]]; then
					DIR_ACT
				fi
			;;
			WKL)
				if [[ $HOST = "WKL" ]]; then
					DIR_ACT
				fi
			;;
			*)
				$tlog "The LPAR type is not exits" $LOG
				exit 1
			;;
		esac
	done < "$dir_cfg"

	$tlog "Step[1] main function Finished "  $LOG
}

main $CFGFILE
