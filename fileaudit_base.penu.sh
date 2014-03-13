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
FILEDIR=/home/se/safechk/file/fileaudit

if [[ $USER = "exadm" ]];then
	SHDIR=/home/exc/excwk/apdir/shell
	FILEDIR=/home/exc/excwk/apdir/file/fileaudit
	LOGDIR=/home/exc/excwk/apdir/log
fi
tlog=${SHDIR}/tlog.sh
LOG=${LOGDIR}/fileaudit_base.penu.sh.log
BASEDIR=${FILEDIR}/base
CURRDIR=${FILEDIR}/check

set -A MUSER root seadm exadm bruce
#===============================================================#

#{{{create_log
create_log () {
   if [[ ! -f $LOG ]]; then 
		   if [[ $USER = "root" ]];then
				   touch $LOG
				   chown seadm:se $LOG
				   chmod 666 $LOG
		   elif [[ $USER = "seadm" ]]; then
				   touch $LOG
				   chmod 666 $LOG
		   elif [[ $USER = "exadm" ]]; then
				   touch $LOG
				   chmod 666 $LOG
		   else
				   echo "create_log:Please use the exadm or root user to running the script first"
				   exit 1
		   fi
   fi
}
#}}}

#{{{main menu
main () {

	create_log

	FNUM=1
	LNUM=4
	clear
	echo " << FIX/FAST ��T�ǿ�t�Ψt�ޱ��ާ@����-[�ɮ��ˮ�] (ALL AIX LPAR)>> "
	echo ""
    echo "                  1:�ɮ��ˮ�BASE�ɧ�s "
	echo ""
    echo "                  2:�ɮ��ˮ�BASE���٭� "
	echo ""
    echo "                  3:�ɮ��ˮ�BASE���ܧ� "
	echo ""
    echo "                  4:��ʰ����ɮ��ˮ� "
	echo ""
    echo "                  (�H�ɥi�� q �H���} ) "
	echo ""
    read Menu_No?"�п�ܿﶵ(${FNUM}-${LNUM}) : "


    case $Menu_No in  
        1)
			STARTA
            ;;
        2)
			STARTB
            ;;
        3)
			STARTC
			;;
        4)
			STARTD
			;;
        q|Q)
			/home/se/safechk/safesh/p.sh
			exit
            ;;
        *)
            echo "" 
			echo "[Error]  ��J���~, �п�J (${FNUM}-${LNUM})���ﶵ"
			read Answer?"  ��Enter���~�� "
			main
            ;;
	esac
}
#}}}

#{{{STARTA base file orverride menu
STARTA () {

# check user permission
USER_CHECK 

	clear
	FNUM=1
	LNUM=2
	echo " << FIX/FAST ��T�ǿ�t�Ψt�ޱ��ާ@����-[�ɮ��ˮ֧�s] (ALL AIX LPAR)>> "
	echo ""
    echo "                  1:�ɮ��ˮ�BASE�ɧ�s(���ɶ��ݩ�_attr)"
	echo ""
    echo "                  2:�ɮ��ˮ�BASE�ɧ�s(�L�ɶ��ݩ�_exist)"
	echo ""
    echo "                  (�H�ɥi�� q �H���} ) "
	echo ""
    read Menu_No?"�п�ܿﶵ(${FNUM}-${LNUM}) : "
    case $Menu_No in  
        1)
			BASE="_file_attr.bas"
			CURR="_`date +%Y%m%d`_file_attr.chk"
            MENU_INPUT	SSH_CMD
            ;;
        2)
			BASE="_file_exist.bas"
			CURR="_`date +%Y%m%d`_file_exist.chk"
            MENU_INPUT	SSH_CMD
            ;;
        q|Q)
            main
            ;;
        *)
            echo "" 
			echo "[Error]  ��J���~, �п�J (${FNUM}-${LNUM})���ﶵ"
			read Answer?"  ��Enter���~�� "
			STARTA
            ;;
    esac

}
#}}}

#{{{STARTB base file recover menu
STARTB () {

# check user permission
USER_CHECK 

	clear
	FNUM=1
	LNUM=2
	echo " << FIX/FAST ��T�ǿ�t�Ψt�ޱ��ާ@����-[�ɮ��ˮ��٭�] (ALL AIX LPAR)>> "
	echo ""
	echo "                  1:�ɮ��ˮ�BASE���٭�(���ɶ��ݩ�_attr)"
	echo ""
    echo "                  2:�ɮ��ˮ�BASE���٭�(�L�ɶ��ݩ�_exist)"
	echo ""
    echo "                  (�H�ɥi�� q �H���} ) "
	echo ""
    read Menu_No?"�п�ܿﶵ(${FNUM}-${LNUM}) : "
    case $Menu_No in  
        1)
			BASE="_file_attr.bas"
			CURR="_file_attr.bas.${DATE1AGO}"
          	MENU_INPUT	SSH_CMD_RECOVER
			;;
        2)
			BASE="_file_exist.bas"
			CURR="_file_exist.bas.${DATE1AGO}"
          	MENU_INPUT	SSH_CMD_RECOVER
			;;
        q|Q)
            main
            ;;
        *)
            echo "" 
			echo "[Error]  ��J���~, �п�J (${FNUM}-${LNUM})���ﶵ"
			read Answer?"  ��Enter���~�� "
			STARTB
            ;;
    esac

}
#}}}

