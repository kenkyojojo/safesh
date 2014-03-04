#!/bin/ksh
hostname=`hostname`
DATEM=`date +%Y%m`
DATE1AGO=`perl -MPOSIX -le 'print strftime "%Y%m%d", localtime(time()-86400);'`
SHDIR=/home/se/safechk/safesh
USER=$(whoami)
LOGDIR=/home/se/safechk/safelog
LOG=${LOGDIR}/fileaudit_base.menu.sh.log
tlog=${SHDIR}/tlog.sh
FILEDIR=/home/se/safechk/file/fileaudit
BASEDIR=${FILEDIR}/base
CURRDIR=${FILEDIR}/check
WKLPAR=WKLPART1
MODE=$1
TYPE=$2
OLDIFS=$IFS
#===============================================================#

#{{{main menu
main () {

	FNUM=1
	LNUM=4
	clear
	echo " << FIX/FAST 資訊傳輸系統系管控操作介面-[檔案檢核] (ALL AIX LPAR)>> "
	echo ""
    echo "                  1:檔案檢核BASE檔更新 "
	echo ""
    echo "                  2:檔案檢核BASE檔還原 "
	echo ""
    echo "                  3:檔案檢核BASE檔變更 "
	echo ""
    echo "                  4:手動執行檔案檢核 "
	echo ""
    echo "                  (隨時可輸 q 以離開 ) "
	echo ""
    read Menu_No?"請選擇選項(${FNUM}-${LNUM}) : "

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
            exit 
            ;;
        *)
            echo "" 
			echo "[Error]  輸入錯誤, 請輸入 (${FNUM}-${LNUM})的選項"
			read Answer?"  按Enter鍵繼續 "
			main
            ;;
	esac
}
#}}}

#{{{STARTA base file orverride menu
STARTA () {

# check user permission
set -A MUSER root seadm bruce
USER_CHECK 

	clear
	FNUM=1
	LNUM=2
	echo " << FIX/FAST 資訊傳輸系統系管控操作介面-[檔案檢核更新] (ALL AIX LPAR)>> "
	echo ""
    echo "                  1:檔案檢核BASE檔更新(有時間屬性_attr)"
	echo ""
    echo "                  2:檔案檢核BASE檔更新(無時間屬性_exist)"
	echo ""
    echo "                  (隨時可輸 q 以離開 ) "
	echo ""
    read Menu_No?"請選擇選項(${FNUM}-${LNUM}) : "
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
			echo "[Error]  輸入錯誤, 請輸入 (${FNUM}-${LNUM})的選項"
			read Answer?"  按Enter鍵繼續 "
			STARTA
            ;;
    esac

}
#}}}

#{{{STARTB base file recover menu
STARTB () {

# check user permission
set -A MUSER root seadm bruce
USER_CHECK 

	clear
	FNUM=1
	LNUM=2
	echo " << FIX/FAST 資訊傳輸系統系管控操作介面-[檔案檢核還原] (ALL AIX LPAR)>> "
	echo ""
	echo "                  1:檔案檢核BASE檔還原(有時間屬性_attr)"
	echo ""
    echo "                  2:檔案檢核BASE檔還原(無時間屬性_exist)"
	echo ""
    echo "                  (隨時可輸 q 以離開 ) "
	echo ""
    read Menu_No?"請選擇選項(${FNUM}-${LNUM}) : "
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
	    echo "[Error]  輸入錯誤, 請輸入 (${FNUM}-${LNUM})的選項"
	    read Answer?"  按Enter鍵繼續 "
		STARTB
            ;;
    esac

}
#}}}

