#!/bin/ksh
USER=`whoami`
HOSTNAME=`hostname`
CFGDIR=/home/se/sfechk/cfg
LOGDIR=/home/se/safechk/safelog
LOG="$LOGDIR/apdir_operator.log"

#---------------------------------------------------------------------
# Show running step status
#---------------------------------------------------------------------
trailmod=1

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

	tlog "Step[2] SPC_CMD function  Start" 

	#dir_cfg=`echo $1| awk -F "/" '{print $NF}'`

	filename=`basename $1`
	dirname=`dirname $1`

	for hosts in `cat /home/se/safechk/cfg/host.lst|grep -v $HOSTNAME`
	do
		tlog "scp -P 2222 $dirname/$filename $USER@$hosts:$CFGDIR/$filename" 
		#scp -P 2222 $dirname/$filename $USER@$hosts:$CFGDIR/$filename 
	done

	tlog "Step[2] SPC_CMD function Finished" 
}

# Use the ssh command to execuit to  ALL LPAR .
SSH_CMD() {
#set -x 

	tlog "Step[3] SSH_CMD function  Start" 

	#dir_cfg=`echo $1| awk -F "/" '{print $NF}'`

	filename=`basename $0`
	dirname=`dirname $0`

	for hosts in `cat /home/se/safechk/cfg/host.lst|grep -v $HOSTNAME`
	do
		tlog "ssh -p 2222 $dirname/$filename $1" 
		#scp -P 2222 $dirname/$filename $USER@$hosts:$CFGDIR/$filename 
	done

	tlog "Step[3] SSH_CMD function  Finished" 
}

DIR_ACT () {
#set -x 

	tlog "Step[3] DIR_ACT function Start" 

	if  [[ $MODE = MKDIR ]]; then
		tlog "mkdir -p $DIR "  
		#mkdir -p $DIR  
		tlog "chown $OWNER  $DIR" 
		#chown $OWNER  $DIR 
        tlog "chmod $PERMIT $DIR" 
		#chmod $PERMIT $DIR
	else 
		tlog "rm -rf $DIR" 
		#rm -rf $DIR
	fi

	tlog "Step[3] DIR_ACT function Finished" 
}



main() {
#set -x 

	echo "#---------------------------------------------------------------------#"  | tee -a $LOG
	tlog "Step[1] main function Start" 

	#Check has one parameter
	if [[ $# != 1 ]];then 
		tlog "Please input a parameter"
		tlog "Usage:$0 op_dir.cfg"
		exit 1
	fi

	#Check dir config file is exist
	dir_cfg=$1
	if [[ ! -f $dir_cfg ]];then
		tlog "The $dir_cfg file is not exits"
		tlog "Please the check the $dir_cfg"
		exit 1
	fi

	#Use scp dir config to the all lpar.
	SCP_CMD $dir_cfg

	hostname=`echo $HOSTNAME | cut -c1-3`
	#Use scp dir config to the all lpar.
	if [[ $hostname = "WKL" ]]; then
		SSH_CMD $dir_cfg
	fi

	#Confirm lpar type , and set the variable
	while read MODE HOST DIR PERMIT OWNER 
	do
			COMMENT=`echo $MODE | grep '^#' |wc -l | awk '{print $1}'`
			if [[ $COMMENT != 0 ]];then
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
			TS)
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
				tlog "The LPAR type is not exits"
				exit 1
			;;
		esac
	done < "$dir_cfg"

	tlog "Step[1] main function Finished " 
}

main $1