#{{{STARTC base file modified menu
STARTC () {

# check user permission
USER_CHECK 

	clear
	FNUM=1
	LNUM=4
	echo " << FIX/FAST ��T�ǿ�t�Ψt�ޱ��ާ@����-[�ɮ��ˮ֭ק�] (ALL AIX LPAR)>> "
	echo ""
    echo "                  1:�ɮ��ˮ�BASE�ɤ��e�ܧ�(���ɶ��ݩ�_attr)" 	
	echo ""
    echo "                  2:�ɮ��ˮ�BASE�ɤ��e�ܧ�(�L�ɶ��ݩ�_exist)" 	
	echo ""
    echo "                  3:�ɮ��ˮ�BASE�ɤ��e�R��(���ɶ��ݩ�_attr)" 	
	echo ""
    echo "                  4:�ɮ��ˮ�BASE�ɤ��e�R��(�L�ɶ��ݩ�_exist)" 	
	echo ""
    echo "                  (�H�ɥi�� q �H���} ) "
	echo ""
    read Menu_No?"�п�ܿﶵ(${FNUM}-${LNUM}) : "
    case $Menu_No in  
        1)
			BASE="_file_attr.bas"
			CURR="_`date +%Y%m%d`_file_attr.chk"
          	MENU_INPUT	CNG_DETAL ATTR
			;;
        2)
			BASE="_file_exist.bas"
			CURR="_`date +%Y%m%d`_file_exist.chk"
            MENU_INPUT 	CNG_DETAL EXIST
			;;
		3)
			BASE="_file_attr.bas"
			CURR="_`date +%Y%m%d`_file_attr.chk"
          	MENU_INPUT	CNG_REMOVE ATTR
			;;
        4)
			BASE="_file_exist.bas"
			CURR="_`date +%Y%m%d`_file_exist.chk"
          	MENU_INPUT	CNG_REMOVE EXIST
			;;
        q|Q)
            main
            ;;
        *)
            echo "" 
			echo "[Error]  ��J���~, �п�J (${FNUM}-${LNUM})���ﶵ"
			read Answer?"  ��Enter���~�� "
			STARTC
            ;;
    esac

}
#}}}

#{{{STARTD execute fileaudit program menu
STARTD () {

# check user permission
USER_CHECK 

	clear
	FNUM=1
	LNUM=3
	echo " << FIX/FAST ��T�ǿ�t�Ψt�ޱ��ާ@����-[�ɮ��ˮְ���] (ALL AIX LPAR)>> "
	echo ""
    echo "                  1:�����ɮ��ˮ�BASE�� "
	echo ""
    echo "                  2:�����ɮ��ˮ� "
	echo ""
    echo "                  3:�T�{�ɮ��ˮֵ��G "
	echo ""
    echo "                  (�H�ɥi�� q �H���} ) "
	echo ""
    read Menu_No?"�п�ܿﶵ(${FNUM}-${LNUM}) : "
    case $Menu_No in  
        1)
          	MENU_INPUT SSH_FILEAUDIT_BASE
			;;
        2)
            MENU_INPUT SSH_FILEAUDIT
			;;
        3)
            MENU_INPUT SSH_FILEAUDIT_CAT
			;;
        q|Q)
            main
            ;;
        *)
            echo ""
	    echo "[Error]  ��J���~, �п�J (${FNUM}-${LNUM})���ﶵ"
	    read Answer?"  ��Enter���~�� "
	    STARTD
            ;;
    esac

}
#}}}

#{{{SSH command override the base file
SSH_CMD() {
# Use the ssh copy the current file to override the base file.
# set -x 


	$tlog "#===============================================================#" $LOG
	$tlog "Base �ɧ�s�}�l....." $LOG


	if [[ $hostname = $WKLPAR ]];then	# If lpar is wklpar.
		for hosts in $(cat /tmp/lparlst${USER}.tmp)
		do
			if [[ $WKLPAR = $hosts ]];then # If hosts equal wklpar.

				# Check the fileaudit base and current files 
				chkflag=0
				for FILECHK in "${BASEDIR}/${hosts}${BASE}" "${CURRDIR}/${hosts}${CURR}" 
				do
#					$tlog "test -f  $FILECHK "$LOG
						   test -f  $FILECHK
			 		excstatus=$?
					if [[ $excstatus -gt 0 ]];then
						$tlog "" $LOG
						$tlog "[Error] �D���W�١G[$hosts] $FILECHK file is not exist,Please to check. " $LOG
						$tlog "" $LOG
						chkflag=$(($chkflag + 1))
					fi
				done

#				$tlog "cp ${CURRDIR}/${hostname}${CURR} ${BASEDIR}/${hostname}${BASE}" $LOG
				if [[ $chkflag -eq "0" ]];then
					cp ${CURRDIR}/${hosts}${CURR} ${BASEDIR}/${hosts}${BASE} > /dev/null 2>&1 
					result=$(ls -l ${BASEDIR}/${hosts}${BASE})
					$tlog "�D���W�١G [$hosts] " $LOG
					$tlog "�ɮ��ݩʡG$result" $LOG
				fi
			else # If lpar equal the lparlist.
				# Check the fileaudit base and current files 
				chkflag=0
				for FILECHK in "${BASEDIR}/${hosts}${BASE}" "${CURRDIR}/${hosts}${CURR}" 
				do
#					$tlog "ssh -p 2222 ${USER}@${hosts} test -f  $FILECHK "$LOG
					ssh -p 2222 ${USER}@${hosts} "test -f $FILECHK"
			 		excstatus=$?
					if [[ $excstatus -gt 0 ]];then
						$tlog "[Error] LPAR_Name:($hosts) $FILECHK file is not exist,Please to check. " $LOG
						$tlog "" $LOG
						chkflag=$(($chkflag + 1))
					fi
				done

#				$tlog "ssh -p 2222 ${USER}@${hosts} cp ${CURRDIR}/${hosts}${CURR} ${BASEDIR}/${hosts}${BASE}" $LOG
				ssh -p 2222 ${USER}@${hosts} "cp ${CURRDIR}/${hosts}${CURR} ${BASEDIR}/${hosts}${BASE} > /dev/null 2>&1"
				result=$(ssh -p 2222 ${USER}@${hosts} "ls -l ${BASEDIR}/${hosts}${BASE}")
				$tlog "�D���W�١G [$hosts] " $LOG
				$tlog "�ɮ��ݩʡG$result" $LOG
			fi
		done
	else # If lpar is not wklpar.
			for HOSTLISTA in $(cat /tmp/lparlst${USER}.tmp|wc -w)
			do
# 		  	If hostlist arrary equal 1 but localhost name is not the same input lpar name than show Error.
				if [[ $HOSTLISTA -eq 1 ]];then
					if [[ $hostname != $HOSTLIST ]];then
							$tlog "" $LOG
							$tloag "[Error] Local lpar name:$hostname are not equal input lpar name:$HOSTLIST" $LOG
							$tlog "" $LOG
							read ANSWR?"               ��Enter���~�� "
							main
					fi
				fi
# 			If hostlist arrary great than 1 and lpar name is not wklpar than show Error.
				if [[ $HOSTLISTA -gt 1 ]];then
						$tlog "" $LOG
						$tlog "[Error] Local lpar name:$hostname is not WKLPAR" $LOG
						$tlog "" $LOG
						read ANSWR?"               ��Enter���~�� "
						main
				fi
			done
			# Check the fileaudit base and current files 
			chkflag=0
			for FILECHK in "${BASEDIR}/${hostname}${BASE}" "${CURRDIR}/${hostname}${CURR}" 
			do
#					$tlog "test -f  $FILECHK " $LOG
						   test -f  $FILECHK
				excstatus=$?
				if [[ $excstatus -gt 0 ]];then
					$tlog "" $LOG
					$tlog "[Error] �D���W�١G[$hostname] $FILECHK file is not exist,Please to check. " $LOG
					$tlog "" $LOG
					chkflag=$(($chkflag + 1))
				fi
			done

#			$tlog "cp ${CURRDIR}/${hostname}${CURR} ${BASEDIR}/${hostname}${BASE}" $LOG
			if [[ $chkflag -eq "0" ]];then
				cp ${CURRDIR}/${hostname}${CURR} ${BASEDIR}/${hostname}${BASE} > /dev/null 2>&1 
				result=$(ls -l ${BASEDIR}/${hostname}${BASE})
				$tlog "�D���W�١G [$hostname] " $LOG
				$tlog "�ɮ��ݩʡG$result" $LOG
			fi
	fi
	$tlog "Base �ɧ�s����....." $LOG
}
#}}}