#{{{STARTC base file modified menu
STARTC () {

# check user permission
set -A MUSER root seadm bruce
USER_CHECK 

	clear
	FNUM=1
	LNUM=4
	echo " << FIX/FAST 資訊傳輸系統系管控操作介面-[檔案檢核修改] (ALL AIX LPAR)>> "
	echo ""
    echo "                  1:檔案檢核BASE檔內容變更(有時間屬性_attr)" 	
	echo ""
    echo "                  2:檔案檢核BASE檔內容變更(無時間屬性_exist)" 	
	echo ""
    echo "                  3:檔案檢核BASE檔內容刪除(有時間屬性_attr)" 	
	echo ""
    echo "                  4:檔案檢核BASE檔內容刪除(無時間屬性_exist)" 	
	echo ""
    echo "                  (隨時可輸 q 以離開 ) "
	echo ""
    read Menu_No?"請選擇選項(${FNUM}-${LNUM}) : "
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
			echo "[Error]  輸入錯誤, 請輸入 (${FNUM}-${LNUM})的選項"
			read Answer?"  按Enter鍵繼續 "
			STARTC
            ;;
    esac

}
#}}}

#{{{STARTD execute fileaudit program menu
STARTD () {

# check user permission
set -A MUSER root bruce
USER_CHECK 

	clear
	FNUM=1
	LNUM=2
	echo " << FIX/FAST 資訊傳輸系統系管控操作介面-[檔案檢核執行] (ALL AIX LPAR)>> "
	echo ""
    echo "                  1:產生檔案檢核BASE檔 "
	echo ""
    echo "                  2:執行檔案檢核 "
	echo ""
    echo "                  (隨時可輸 q 以離開 ) "
	echo ""
    read Menu_No?"請選擇選項(${FNUM}-${LNUM}) : "
    case $Menu_No in  
        1)
          	MENU_INPUT SSH_FILEAUDIT_BASE
			;;
        2)
            MENU_INPUT SSH_FILEAUDIT
			;;
        q|Q)
            main
            ;;
        *)
            echo ""
	    echo "[Error]  輸入錯誤, 請輸入 (${FNUM}-${LNUM})的選項"
	    read Answer?"  按Enter鍵繼續 "
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
	$tlog "Base 檔更新開始....." $LOG


	if [[ $hostname = $WKLPAR ]];then	# If lpar is wklpar.
		for hosts in $(cat /tmp/lparlst.tmp)
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
						$tlog "[Error] 主機名稱：[$hosts] $FILECHK file is not exist,Please to check. " $LOG
						$tlog "" $LOG
						chkflag=$(($chkflag + 1))
					fi
				done

#				$tlog "cp ${CURRDIR}/${hostname}${CURR} ${BASEDIR}/${hostname}${BASE}" $LOG
				if [[ $chkflag -eq "0" ]];then
					cp ${CURRDIR}/${hosts}${CURR} ${BASEDIR}/${hosts}${BASE} > /dev/null 2>&1 
					result=$(ls -l ${BASEDIR}/${hosts}${BASE})
					$tlog "主機名稱： [$hosts] " $LOG
					$tlog "檔案屬性：$result" $LOG
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
				$tlog "主機名稱： [$hosts] " $LOG
				$tlog "檔案屬性：$result" $LOG
			fi
		done
	else # If lpar is not wklpar.
			for HOSTLISTA in $(cat /tmp/lparlst.tmp|wc -w)
			do
# 		  	If hostlist arrary equal 1 but localhost name is not the same input lpar name than show Error.
				if [[ $HOSTLISTA -eq 1 ]];then
					if [[ $hostname != $HOSTLIST ]];then
							$tlog "" $LOG
							$tloag "[Error] Local lpar name:$hostname are not equal input lpar name:$HOSTLIST" $LOG
							$tlog "" $LOG
							read ANSWR?"               按Enter鍵繼續 "
							main
					fi
				fi
# 			If hostlist arrary great than 1 and lpar name is not wklpar than show Error.
				if [[ $HOSTLISTA -gt 1 ]];then
						$tlog "" $LOG
						$tlog "[Error] Local lpar name:$hostname is not WKLPAR" $LOG
						$tlog "" $LOG
						read ANSWR?"               按Enter鍵繼續 "
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
					$tlog "[Error] 主機名稱：[$hostname] $FILECHK file is not exist,Please to check. " $LOG
					$tlog "" $LOG
					chkflag=$(($chkflag + 1))
				fi
			done

