#!/usr/bin/ksh
USER=$(whoami)
HOSTNAME=$(hostname)
HOSTC=$(echo $HOSTNAME|cut -c1-3)
WKLPAR="WKL"
SHDIR="/home/se/safechk/safesh"
LOGDIR="/home/se/safechk/safelog"
LOG="${LOGDIR}/passwd_emerg.sh.log"
RESTPASS="1234567"
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

#{{{user_check
user_check (){
	# check user information.  
	userflag=0
	for chkuser in ${MUSER[@]}
	do
		if [[ $USER = $chkuser ]];then
			userflag=1
			return 0
		fi
	done

	if [[ $userflag -eq "0" ]];then 
		return 1
	fi
}
#}}}

#{{{reset_user_passwd
reset_user_passwd (){

USRLIST=$(cat /home/se/safechk/safesh/account/mkalluser.sh | grep mkuser | awk '{print $NF}')

	for USERNAME in $USRLIST
	do
		USERCHK=`grep "^${USERNAME}:" /etc/passwd | awk -F: '{print $1}'`
		if [[ "$USERCHK" != "$USERNAME" ]];then
			$tlog "[ERR] $USERNAME not exists" $LOG
		else
			echo "$USERNAME:$RESTPASS" | chpasswd -c 
			rc=$?
			if [[ $rc -eq "0" ]];then
				$tlog "[INFO] $USERNAME reset default passwd success" $LOG
			else
				$tlog "[ERR] $USERNAME reset default passwd failed" $LOG
			fi
		fi
	done
}
#}}}

#{{{main
main () {

	creative_log
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

#{{{begin
begin () {
	clear
	echo "使用者密碼變更緊急程序"
	echo "將所有使用者密碼變更為預設密碼"
	read ANSWER?"請確認是否執行(Y/N): "
		case $ANSWER in                               
		n|N)                                          
			exit
			;;                                       
		y|Y)
			main
			;;
		*)                                            
			echo "[ERR]  輸入錯誤, 請輸入(Y/N)"    
			exit 1
		   ;;                                 
		esac
}
#}}}

begin