#{{{ SSH command recover the base file
SSH_CMD_RECOVER() {
# Use the ssh recover the base file.
# set -x 

	$tlog "#===============================================================#" $LOG
	$tlog "Base ���٭�}�l....." $LOG


	if [[ $hostname = $WKLPAR ]];then
		for hosts in $(cat /tmp/lparlst${USER}.tmp)
		do
			if [[ $WKLPAR = $hosts ]];then

				# Check the fileaudit base and current files 
				chkflag=0
				for FILECHK in "${BASEDIR}/${hosts}${CURR}" "${BASEDIR}/${hosts}${BASE}" 
				do
#					$tlog "test -f  $FILECHK " $LOG
						   test -f  $FILECHK
			 		excstatus=$?
					if [[ $excstatus -gt 0 ]];then
						$tlog "" $LOG
						$tlog "[Error] �D���W�١G[$hosts] $FILECHK file is not exist,Please to check. " $LOG
						$tlog "" $LOG
						chkflag=$(($chkflag + 1))
					fi
				done

				if [[ $chkflag -eq "0" ]];then
					cp -p ${BASEDIR}/${hosts}${CURR} ${BASEDIR}/${hosts}${BASE} > /dev/null 2>&1 
					result=$(ls -l ${BASEDIR}/${hostname}${BASE})
					$tlog "�D���W�١G [$hosts] " $LOG
					$tlog "�ɮ��ݩʡG$result" $LOG
				fi
			else
				# Check the fileaudit base and current files 
				chkflag=0
				for FILECHK in "${BASEDIR}/${hosts}${CURR}" "${BASEDIR}/${hosts}${BASE}" 
				do
#					$tlog "ssh -p 2222 ${USER}@${hosts} test -f  $FILECHK " $LOG
					ssh -p 2222 ${USER}@${hosts} "test -f $FILECHK"
			 		excstatus=$?
					if [[ $excstatus -gt 0 ]];then
						$tlog "" $LOG
						$tlog "[Error] �D���W�١G[$hosts] $FILECHK file is not exist,Please to check. " $LOG
						$tlog "" $LOG
						chkflag=$(($chkflag + 1))
					fi
				done

#				$tlog "ssh -p 2222 ${USER}@${hosts} cp ${BASEDIR}/${hosts}${CURR} ${BASEDIR}/${hosts}${BASE}" $LOG
#				$tlog "ssh -p 2222 ${USER}@${hosts} ls -l ${BASEDIR}/${hosts}${BASE}" $LOG
				if [[ $chkflag -eq "0" ]];then
				       ssh -p 2222 ${USER}@${hosts} "cp -p ${CURRDIR}/${hosts}${CURR} ${BASEDIR}/${hosts}${BASE} > /dev/null 2>&1 "
					   result=$(ssh -p 2222 ${USER}@${hosts} "ls -l ${BASEDIR}/${hosts}${BASE}")
					   $tlog "�D���W�١G [$hosts] " $LOG
					   $tlog "�ɮ��ݩʡG$result" $LOG
				fi
			fi
		done
	else
			for HOSTLISTA in $(cat /tmp/lparlst${USER}.tmp|wc -w)
			do
# 		  	If hostlist arrary equal 1 but localhost name is not the same input lpar name than show Error.
				if [[ $HOSTLISTA -eq 1 ]];then
					if [[ $hostname != $HOSTLIST ]];then
							$tlog "" $LOG
							$tlog "[Error] Local lpar name:$hostname are not equal input lpar name:$HOSTLIST" $LOG
							$tlog "" $LOG
							read ANSWR?"               ��Enter���~�� "
							main
					fi
				fi
# 			If hostlist arrary great than 1 and lpar name is not wklpar than show Error.
				if [[ $HOSTLISTA -gt 1 ]];then
						$tlog "" $LOG
						echo "[Error] Local lpar name:$hostname is not WKLPAR"
						$tlog "" $LOG
						read ANSWR?"               ��Enter���~�� "
						main
				fi
			done
# 			Check the fileaudit base and current files 
			chkflag=0
			for FILECHK in "${BASEDIR}/${hostname}${CURR}" "${BASEDIR}/${hostname}${BASE}" 
			do
#					$tlog "test -f  $FILECHK " $LOG
						   test -f  $FILECHK
				excstatus=$?
				if [[ $excstatus -gt 0 ]];then
					$tlog "" $LOG
					echo "[Error] �D���W�١G[$hostname] $FILECHK file is not exist,Please to check. "
					$tlog "" $LOG
					chkflag=$(($chkflag + 1))
				fi
			done

#			$tlog "cp ${BASEDIR}/${hostname}${CURR} ${BASEDIR}/${hostname}${BASE}" $LOG
#			$tlog "ls -l ${BASEDIR}/${hostname}${BASE}" $LOG
			if [[ $chkflag -eq "0" ]];then
				cp -p ${BASEDIR}/${hostname}${CURR} ${BASEDIR}/${hostname}${BASE} > /dev/null 2>&1 
				result=$(ls -l ${BASEDIR}/${hostname}${BASE})
				$tlog "�D���W�١G [$hostname] " $LOG
				$tlog "�ɮ��ݩʡG$result" $LOG
			fi
	fi
	$tlog "Base ���٭쵲��....." $LOG
}
#}}}