#			$tlog "cp ${CURRDIR}/${hostname}${CURR} ${BASEDIR}/${hostname}${BASE}" $LOG
			if [[ $chkflag -eq "0" ]];then
				cp ${CURRDIR}/${hostname}${CURR} ${BASEDIR}/${hostname}${BASE} > /dev/null 2>&1 
				result=$(ls -l ${BASEDIR}/${hostname}${BASE})
				$tlog "主機名稱： [$hostname] " $LOG
				$tlog "檔案屬性：$result" $LOG
			fi
	fi
	$tlog "Base 檔更新結束....." $LOG
}
#}}}

#{{{ SSH command recover the base file
SSH_CMD_RECOVER() {
# Use the ssh recover the base file.
# set -x 

	$tlog "#===============================================================#" $LOG
	$tlog "Base檔還原開始....." $LOG


	if [[ $hostname = $WKLPAR ]];then
		for hosts in $(cat /tmp/lparlst.tmp)
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
						$tlog "[Error] 主機名稱：[$hosts] $FILECHK file is not exist,Please to check. " $LOG
						$tlog "" $LOG
						chkflag=$(($chkflag + 1))
					fi
				done

				if [[ $chkflag -eq "0" ]];then
					cp -p ${BASEDIR}/${hosts}${CURR} ${BASEDIR}/${hosts}${BASE} > /dev/null 2>&1 
					result=$(ls -l ${BASEDIR}/${hostname}${BASE})
					$tlog "主機名稱： [$hosts] " $LOG
					$tlog "檔案屬性：$result" $LOG
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
						$tlog "[Error] 主機名稱：[$hosts] $FILECHK file is not exist,Please to check. " $LOG
						$tlog "" $LOG
						chkflag=$(($chkflag + 1))
					fi
				done

#				$tlog "ssh -p 2222 ${USER}@${hosts} cp ${BASEDIR}/${hosts}${CURR} ${BASEDIR}/${hosts}${BASE}" $LOG
#				$tlog "ssh -p 2222 ${USER}@${hosts} ls -l ${BASEDIR}/${hosts}${BASE}" $LOG
				if [[ $chkflag -eq "0" ]];then
				       ssh -p 2222 ${USER}@${hosts} "cp -p ${CURRDIR}/${hosts}${CURR} ${BASEDIR}/${hosts}${BASE} > /dev/null 2>&1 "
					   result=$(ssh -p 2222 ${USER}@${hosts} "ls -l ${BASEDIR}/${hosts}${BASE}")
					   $tlog "主機名稱： [$hosts] " $LOG
					   $tlog "檔案屬性：$result" $LOG
				fi
			fi
		done
	else
			for HOSTLISTA in $(cat /tmp/lparlst.tmp|wc -w)
			do
# 		  	If hostlist arrary equal 1 but localhost name is not the same input lpar name than show Error.
				if [[ $HOSTLISTA -eq 1 ]];then
					if [[ $hostname != $HOSTLIST ]];then
							$tlog "" $LOG
							$tlog "[Error] Local lpar name:$hostname are not equal input lpar name:$HOSTLIST" $LOG
							$tlog "" $LOG
							read ANSWR?"               按Enter鍵繼續 "
							main
					fi
				fi
# 			If hostlist arrary great than 1 and lpar name is not wklpar than show Error.
				if [[ $HOSTLISTA -gt 1 ]];then
						$tlog "" $LOG
						echo "[Error] Local lpar name:$hostname is not WKLPAR"
						$tlog "" $LOG
						read ANSWR?"               按Enter鍵繼續 "
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
					echo "[Error] 主機名稱：[$hostname] $FILECHK file is not exist,Please to check. "
					$tlog "" $LOG
					chkflag=$(($chkflag + 1))
				fi
			done

#			$tlog "cp ${BASEDIR}/${hostname}${CURR} ${BASEDIR}/${hostname}${BASE}" $LOG
#			$tlog "ls -l ${BASEDIR}/${hostname}${BASE}" $LOG
			if [[ $chkflag -eq "0" ]];then
				cp -p ${BASEDIR}/${hostname}${CURR} ${BASEDIR}/${hostname}${BASE} > /dev/null 2>&1 
				result=$(ls -l ${BASEDIR}/${hostname}${BASE})
				$tlog "主機名稱： [$hostname] " $LOG
				$tlog "檔案屬性：$result" $LOG
			fi
	fi
	$tlog "Base 檔還原結束....." $LOG
}
#}}}

