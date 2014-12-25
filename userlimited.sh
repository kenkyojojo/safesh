#!/usr/bin/ksh
SYS_USER="root"
TWSE_USER="twse"
OTC_USER="otc"
set -A CHK_USER $SYS_USER $TWSE_USER $OTC_USER
SHDIR=/home/se/safechk/safesh
LOGDIR=/home/se/safechk/safelog
LOG=${LOGDIR}/userlimited.sh.log
tlog=${SHDIR}/tlog.sh
#==================================================================#
$tlog "#==================================================================#" $LOG
#sys admin user to disable user limites
disable_limits_root(){
    $tlog "diable limits $SYS_USER" $LOG
    for USER in $SYS_USER
    do
	$tlog "chuser fsize=-1 cpu=-1 data=-1 stack=-1 core=-1 rss=-1 threads=-1 nofiles=-1 nproc=-1 $USER" $LOG
	chuser fsize=-1 cpu=-1 data=-1 stack=-1 core=-1 rss=-1 threads=-1 nofiles=-1 nproc=-1 $USER
    done
}

#sys ap twse user to disable user limites
disable_limits_twse(){
    $tlog "diable limits $TWSE_USER" $LOG
    for USER in $TWSE_USER
    do
	$tlog "chuser fsize=-1 cpu=-1 data=-1 stack=-1 core=-1 rss=-1 nofiles=-1 threads=-1 nproc=-1 $USER" $LOG
	chuser fsize=-1 cpu=-1 data=-1 stack=-1 core=-1 rss=-1 nofiles=-1 threads=-1 nproc=-1 $USER
    done
}

#sys ap otc user to disable user limites
disable_limits_otc(){
    $tlog "diable limits $OTC_USER" $LOG
    for USER in $OTC_USER
    do
	$tlog "chuser fsize=-1 cpu=-1 data=-1 stack=-1 core=-1 rss=-1 nofiles=-1 threads=-1 nproc=-1 $USER" $LOG
	chuser fsize=-1 cpu=-1 data=-1 stack=-1 core=-1 rss=-1 nofiles=-1 threads=-1 nproc=-1 $USER
    done
}

main (){
	for user in ${CHK_USER[@]}
	do
		lsuser $user > /dev/null 2>&1
		rc=$?
		if [[ $rc -eq "0" ]];then
			disable_limits_${user}
		fi
	done
}

main