#{{{SSH command execute fileaudit compare program
SSH_FILEAUDIT() {
# Use the ssh run fileaudit compare program.
# set -x 


	$tlog "#===============================================================#" $LOG
	$tlog "�ɮ��ˮֶ}�l����....." $LOG


	if [[ $hostname = $WKLPAR ]];then	# If lpar is wklpar.
		for hosts in $(cat /tmp/lparlst${USER}.tmp)
		do
			if [[ $WKLPAR = $hosts ]];then # If hosts equal wklpar.

					$tlog "${SHDIR}/dailycheck/fileaudit/main.sh > /dev/null 2>&1  &" $LOG > /dev/null
					${SHDIR}/dailycheck/fileaudit/main.sh > /dev/null 2>&1  &
			 		excstatus=$?
					if [[ $excstatus -eq 0 ]];then
						$tlog "�D���W�١G [$hosts]  OK" $LOG
					else
						$tlog "�D���W�١G [$hosts]  FAILED" $LOG
					fi
			else # If lpar equal the lparlist.
					$tlog "ssh -f -p 2222 ${USER}@${hosts} ${SHDIR}/dailycheck/fileaudit/main.sh > /dev/null 2>&1 " $LOG > /dev/null
					ssh -f -p 2222 ${USER}@${hosts} "${SHDIR}/dailycheck/fileaudit/main.sh > /dev/null 2>&1 "
			 		excstatus=$?
					if [[ $excstatus -eq 0 ]];then
						$tlog "�D���W�١G [$hosts]  OK" $LOG
					else
						$tlog "�D���W�١G [$hosts]  FAILED" $LOG
					fi
			fi
		done
	else # If lpar is not wklpar.
			for HOSTLISTA in $(cat /tmp/lparlst${USER}.tmp|wc -w)
			do
# 		  	If hostlist arrary equal 1 but localhost name is not the same input lpar name than show Error.
				if [[ $HOSTLISTA -eq 1 ]];then
					if [[ $hostname != $HOSTLIST ]];then
							$tlog "" $LOG
							echo "[Error] Local lpar name:$hostname are not equal input lpar name:$HOSTLIST"
							$tlog "" $LOG
							read ANSWR?"               ��Enter���~�� "
							main
					fi
				fi
# 			If hostlist arrary great than 1 and lpar name is not wklpar than show Error.
				if [[ $HOSTLISTA -gt 1 ]];then
						$tlog "" $LOG
						echo "[Error] Local lpar name:$hostname is not WKLPAR"
						$tlog "" $LOG
						read ANSWR?"               ��Enter���~�� "
						main
				fi
			done
					$tlog " ${SHDIR}/dailycheck/fileaudit/main.sh > /dev/null 2>&1  & " $LOG > /dev/null
					${SHDIR}/dailycheck/fileaudit/main.sh > /dev/null 2>&1  &
			 		excstatus=$?
					if [[ $excstatus -eq 0 ]];then
						$tlog "�D���W�١G [$hostname]  OK" $LOG
					else
						$tlog "�D���W�١G [$hostname]  FAILED" $LOG
					fi
	fi
	$tlog "�ɮ��ˮְ��槹��....." $LOG
}
#}}}

#{{{SSH command execute fileaudit genebase program
SSH_FILEAUDIT_BASE() {
# Use the ssh run fileaudit base program.
# set -x 


	$tlog "#===============================================================#" $LOG
	$tlog "�ɮ��ˮ�Base�ɶ}�l....." $LOG


	if [[ $hostname = $WKLPAR ]];then	# If lpar is wklpar.
		for hosts in $(cat /tmp/lparlst${USER}.tmp)
		do
			if [[ $WKLPAR = $hosts ]];then # If hosts equal wklpar.

					${SHDIR}/dailycheck/fileaudit/genbas_file_attr.sh > /dev/null 2>&1  &
			 		excstatus=$?
					if [[ $excstatus -eq 0 ]];then
						$tlog "�D���W�١G [$hosts]  OK" $LOG
					else
						$tlog "�D���W�١G [$hosts]  FAILED" $LOG
					fi
			else # If lpar equal the lparlist.
					ssh -f -p 2222 ${USER}@${hosts} "${SHDIR}/dailycheck/fileaudit/genbas_file_attr.sh > /dev/null 2>&1 "
			 		excstatus=$?
					if [[ $excstatus -eq 0 ]];then
						$tlog "�D���W�١G [$hosts]  OK" $LOG
					else
						$tlog "�D���W�١G [$hosts]  FAILED" $LOG
					fi
			fi
		done
	else # If lpar is not wklpar.
			for HOSTLISTA in $(cat /tmp/lparlst${USER}.tmp|wc -w)
			do
# 		  	If hostlist arrary equal 1 but localhost name is not the same input lpar name than show Error.
				if [[ $HOSTLISTA -eq 1 ]];then
					if [[ $hostname != $HOSTLIST ]];then
							$tlog "" $LOG
							echo "[Error] Local lpar name:$hostname are not equal input lpar name:$HOSTLIST"
							$tlog "" $LOG
							read ANSWR?"               ��Enter���~�� "
							main
					fi
				fi
# 			If hostlist arrary great than 1 and lpar name is not wklpar than show Error.
				if [[ $HOSTLISTA -gt 1 ]];then
						$tlog "" $LOG
						echo "[Error] Local lpar name:$hostname is not WKLPAR"
						$tlog "" $LOG
						read ANSWR?"               ��Enter���~�� "
						main
				fi
			done
					${SHDIR}/dailycheck/fileaudit/genbas_file_attr.sh > /dev/null 2>&1  &
			 		excstatus=$?
					if [[ $excstatus -eq 0 ]];then
						$tlog "�D���W�١G [$hostname]  OK" $LOG
					else
						$tlog "�D���W�١G [$hostname]  FAILED" $LOG
					fi
	fi
	$tlog "�ɮ��ˮ�Base�ɧ���....." $LOG
}
#}}}