#{{{SSH command execute fileaudit compare program
SSH_FILEAUDIT() {
# Use the ssh run fileaudit compare program.
# set -x 


	$tlog "#===============================================================#" $LOG
	$tlog "檔案檢核開始執行....." $LOG


	if [[ $hostname = $WKLPAR ]];then	# If lpar is wklpar.
		for hosts in $(cat /tmp/lparlst.tmp)
		do
			if [[ $WKLPAR = $hosts ]];then # If hosts equal wklpar.

					$tlog "${SHDIR}/dailycheck/fileaudit/main.sh > /dev/null 2>&1  &" $LOG
					${SHDIR}/dailycheck/fileaudit/main.sh > /dev/null 2>&1  &
			 		excstatus=$?
					if [[ $excstatus -eq 0 ]];then
						$tlog "主機名稱： [$hosts]  OK" $LOG
					else
						$tlog "主機名稱： [$hosts]  FAILED" $LOG
					fi
			else # If lpar equal the lparlist.
					$tlog "ssh -f -p 2222 ${USER}@${hosts} ${SHDIR}/dailycheck/fileaudit/main.sh > /dev/null 2>&1 " $LOG
					ssh -f -p 2222 ${USER}@${hosts} "${SHDIR}/dailycheck/fileaudit/main.sh > /dev/null 2>&1 "
			 		excstatus=$?
					if [[ $excstatus -eq 0 ]];then
						$tlog "主機名稱： [$hosts]  OK" $LOG
					else
						$tlog "主機名稱： [$hosts]  FAILED" $LOG
					fi
			fi
		done
	else # If lpar is not wklpar.
			for HOSTLISTA in $(cat /tmp/lparlst.tmp|wc -w)
			do
# 		  	If hostlist arrary equal 1 but localhost name is not the same input lpar name than show Error.
				if [[ $HOSTLISTA -eq 1 ]];then
					if [[ $hostname != $HOSTLIST ]];then
							$tlog "" $LOG
							echo "[Error] Local lpar name:$hostname are not equal input lpar name:$HOSTLIST"
							$tlog "" $LOG
							read ANSWR?"               按Enter鍵繼續 "
							main
					fi
				fi
# 			If hostlist arrary great than 1 and lpar name is not wklpar than show Error.
				if [[ $HOSTLISTA -gt 1 ]];then
						$tlog "" $LOG
						echo "[Error] Local lpar name:$hostname is not WKLPAR"
						$tlog "" $LOG
						read ANSWR?"               按Enter鍵繼續 "
						main
				fi
			done
					$tlog " ${SHDIR}/dailycheck/fileaudit/main.sh > /dev/null 2>&1  & " $LOG
					${SHDIR}/dailycheck/fileaudit/main.sh > /dev/null 2>&1  &
			 		excstatus=$?
					if [[ $excstatus -eq 0 ]];then
						$tlog "主機名稱： [$hostname]  OK" $LOG
					else
						$tlog "主機名稱： [$hostname]  FAILED" $LOG
					fi
	fi
	$tlog "檔案檢核執行完成....." $LOG
}
#}}}

