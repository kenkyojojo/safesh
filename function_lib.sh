#!/bin/ksh
hostname=`hostname`
DATEM=`date +%Y%m`
DATE1AGO=`perl -MPOSIX -le 'print strftime "%Y%m%d", localtime(time()-86400);'`
USER=$(whoami)
WKLPAR=WKLPART1
MODE=$1
TYPE=$2
OLDIFS=$IFS
SHDIR=/home/se/safechk/safesh
LOGDIR=/home/se/safechk/safelog
set -A MUSER root seadm se01 se02 bruce
#set -A MUSER root seadm se01 se02

#{{{tlog
tlog() {

	MSG=$1
	LOG=$2
	if [ $# -eq "2" ]; then
		dt=`date +"%y/%m/%d %H:%M:%S"`
		echo "$SITE [${dt}] $MSG" | tee  -a $LOG
	else
		echo "[ERR] Please to check have two parameter" 
		exit 1
	fi 
}
#}}}}

#{{{menu_input_lpar
menu_input_lpar () {
# Setting the LPAR information.  
#set -x
    echo ""
    HOSTN=""
    HOSTLIST=""
    HOSTCFG="/home/se/safechk/cfg/host.lst" 
    timestamp=`date +"%Y%m%d%H%M%S"`
    HOSTNAME=`hostname`
	IFS=$OLDIFS

       echo ""
       echo "                  (隨時可輸 q 以離開 ) "
       echo "#==========================================================#"
       echo "# 輸入格式(每台主機以空格做為分隔): DAP1-1 DAR1-1 LOG1 MDS1#"
       echo "#                                                          #"
       echo "# 群組輸入格式: DAP (一次一個群組)                         #"
       echo "#                                                          #"
       echo "# 全部主機請輸入: ALL                                      #"
       echo "#==========================================================#"
#	   read  -A HOSTN?"輸入欲變更Base的主機名稱 : "
	   read  HOSTN?"輸入欲變更Base的主機名稱 : "

	   if [[ "$HOSTN" == "q" ]] || [[ "$HOSTN" == "Q" ]]; then
		   return 0
	   fi

	   if [[ -z "$HOSTN" ]]; then
			echo ""
			echo "               [Error] 請輸輸入欲變更的主機名稱"
			echo ""
			read ANSWR?"               按Enter鍵繼續 "
		    return 1
	   fi

	   # check input more then 2 characters 
	   # [:alpha:]代表英文大小寫字元，亦即A-Z, a-z
	   # [:alnum:]代表英文大小寫字元及數字，亦即 0-9, A-Z, a-z
	   if [[ $HOSTN != [[:alpha:]][[:alnum:]]* ]]; then
			echo "               [Error] ${HOSTN} 輸入為空值"
			echo ""
			read ANSWR?"               按Enter鍵繼續 "
		    return 1
	   fi	

	   rm -f /tmp/lparlst${USER}.tmp	

	   for HOSTN in ${HOSTN[@]}
	   do
		   HOSTN=`echo $HOSTN|tr '[a-z]' '[A-Z]'`
		   case $HOSTN in
			   DAP)
				   set -A HOSTLIST $(cat $HOSTCFG | grep -i ^DAP)
				   ;;
			   DAR)
				   set -A HOSTLIST $(cat $HOSTCFG | grep -i ^DAR)
				   ;;
			   MDS)
				   set -A HOSTLIST $(cat $HOSTCFG | grep -i ^MDS)
				   ;;
			   LOG)
				   set -A HOSTLIST $(cat $HOSTCFG | grep -i ^LOG)
				   ;;
			   FIX)
				   set -A HOSTLIST $(cat $HOSTCFG | grep -i ^FIX)
				   ;;
			   TS)
				   set -A HOSTLIST $(cat $HOSTCFG | grep -i ^TS)
				   ;;
			   ALL)
				   set -A HOSTLIST $(cat $HOSTCFG)
				   ;;
			   *)
				   set -A HOSTLIST $(grep  $(echo ${HOSTN}$) $HOSTCFG)
				   ;;
			esac

		    if [[ -z "$HOSTLIST" ]]; then
				echo ""
				echo "               [Error] ${HOSTN} 輸入為空值 "
				echo ""
				read ANSWR?"               按Enter鍵繼續 "
				return 1
		    fi
			echo ${HOSTLIST[@]} >> /tmp/lparlst${USER}.tmp
	   done
	   return `cat /tmp/lparlst${USER}.tmp`
	   clear 
}
#}}}

#{{{user_check
user_check (){
# check user information.  
USER=$1
userflag=0
	for chkuser in ${MUSER[@]}
	do
		if [[ $USER = $chkuser ]];then
			userflag=1
			return 0
		fi
	done

	if [[ $userflag -eq 0 ]];then 
		return 1
	fi
}
#}}}

#{{{create_log
create_log () {
USER=$1
LOG=$2
   if [[ ! -f $LOG ]]; then 
		   if [[ $USER = "root" ]];then
				   touch $LOG
				   chown seadm:se $LOG
				   chmod 664 $LOG
		   else
				   touch $LOG
				   chmod 664 $LOG
#				   echo "create_log:Please use the exadm or root user to running the script first"
#				   exit 1
		   fi
   fi
}
#}}}