#{{{SSH command execute cat fileaudit compare status
SSH_FILEAUDIT_CAT() {
# Use the ssh run fileaudit compare program.
# set -x 


	$tlog "#===============================================================#" $LOG
	$tlog "�T�{�ɮ��ˮְ��浲�G....." $LOG


	if [[ $hostname = $WKLPAR ]];then	# If lpar is wklpar.
		for hosts in $(cat /tmp/lparlst${USER}.tmp)
		do
			if [[ $WKLPAR = $hosts ]];then # If hosts equal wklpar.

					$tlog "cat $LOGDIR/safelog.${hosts}.fileattr.`date +%Y%m%d` " $LOG > /dev/null
					cat $LOGDIR/safelog.${hostname}.fileattr.`date +%Y%m%d`
			 		excstatus=$?
					if [[ $excstatus -eq 0 ]];then
						$tlog "�D���W�١G [$hosts]  OK" $LOG
					else
						$tlog "�D���W�١G [$hosts]  FAILED" $LOG
					fi
			else # If lpar equal the lparlist.
					$tlog "ssh -p 2222 ${USER}@${hosts} cat $LOGDIR/safelog.${hosts}.fileattr.`date +%Y%m%d` " $LOG > /dev/null
					ssh -p 2222 ${USER}@${hosts} "cat $LOGDIR/safelog.${hosts}.fileattr.`date +%Y%m%d` "
			 		excstatus=$?
					if [[ $excstatus -eq 0 ]];then
						$tlog "�D���W�١G [$hosts]  OK" $LOG
					else
						$tlog "�D���W�١G [$hosts]  FAILED" $LOG
					fi
			fi
		done
	else # If lpar is not wklpar.
			for HOSTLISTA in $(cat /tmp/lparlst${USER}.tmp|wc -w)
			do
# 		  	If hostlist arrary equal 1 but localhost name is not the same input lpar name than show Error.
				if [[ $HOSTLISTA -eq 1 ]];then
					if [[ $hostname != $HOSTLIST ]];then
							$tlog "" $LOG
							echo "[Error] Local lpar name:$hostname are not equal input lpar name:$HOSTLIST"
							$tlog "" $LOG
							read ANSWR?"               ��Enter���~�� "
							main
					fi
				fi
# 			If hostlist arrary great than 1 and lpar name is not wklpar than show Error.
				if [[ $HOSTLISTA -gt 1 ]];then
						$tlog "" $LOG
						echo "[Error] Local lpar name:$hostname is not WKLPAR"
						$tlog "" $LOG
						read ANSWR?"               ��Enter���~�� "
						main
				fi
			done
					$tlog "cat $LOGDIR/safelog.${hosts}.fileattr.`date +%Y%m%d` " $LOG > /dev/null
					cat $LOGDIR/safelog.${hostname}.fileattr.`date +%Y%m%d`
			 		excstatus=$?
					if [[ $excstatus -eq 0 ]];then
						$tlog "�D���W�١G [$hostname]  OK" $LOG
					else
						$tlog "�D���W�١G [$hostname]  FAILED" $LOG
					fi
	fi
}
#}}}