#{{{SSH command execute fileaudit base program
SSH_FILEAUDIT_BASE() {
# Use the ssh run fileaudit base program.
# set -x 


	$tlog "#===============================================================#" $LOG
	$tlog "檔案檢核Base檔開始....." $LOG


	if [[ $hostname = $WKLPAR ]];then	# If lpar is wklpar.
		for hosts in $(cat /tmp/lparlst.tmp)
		do
			if [[ $WKLPAR = $hosts ]];then # If hosts equal wklpar.

#$tlog "	${SHDIR}/dailycheck/fileaudit/genbas_file_attr.sh > /dev/null 2>&1  &" $LOG
					${SHDIR}/dailycheck/fileaudit/genbas_file_attr.sh > /dev/null 2>&1  &
			 		excstatus=$?
					if [[ $excstatus -eq 0 ]];then
						$tlog "主機名稱： [$hosts]  OK" $LOG
					else
						$tlog "主機名稱： [$hosts]  FAILED" $LOG
					fi
			else # If lpar equal the lparlist.
#$tlog "	ssh -f -p 2222 ${USER}@${hosts} ${SHDIR}/dailycheck/fileaudit/genbas_file_attr.sh > /dev/null 2>&1 " $LOG
					ssh -f -p 2222 ${USER}@${hosts} "${SHDIR}/dailycheck/fileaudit/genbas_file_attr.sh > /dev/null 2>&1 "
			 		excstatus=$?
					if [[ $excstatus -eq 0 ]];then
						$tlog "主機名稱： [$hosts]  OK" $LOG
					else
						$tlog "主機名稱： [$hosts]  FAILED" $LOG
					fi
			fi
		done
	else # If lpar is not wklpar.
			for HOSTLISTA in $(cat /tmp/lparlst.tmp|wc -w)
			do
# 		  	If hostlist arrary equal 1 but localhost name is not the same input lpar name than show Error.
				if [[ $HOSTLISTA -eq 1 ]];then
					if [[ $hostname != $HOSTLIST ]];then
							$tlog "" $LOG
							echo "[Error] Local lpar name:$hostname are not equal input lpar name:$HOSTLIST"
							$tlog "" $LOG
							read ANSWR?"               按Enter鍵繼續 "
							main
					fi
				fi
# 			If hostlist arrary great than 1 and lpar name is not wklpar than show Error.
				if [[ $HOSTLISTA -gt 1 ]];then
						$tlog "" $LOG
						echo "[Error] Local lpar name:$hostname is not WKLPAR"
						$tlog "" $LOG
						read ANSWR?"               按Enter鍵繼續 "
						main
				fi
			done
#$tlog "${SHDIR}/dailycheck/fileaudit/genbas_file_attr.sh > /dev/null 2>&1  &" $LOG
					${SHDIR}/dailycheck/fileaudit/genbas_file_attr.sh > /dev/null 2>&1  &
			 		excstatus=$?
					if [[ $excstatus -eq 0 ]];then
						$tlog "主機名稱： [$hostname]  OK" $LOG
					else
						$tlog "主機名稱： [$hostname]  FAILED" $LOG
					fi
	fi
	$tlog "檔案檢核Base檔完成....." $LOG
}
#}}}

