#!/usr/bin/ksh
SYS_USER="root"
AP_USER="twse"
SHDIR=/home/se/safechk/safesh
LOGDIR=/home/se/safechk/safelog
LOG=${LOGDIR}/userlimited.sh.log
tlog=${SHDIR}/tlog.sh
#==================================================================#
$tlog "#==================================================================#" $LOG
#sys admin user to disable user limites
disable_limits_user(){
    $tlog "diable limits SYS_USER" $LOG
    for USER in $SYS_USER
    do
	$tlog "chuser fsize=-1 cpu=-1 data=-1 stack=-1 core=-1 rss=-1 nofiles=-1 $USER" $LOG
	 chuser fsize=-1 cpu=-1 data=-1 stack=-1 core=-1 rss=-1 nofiles=-1 $USER
    done
}

#sys ap user to disable user limites
disable_limits_twse(){
    $tlog "diable limits AP_USER" $LOG
    for USER in $AP_USER
    do
	$tlog "chuser fsize=-1 cpu=-1 data=-1 stack=-1 core=-1 rss=-1 nofiles=-1 threads=-1 nproc=-1 $USER" $LOG
	 chuser fsize=-1 cpu=-1 data=-1 stack=-1 core=-1 rss=-1 nofiles=-1 threads=-1 nproc=-1 $USER
    done
}

main (){
	disable_limits_user
	disable_limits_twse
}

main