#{{{ MODIFIED_DEATIL_BASE
MODIFIED_BASE(){
#set -x
MODE=$1
TYPE=$2

			$tlog "#=======================START to modified the fileaudit base status=================================#" $LOG

			if [[ $hostname = $WKLPAR ]];then
				for hosts in $(cat /tmp/lparlst${USER}.tmp)
				do
					if [[ $hosts = $WKLPAR ]];then
						IFS=";"
						chkflag=0
						for FILENCHG in $(cat /tmp/filechg${USER}.tmp)
						do
						   $tlog "�����ɦW: $FILENCHG " $LOG
						   FILECHK=$(echo $BASE | grep attr | wc -l | awk '{print $1}') 
						   if [[ $FILECHK -eq 1 ]];then
								GREPMODE="[[:digit:]][[:space:]]"
						   else
								GREPMODE="[[:space:]]"
						   fi

						   CHKFILEN=$( grep "${GREPMODE}${FILENCHG}$" ${BASEDIR}/${hosts}${BASE}|wc -l |awk '{print $1}')
						   if [[ $CHKFILEN -lt 1 ]]; then
								$tlog "" $LOG
								$tlog "[Error] ${FILENCHG} ��J���ŭ� " $LOG
								$tlog "" $LOG
								chkflag=$(($chkflag + 1))
						   fi

						   if [[ ! -f ${CURRDIR}/${hosts}${CURR} ]];then
								$tlog "" $LOG
								$tlog "[Error] ${CURRDIR}/${hosts}${CURR} file is not exist,Please to check."  $LOG
								$tlog "" $LOG
						   fi

						   if [[ $chkflag -eq "0" ]];then
							   TOLLNUM=$(wc -l ${BASEDIR}/${hosts}${BASE} | awk '{print $1}')
#CNGLNUM=$(grep -n "[:digit:][[:space:]]${FILENCHG}$" ${BASEDIR}/${hosts}${BASE}| awk -F : '{print $1}' )
							   CNGLNUM=$( grep -n "${GREPMODE}${FILENCHG}$" ${BASEDIR}/${hosts}${BASE} | awk -F : '{print $1}' )
							   HEDLNUM=$(( $CNGLNUM - 1 ))
							   TAILNUM=$(( $TOLLNUM - $CNGLNUM ))
							  #$tlog head -n $HEDLNUM ${BASEDIR}/${hosts}${BASE} > ${BASEDIR}/${hostname}${BASE}.tmp $LOG
							   head -n $HEDLNUM ${BASEDIR}/${hosts}${BASE} > ${BASEDIR}/${hosts}${BASE}.tmp
							  #$tlog grep ${FILENCHG}$ ${CURRDIR}/${hosts}${CURR} >> ${BASEDIR}/${hostname}${BASE}.tmp $LOG
#grep "[0-9][[:space:]]${FILENCHG}$" ${CURRDIR}/${hosts}${CURR} >> ${BASEDIR}/${hosts}${BASE}.tmp
							   grep "${GREPMODE}${FILENCHG}$" ${CURRDIR}/${hosts}${CURR} >> ${BASEDIR}/${hosts}${BASE}.tmp
							  #$tlog tail -n $TAILNUM ${BASEDIR}/${hosts}${BASE} >> ${BASEDIR}/${hostname}${BASE}.tmp $LOG
							   tail -n $TAILNUM ${BASEDIR}/${hosts}${BASE} >> ${BASEDIR}/${hosts}${BASE}.tmp
							  #$tlog mv ${BASEDIR}/${hosts}${BASE}.tmp ${BASEDIR}/${hostname}${BASE} $LOG
							   mv ${BASEDIR}/${hosts}${BASE}.tmp ${BASEDIR}/${hosts}${BASE}
							   modifiedstatus=$( grep "${GREPMODE}${FILENCHG}$" ${BASEDIR}/${hosts}${BASE})
							   $tlog "�ɮײ��ʵ��G�G$modifiedstatus" $LOG
					 	   fi
						done
					else
						$tlog "scp -P 2222 /tmp/filechg${USER}.tmp ${USER}@${hosts}:/tmp/" $LOG
						$tlog "ssh -p 2222 ${USER}@${hosts} ${SHDIR}/fileaudit_base.menu.sh $MODE $TYPE > /dev/null 2>&1 &" $LOG
						scp -P 2222 /tmp/filechg${USER}.tmp ${USER}@${hosts}:/tmp/ > /dev/null 2>&1 
						ssh -p 2222 ${USER}@${hosts} "${SHDIR}/fileaudit_base.menu.sh $MODE $TYPE > /dev/null 2>&1 &" > /dev/null 2>&1
						IFS=";"
						for FILENCHG in $(cat /tmp/filechg${USER}.tmp)
						do
						   FILECHK=$(echo $BASE | grep attr | wc -l | awk '{print $1}') 
						   if [[ $FILECHK -eq 1 ]];then
								GREPMODE="[[:digit:]][[:space:]]"
						   else
								GREPMODE="[[:space:]]"
						   fi
						   #modifiedstatus=$(ssh -p 2222 ${USER}@${hosts} grep "[0-9][[:space:]]${FILENCHG}$" ${BASEDIR}/${hosts}${BASE})
					       modifiedstatus=$(ssh -p 2222 ${USER}@${hosts} grep "${GREPMODE}${FILENCHG}$" ${BASEDIR}/${hosts}${BASE})
					       $tlog "�ɮײ��ʵ��G�G$modifiedstatus" $LOG
						done
					fi
				done
			else
					if [[ ${#HOSTLIST[@]} -eq 1 ]];then
						if [[ $hostname != $HOSTLIST ]];then
								$tlog "" $LOG
								$tlog "[Error] Local lpar name:$hostname are not equal input lpar name:$HOSTLIST" $LOG
								$tlog "" $LOG
								read ANSWR?"               ��Enter���~�� "
								main
						fi
					fi
					# If hostlist arrary great than 1 and lpar name is not wklpar than show Error.
					if [[ ${#HOSTLIST[@]} -gt 1 ]];then
							$tlog "" $LOG
							$tlog "[Error] Local lpar name:$hostname is not WKLPAR " $LOG
							$tlog "" $LOG
							read ANSWR?"               ��Enter���~�� "
							main
					fi
					IFS=";"
					chkflag=0
					for FILENCHG in $(cat /tmp/filechg${USER}.tmp)
					do
						  $tlog "�����ɦW: $FILENCHG " $LOG
						   FILECHK=$(echo $BASE | grep attr | wc -l | awk '{print $1}') 
						   if [[ $FILECHK -eq 1 ]];then
								GREPMODE="[[:digit:]][[:space:]]"
						   else
								GREPMODE="[[:space:]]"
						   fi

						   CHKFILEN=$( grep "${GREPMODE}${FILENCHG}$" ${BASEDIR}/${hostname}${BASE}|wc -l |awk '{print $1}')
						   if [[ $CHKFILEN -lt 1 ]]; then
								$tlog "[Error] ${FILENCHG} ��J���ŭ� " $LOG
								$tlog "" $LOG
								chkflag=$(($chkflag + 1))
						   fi

						   if [[ ! -f ${CURRDIR}/${hostname}${CURR} ]];then
								$tlog "" $LOG
								$tlog "[Error] ${CURRDIR}/${hostname}${CURR} file is not exist,Please to check. " $LOG
								$tlog "" $LOG
								chkflag=$(($chkflag + 1))
						   fi

						   if [[ $chkflag -eq "0" ]];then
							   TOLLNUM=$(wc -l ${BASEDIR}/${hostname}${BASE} | awk '{print $1}')
							   CNGLNUM=$( grep -n "${GREPMODE}${FILENCHG}$" ${BASEDIR}/${hostname}${BASE}| awk -F : '{print $1}' )
							   HEDLNUM=$(( $CNGLNUM - 1 ))
							   TAILNUM=$(( $TOLLNUM - $CNGLNUM ))
							  #$tlog head -n $HEDLNUM ${BASEDIR}/${hostname}${BASE} > ${BASEDIR}/${hostname}${BASE}.tmp $LOG
							   head -n $HEDLNUM ${BASEDIR}/${hostname}${BASE} > ${BASEDIR}/${hostname}${BASE}.tmp
							  #$tlog grep ${FILENCHG}$ ${CURRDIR}/${hostname}${CURR} >> ${BASEDIR}/${hostname}${BASE}.tmp $LOG
							   grep "${GREPMODE}${FILENCHG}$" ${CURRDIR}/${hostname}${CURR} >> ${BASEDIR}/${hostname}${BASE}.tmp
							  #$tlog tail -n $TAILNUM ${BASEDIR}/${hostname}${BASE} >> ${BASEDIR}/${hostname}${BASE}.tmp $LOG
							   tail -n $TAILNUM ${BASEDIR}/${hostname}${BASE} >> ${BASEDIR}/${hostname}${BASE}.tmp
							  #$tlog mv ${BASEDIR}/${hostname}${BASE}.tmp ${BASEDIR}/${hostname}${BASE} $LOG
							   mv ${BASEDIR}/${hostname}${BASE}.tmp ${BASEDIR}/${hostname}${BASE}
						   fi
					 done
			fi

			$tlog "#=======================End  to modified the fileaudit base status=================================#" $LOG
}
#}}}

#{{{ MODIFIED_REMOVE_BASE
MODIFIED_REMOVE_BASE(){
#set -x
MODE=$1
TYPE=$2

			$tlog "#=======================START to modified remove the fileaudit base status=================================#" $LOG

			if [[ $hostname = $WKLPAR ]];then
				for hosts in $(cat /tmp/lparlst${USER}.tmp)
				do
					if [[ $hosts = $WKLPAR ]];then
						IFS=";"
						chkflag=0
						for FILENCHG in $(cat /tmp/filechg${USER}.tmp)
						do
						  $tlog "�M���ɦW: $FILENCHG " $LOG

						   FILECHK=$(echo $BASE | grep attr | wc -l | awk '{print $1}') 
						   if [[ $FILECHK -eq 1 ]];then
								GREPMODE="[[:digit:]][[:space:]]"
						   else
								GREPMODE="[[:space:]]"
						   fi

						   CHKFILEN=$( grep "${GREPMODE}${FILENCHG}$" ${BASEDIR}/${hosts}${BASE}| wc -l |awk '{print $1}')
						   if [[ $CHKFILEN -lt 1 ]]; then
								$tlog "" $LOG
								$tlog "[Error] ${FILENCHG} ��J���ŭ� " $LOG
								$tlog "" $LOG
								chkflag=$(($chkflag + 1))
						   fi

						   if [[ $chkflag -eq "0" ]];then
							    grep -v "${GREPMODE}${FILENCHG}$" ${BASEDIR}/${hosts}${BASE} > ${BASEDIR}/${hosts}${BASE}.tmp
							    mv ${BASEDIR}/${hosts}${BASE}.tmp ${BASEDIR}/${hosts}${BASE}
					       fi
						done
					else
						$tlog "scp -P 2222 /tmp/filechg${USER}.tmp ${USER}@${hosts}:/tmp/" $LOG
						$tlog "ssh -p 2222 ${USER}@${hosts} ${SHDIR}/fileaudit_base.menu.sh $MODE $TYPE > /dev/null 2>&1 &" $LOG
						scp -P 2222 /tmp/filechg${USER}.tmp ${USER}@${hosts}:/tmp/
						ssh -p 2222 ${USER}@${hosts} "${SHDIR}/fileaudit_base.menu.sh $MODE $TYPE > /dev/null 2>&1 &"
					fi
				done
			else
					if [[ ${#HOSTLIST[@]} -eq 1 ]];then
						if [[ $hostname != $HOSTLIST ]];then
								$tlog "" $LOG
								$tlog "[Error] Local lpar name:$hostname are not equal input lpar name:$HOSTLIST" $LOG
								$tlog "" $LOG
								read ANSWR?"               ��Enter���~�� "
								main
						fi
					fi
					# If hostlist arrary great than 1 and lpar name is not wklpar than show Error.
					if [[ ${#HOSTLIST[@]} -gt 1 ]];then
							$tlog "" $LOG
							$tlog "[Error] Local lpar name:$hostname is not WKLPAR" $LOG
							$tlog "" $LOG
							read ANSWR?"               ��Enter���~�� "
							main
					fi
					IFS=";"
					chkflag=0
					for FILENCHG in $(cat /tmp/filechg${USER}.tmp)
					do
						   $tlog "�M���ɦW: $FILENCHG " $LOG

						   FILECHK=$(echo $BASE | grep attr | wc -l | awk '{print $1}') 
						   if [[ $FILECHK -eq 1 ]];then
								GREPMODE="[[:digit:]][[:space:]]"
						   else
								GREPMODE="[[:space:]]"
						   fi

						   CHKFILEN=$( grep "${GREPMODE}${FILENCHG}$" ${BASEDIR}/${hostname}${BASE}|wc -l |awk '{print $1}')
						   if [[ $CHKFILEN -lt 1 ]]; then
								$tog "" $LOG
								$tlog "[Error] ${FILENCHG} ��J���ŭ� " $LOG
								$tog "" $LOG
								chkflag=$(($chkflag + 1))
						   fi

						   if [[ $chkflag -eq "0" ]];then
							    grep -v "${GREPMODE}${FILENCHG}" ${BASEDIR}/${hostname}${BASE} > ${BASEDIR}/${hostname}${BASE}.tmp
							    mv ${BASEDIR}/${hostname}${BASE}.tmp ${BASEDIR}/${hostname}${BASE}
						   fi
					 done
			fi

			$tlog "#=======================End  to modified remove the fileaudit base status=================================#" $LOG
}
#}}}

#{{{MENU_INPUT_LPAR
MENU_INPUT () {
# Setting the LPAR information.  
#set -x
    echo ""
    HOSTN=""
    HOSTLIST=""
    HOSTDIR="/home/se/safechk/cfg/host.lst" 
    timestamp=`date +"%Y%m%d%H%M%S"`
    HOSTNAME=`hostname`
    MODE=$1
	TYPE=$2
	IFS=$OLDIFS

   if [[ "$HOSTN" == "" ]]; then
       echo ""
       echo "                  (�H�ɥi�� q �H���} ) "
       echo "#==========================================================#"
       echo "# ��J�榡(�C�x�D���H�Ů氵�����j): DAP1-1 DAR1-1 LOG1 MDS1#"
       echo "#                                                          #"
       echo "# �s�տ�J�榡: DAP (�@���@�Ӹs��)                         #"
       echo "#                                                          #"
       echo "# �����D���п�J: ALL                                      #"
       echo "#==========================================================#"
#read  -A HOSTN?"��J���ܧ�Base���D���W�� : "
       read  HOSTN?"��J���ܧ�Base���D���W�� : "

	   if [[ "$HOSTN" == "q" ]] || [[ "$HOSTN" == "Q" ]]; then
		   main
	   fi

	   if [[ -z "$HOSTN" ]]; then
			echo ""
			echo "               [Error] �п��J���ܧ󪺥D���W��"
			echo ""
			read ANSWR?"               ��Enter���~�� "
			main
	   fi

	   # check input more then 2 characters 
	   # [:alpha:]�N��^��j�p�g�r���A��YA-Z, a-z
	   # [:alnum:]�N��^��j�p�g�r���μƦr�A��Y 0-9, A-Z, a-z
	   if [[ $HOSTN != [[:alpha:]][[:alnum:]]* ]]; then
				echo "               [Error] ${HOSTN} ��J���ŭ�"
				echo ""
				read ANSWR?"               ��Enter���~�� "
				main
	   fi	

	   rm -f /tmp/lparlst${USER}.tmp	
	   for HOSTN in ${HOSTN[@]}
	   do
		   HOSTN=`echo $HOSTN|tr '[a-z]' '[A-Z]'`
		   case $HOSTN in
			   DAP)
				   set -A HOSTLIST $(cat $HOSTDIR | grep -i ^DAP)
				   ;;
			   DAR)
				   set -A HOSTLIST $(cat $HOSTDIR | grep -i ^DAR)
				   ;;
			   MDS)
				   set -A HOSTLIST $(cat $HOSTDIR | grep -i ^MDS)
				   ;;
			   LOG)
				   set -A HOSTLIST $(cat $HOSTDIR | grep -i ^LOG)
				   ;;
			   FIX)
				   set -A HOSTLIST $(cat $HOSTDIR | grep -i ^FIX)
				   ;;
			   TS)
				   set -A HOSTLIST $(cat $HOSTDIR | grep -i ^TS)
				   ;;
			   ALL)
				   set -A HOSTLIST $(cat $HOSTDIR)
				   ;;
			   *)
				   set -A HOSTLIST $(grep  $(echo ${HOSTN}$) $HOSTDIR)
				   ;;
			esac

		    if [[ -z "$HOSTLIST" ]]; then
				echo ""
				echo "               [Error] ${HOSTN} ��J���ŭ� "
				echo ""
				read ANSWR?"               ��Enter���~�� "
				main
		    fi

			echo ${HOSTLIST[@]} >> /tmp/lparlst${USER}.tmp
	   done

		if [[ $MODE = "CNG_DETAL" || $MODE = "CNG_REMOVE" ]];then
			echo "                  (�H�ɥi�� q �H���} ) "
			echo "#============================================================#"
			echo "# ��J���ܧ󪺥ؿ����ɮ�(�C�Ӯ|���ɮץH;�������j)�p�U:       #"
			echo "# /etc/passwd;/etc/group;/etc/profile;/etc/environment;/tmp  #"
			echo "#============================================================#"
#read -A FILEN?"��J���ܧ󪺥ؿ����ɮ�: "
			read FILEN?"��J���ܧ󪺥ؿ����ɮ�: "

			if [[ "$FILEN" == "q" ]] || [[ "$FILEN" == "Q" ]]; then
			   main
			fi
			if [[ -z "$FILEN" ]]; then
				echo ""
				echo "               [Error] �п��J���ܧ󪺥ؿ����ɮ�"
				echo ""
				read ANSWR?"               ��Enter���~�� "
				main
		    fi
			echo ${FILEN[@]} > /tmp/filechg${USER}.tmp
	   	fi

		if [[ $MODE = "CNG_REMOVE" ]];then
				echo ""
				read ANSWER?"     �нT�{�O�_����(Y/N): "
				case $ANSWER in
					n|N)                                          
				 		main
				 		;;
					y|Y)                                          
						MODIFIED_REMOVE_BASE $MODE $TYPE
				 		;;
					*)                                          
						echo "		[Error]  ��J���~, �п�J(Y/N)"
				        read ANSWR?"               ��Enter���~�� "
				 		main
				 		;;
				esac
		elif [[ $MODE = "CNG_DETAL" ]];then
				echo ""
				read ANSWER?"     �нT�{�O�_����(Y/N): "
				case $ANSWER in
					n|N)                                          
				 		main
				 		;;
					y|Y)                                          
						MODIFIED_BASE $MODE $TYPE
				 		;;
					*)                                          
						echo "		[Error]  ��J���~, �п�J(Y/N)"
				        read ANSWR?"               ��Enter���~�� "
				 		main
				 		;;
				esac
		else
				echo ""
				read ANSWER?"     �нT�{�O�_����(Y/N): "
				case $ANSWER in
					n|N)                                          
				 		main
				 		;;
					y|Y)                                          
						$MODE
						;;
					*)                                          
						echo "		[Error]  ��J���~, �п�J(Y/N)"
				        read ANSWR?"               ��Enter���~�� "
				 		main
				 		;;
				esac
		fi

		read ANSWR?"               ��Enter���~�� "
		main
    fi
}
#}}}

#{{{USER_CHECK
USER_CHECK (){
# check user information.  
	userflag=0
	for chkuser in ${MUSER[@]}
	do
		if [[ $USER = $chkuser ]];then
			userflag=1
			echo $userflag
			break
		fi
	done

	if [[ userflag -eq 0 ]];then 
		echo "               [Error]  �ϥΪ��v�����ŦX"
		echo ""
		read ANSWR?"               ��Enter���~�� "
		main 
	fi
}
#}}}

#{{{Begin 
Begin () {
	if [[ -z $MODE && -z $TYPE ]];then
		main
	else
		if [[ $MODE = "CNG_DETAL" ]];then
			if [[ $TYPE = "ATTR" ]];then
				BASE="_file_attr.bas"
				CURR="_`date +%Y%m%d_file_attr.chk`"
				MODIFIED_BASE $MODE $TYPE
			else
				BASE="_file_exist.bas"
				CURR="_`date +%Y%m%d_file_exist.chk`"
				MODIFIED_BASE $MODE $TYPE
			fi
		fi
	fi
}
#}}}


Begin