#{{{ MODIFIED_DEATIL_BASE
MODIFIED_BASE(){
#set -x
MODE=$1
TYPE=$2

			$tlog "#=======================START to modified the fileaudit base status=================================#" $LOG

			if [[ $hostname = $WKLPAR ]];then
				for hosts in $(cat /tmp/lparlst.tmp)
				do
					if [[ $hosts = $WKLPAR ]];then
						IFS=";"
						chkflag=0
						for FILENCHG in $(cat /tmp/filechg.tmp)
						do
						  $tlog "The modified file name:$FILENCHG" $LOG
					   	   CHKFILEN=$(grep "[[:space:]]${FILENCHG}$" ${BASEDIR}/${hostname}${BASE}|wc -l |awk '{print $1}')
						   if [[ $CHKFILEN -lt 1 ]]; then
								$tlog "" $LOG
								$tlog "[Error] ${FILENCHG} 輸入為空值 " $LOG
								$tlog "" $LOG
								chkflag=$(($chkflag + 1))
						   fi

						   if [[ ! -f ${CURRDIR}/${hostname}${CURR} ]];then
								$tlog "" $LOG
								$tlog "[Error] ${CURRDIR}/${hostname}${CURR} file is not exist,Please to check."  $LOG
								$tlog "" $LOG
						   fi

						   if [[ $chkflag -eq "0" ]];then
							   TOLLNUM=$(wc -l ${BASEDIR}/${hostname}${BASE} | awk '{print $1}')
							   CNGLNUM=$(grep -n "[[:space:]]${FILENCHG}$" ${BASEDIR}/${hostname}${BASE}| awk -F : '{print $1}' )
							   HEDLNUM=$(( $CNGLNUM - 1 ))
							   TAILNUM=$(( $TOLLNUM - $CNGLNUM ))
							  #$tlog head -n $HEDLNUM ${BASEDIR}/${hostname}${BASE} > ${BASEDIR}/${hostname}${BASE}.tmp $LOG
							   head -n $HEDLNUM ${BASEDIR}/${hostname}${BASE} > ${BASEDIR}/${hostname}${BASE}.tmp
							  #$tlog grep ${FILENCHG}$ ${CURRDIR}/${hostname}${CURR} >> ${BASEDIR}/${hostname}${BASE}.tmp $LOG
							   grep "[[:space:]]${FILENCHG}$" ${CURRDIR}/${hostname}${CURR} >> ${BASEDIR}/${hostname}${BASE}.tmp
							  #$tlog tail -n $TAILNUM ${BASEDIR}/${hostname}${BASE} >> ${BASEDIR}/${hostname}${BASE}.tmp $LOG
							   tail -n $TAILNUM ${BASEDIR}/${hostname}${BASE} >> ${BASEDIR}/${hostname}${BASE}.tmp
							  #$tlog mv ${BASEDIR}/${hostname}${BASE}.tmp ${BASEDIR}/${hostname}${BASE} $LOG
							   mv ${BASEDIR}/${hostname}${BASE}.tmp ${BASEDIR}/${hostname}${BASE}
					 	   fi
						done
					else
						$tlog "scp -P 2222 /tmp/filechg.tmp ${USER}@${hosts}:/tmp/" $LOG
						$tlog "ssh -p 2222 ${USER}@${hosts} ${SHDIR}/fileaudit_base.menu.sh $MODE $TYPE > /dev/null 2>&1 &" $LOG
						scp -P 2222 /tmp/filechg.tmp ${USER}@${hosts}:/tmp/
						ssh -p 2222 ${USER}@${hosts} "${SHDIR}/fileaudit_base.menu.sh $MODE $TYPE > /dev/null 2>&1 &"
					fi
				done
			else
					if [[ ${#HOSTLIST[@]} -eq 1 ]];then
						if [[ $hostname != $HOSTLIST ]];then
								$tlog "" $LOG
								echo "[Error] Local lpar name:$hostname are not equal input lpar name:$HOSTLIST"
								$tlog "" $LOG
								read ANSWR?"               按Enter鍵繼續 "
								main
						fi
					fi
					# If hostlist arrary great than 1 and lpar name is not wklpar than show Error.
					if [[ ${#HOSTLIST[@]} -gt 1 ]];then
							$tlog "" $LOG
							echo "[Error] Local lpar name:$hostname is not WKLPAR"
							$tlog "" $LOG
							read ANSWR?"               按Enter鍵繼續 "
							main
					fi
					IFS=";"
					chkflag=0
					for FILENCHG in $(cat /tmp/filechg.tmp)
					do
					  $tlog "The modified file name:$FILENCHG" $LOG
					   CHKFILEN=$(grep "[[:space:]]${FILENCHG}$" ${BASEDIR}/${hostname}${BASE}|wc -l |awk '{print $1}')
					   if [[ $CHKFILEN -lt 1 ]]; then
							echo "[Error] ${FILENCHG} 輸入為空值 "
							$tlog "" $LOG
							chkflag=$(($chkflag + 1))
					   fi

					   if [[ ! -f ${CURRDIR}/${hostname}${CURR} ]];then
							$tlog "" $LOG
							echo "[Error] ${CURRDIR}/${hostname}${CURR} file is not exist,Please to check. "
							$tlog "" $LOG
							chkflag=$(($chkflag + 1))
					   fi

						if [[ $chkflag -eq "0" ]];then
						   TOLLNUM=$(wc -l ${BASEDIR}/${hostname}${BASE} | awk '{print $1}')
						   CNGLNUM=$(grep -n "[[:space:]]${FILENCHG}$" ${BASEDIR}/${hostname}${BASE}| awk -F : '{print $1}' )
						   HEDLNUM=$(( $CNGLNUM - 1 ))
						   TAILNUM=$(( $TOLLNUM - $CNGLNUM ))
						  #$tlog head -n $HEDLNUM ${BASEDIR}/${hostname}${BASE} > ${BASEDIR}/${hostname}${BASE}.tmp $LOG
						   head -n $HEDLNUM ${BASEDIR}/${hostname}${BASE} > ${BASEDIR}/${hostname}${BASE}.tmp
						  #$tlog grep ${FILENCHG}$ ${CURRDIR}/${hostname}${CURR} >> ${BASEDIR}/${hostname}${BASE}.tmp $LOG
						   grep "[[:space:]]${FILENCHG}$" ${CURRDIR}/${hostname}${CURR} >> ${BASEDIR}/${hostname}${BASE}.tmp
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
				for hosts in $(cat /tmp/lparlst.tmp)
				do
					if [[ $hosts = $WKLPAR ]];then
						IFS=";"
						for FILENCHG in $(cat /tmp/filechg.tmp)
						do
					  $tlog "The modified file name:$FILENCHG" $LOG
					   	   CHKFILEN=$(grep "[[:space:]]${FILENCHG}$" ${BASEDIR}/${hostname}${BASE}|wc -l )
						   if [[ $CHKFILEN -lt 1 ]]; then
								$tlog "" $LOG
								echo "[Error] ${FILENCHG} 輸入為空值 "
								$tlog "" $LOG
								read ANSWR?"               按Enter鍵繼續 "
								main
						   fi

				   		   grep -v "[[:space;]]${FILENCHG}$" ${BASEDIR}/${hostname}${BASE} > ${BASEDIR}/${hostname}${BASE}.tmp
						   mv ${BASEDIR}/${hostname}${BASE}.tmp ${BASEDIR}/${hostname}${BASE}
						done
					else
						$tlog "scp -P 2222 /tmp/filechg.tmp ${USER}@${hosts}:/tmp/" $LOG
						$tlog "ssh -p 2222 ${USER}@${hosts} ${SHDIR}/fileaudit_base.menu.sh $MODE $TYPE > /dev/null 2>&1 &" $LOG
						scp -P 2222 /tmp/filechg.tmp ${USER}@${hosts}:/tmp/
						ssh -p 2222 ${USER}@${hosts} "${SHDIR}/fileaudit_base.menu.sh $MODE $TYPE > /dev/null 2>&1 &"
					fi
				done
			else
					if [[ ${#HOSTLIST[@]} -eq 1 ]];then
						if [[ $hostname != $HOSTLIST ]];then
								$tlog "" $LOG
								echo "[Error] Local lpar name:$hostname are not equal input lpar name:$HOSTLIST"
								$tlog "" $LOG
								read ANSWR?"               按Enter鍵繼續 "
								main
						fi
					fi
					# If hostlist arrary great than 1 and lpar name is not wklpar than show Error.
					if [[ ${#HOSTLIST[@]} -gt 1 ]];then
							$tlog "" $LOG
							echo "[Error] Local lpar name:$hostname is not WKLPAR"
							$tlog "" $LOG
							read ANSWR?"               按Enter鍵繼續 "
							main
					fi
					IFS=";"
					for FILENCHG in $(cat /tmp/filechg.tmp)
					do
					  $tlog "The modified file name:$FILENCHG" $LOG
					   CHKFILEN=$(grep "[[:space:]]${FILENCHG}$" ${BASEDIR}/${hostname}${BASE}|wc -l )
					   if [[ $CHKFILEN -lt 1 ]]; then
							echo "[Error] ${FILENCHG} 輸入為空值 "
							echo ""
							read ANSWR?"               按Enter鍵繼續 "
							main
					   fi

					   grep -v "${FILENCHG}$" ${BASEDIR}/${hostname}${BASE} > ${BASEDIR}/${hostname}${BASE}.tmp
					   mv ${BASEDIR}/${hostname}${BASE}.tmp ${BASEDIR}/${hostname}${BASE}
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
       echo "                  (隨時可輸 q 以離開 ) "
       echo "#==========================================================#"
       echo "# 輸入格式(每台主機以空格做為分隔): DAP1-1 DAR1-1 LOG1 MDS1#"
       echo "#                                                          #"
       echo "# 群組輸入格式: DAP (一次一個群組)                         #"
       echo "#                                                          #"
       echo "# 全部主機請輸入: ALL                                      #"
       echo "#==========================================================#"
#read  -A HOSTN?"輸入欲變更Base的主機名稱 : "
       read  HOSTN?"輸入欲變更Base的主機名稱 : "

	   if [[ "$HOSTN" == "q" ]] || [[ "$HOSTN" == "Q" ]]; then
		   main
	   fi

	   if [[ -z "$HOSTN" ]]; then
			echo ""
			echo "               [Error] 請輸輸入欲變更的主機名稱"
			echo ""
			read ANSWR?"               按Enter鍵繼續 "
			main
	   fi

	   # check input more then 2 characters 
	   # [:alpha:]代表英文大小寫字元，亦即A-Z, a-z
	   # [:alnum:]代表英文大小寫字元及數字，亦即 0-9, A-Z, a-z
	   if [[ $HOSTN != [[:alpha:]][[:alnum:]]* ]]; then
				echo "               [Error] ${HOSTN} 輸入為空值"
				echo ""
				read ANSWR?"               按Enter鍵繼續 "
				main
	   fi	

	   rm -f /tmp/lparlst.tmp	
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
				echo "               [Error] ${HOSTN} 輸入為空值 "
				echo ""
				read ANSWR?"               按Enter鍵繼續 "
				main
		    fi

			echo ${HOSTLIST[@]} >> /tmp/lparlst.tmp
	   done

		if [[ $MODE = "CNG_DETAL" || $MODE = "CNG_REMOVE" ]];then
			echo "                  (隨時可輸 q 以離開 ) "
			echo "#============================================================#"
			echo "# 輸入欲變更的目錄或檔案(每個徑或檔案以;做為分隔)如下:       #"
			echo "# /etc/passwd;/etc/group;/etc/profile;/etc/environment;/tmp  #"
			echo "#============================================================#"
#read -A FILEN?"輸入欲變更的目錄或檔案: "
			read FILEN?"輸入欲變更的目錄或檔案: "

			if [[ "$FILEN" == "q" ]] || [[ "$FILEN" == "Q" ]]; then
			   main
			fi
			if [[ -z "$FILEN" ]]; then
				echo ""
				echo "               [Error] 請輸輸入欲變更的目錄或檔案"
				echo ""
				read ANSWR?"               按Enter鍵繼續 "
				main
		    fi
			echo ${FILEN[@]} > /tmp/filechg.tmp
	   	fi

		if [[ $MODE = "CNG_REMOVE" ]];then
				echo ""
				read ANSWER?"     請確認是否執行(Y/N): "
				case $ANSWER in
					n|N)                                          
				 		main
				 		;;
					y|Y)                                          
						MODIFIED_REMOVE_BASE $MODE $TYPE
				 		;;
					*)                                          
						echo "		[Error]  輸入錯誤, 請輸入(Y/N)"
				        read ANSWR?"               按Enter鍵繼續 "
				 		main
				 		;;
				esac
		elif [[ $MODE = "CNG_DETAL" ]];then
				echo ""
				read ANSWER?"     請確認是否執行(Y/N): "
				case $ANSWER in
					n|N)                                          
				 		main
				 		;;
					y|Y)                                          
						MODIFIED_BASE $MODE $TYPE
				 		;;
					*)                                          
						echo "		[Error]  輸入錯誤, 請輸入(Y/N)"
				        read ANSWR?"               按Enter鍵繼續 "
				 		main
				 		;;
				esac
		else
				echo ""
				read ANSWER?"     請確認是否執行(Y/N): "
				case $ANSWER in
					n|N)                                          
				 		main
				 		;;
					y|Y)                                          
						$MODE
						;;
					*)                                          
						echo "		[Error]  輸入錯誤, 請輸入(Y/N)"
				        read ANSWR?"               按Enter鍵繼續 "
				 		main
				 		;;
				esac
		fi

		read ANSWR?"               按Enter鍵繼續 "
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
		echo "               [Error]  使用者權限不符合"
		echo ""
		read ANSWR?"               按Enter鍵繼續 "
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
