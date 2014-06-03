#!/usr/bin/ksh
USER=$(whoami)
HOSTNAME=$(hostname)
SHDIR="/home/se/safechk/safesh"
LOGDIR="/home/se/safechk/safelog"
LOG="${LOGDIR}/diag_system.log"
BASEDIR="/home/se/safechk/file/diag/base"
CURRDIR="/home/se/safechk/file/diag/check"
RESUDIR="/home/se/safechk/file/diag/result"
FIST="1"
LAST="6"
PORT=22

FUNC_LIB=${SHDIR}/function_lib.sh
. $FUNC_LIB


#{{{START_1 LVM
START_1 (){

menu_input_lpar

HOST_LIST=$(cat /tmp/lparlst${USER}.tmp)
	for host in $HOST_LIST
	do
		tlog "[User:$USER] ssh $host CHECK LVM" $LOG
	    ssh -t -t -p $PORT $host << "EOF"

			BASEDIR="/home/se/safechk/file/diag/base"
			LVMDIR="${BASEDIR}/LVM"
			seq="0"

			# VG Status
			seq=$(($seq+1))
			cat /dev/null > ${LVMDIR}/LVM_BASE_${seq}
			echo "#========Volume Group Status===============#"  >> ${LVMDIR}/LVM_BASE_${seq}
			lspv >> ${LVMDIR}/LVM_BASE_${seq}

			# PV Status
			seq=$(($seq+1))
			cat /dev/null > ${LVMDIR}/LVM_BASE_${seq}
			echo "#========Physical Volume Status============#"  >> ${LVMDIR}/LVM_BASE_${seq}
			for hdisk in $(lspv | awk '{print $1}')
			do
				lspv $hdisk |grep STALE >> ${LVMDIR}/LVM_BASE_${seq}
			done

			# sysdump Status
			seq=$(($seq+1))
			cat /dev/null > ${LVMDIR}/LVM_BASE_${seq}
			echo "#========Sysdump Status====================#"  >> ${LVMDIR}/LVM_BASE_${seq}
			sysdumpev -e >> ${LVMDIR}/LVM_BASE$_{seq}

			# Filesystem Status all status
			#seq=$(($seq+1))
			cat /dev/null > ${LVMDIR}/LVM_BASE_${seq}
			#echo "#========Filesystem Status=================#"  >> ${LVMDIR}/LVM_BASE_${seq}
			#df -g  >> ${LVMDIR}/LVM_BASE_${seq}

			# Filesystem Status usage more than 70% status
			seq=$(($seq+1))
			cat /dev/null > ${LVMDIR}/LVM_BASE_${seq}
			echo "#========Filesystem usage more 70%=========#"  >> ${LVMDIR}/LVM_BASE_${seq}
			df -g | awk '$5 > 70 {print}' | grep -q '/'
			rc=$?
			if [[ $rc -eq "0" ]];then
				df -g | awk '$5 > 70 {print}' >> ${LVMDIR}/LVM_BASE_${seq}
			else
				echo "ALL filesystem less than 70% " >> ${LVMDIR}/LVM_BASE_${seq}
			fi

			#exit the ssh connection
			exit
EOF
	done
}
#}}}

#{{{START_2 MEM
START_2 (){

menu_input_lpar

HOST_LIST=$(cat /tmp/lparlst${USER}.tmp)
	for host in $HOST_LIST
	do
		tlog "[User:$USER] ssh $host CHECK MEM" $LOG
	    ssh -t -t -p $PORT $host << "EOF"

			BASEDIR="/home/se/safechk/file/diag/base"
			MEMDIR="${BASEDIR}/MEM"
			seq="0"

			# Real MEM capacity
			seq=$(($seq+1))
			cat /dev/null > ${LVMDIR}/MEM_BASE_${seq}
			echo "#========Real Memory capacity==============#"  >> ${MEMDIR}/MEM_BASE_${seq}
			TOTLE_MEM=$(lsattr -El sys0 -a realmem) 
			echo $TOTLEMEM>> ${MEMDIR}/MEM_BASE_${seq}

			# Real MEM status
			seq=$(($seq+1))
			cat /dev/null > ${LVMDIR}/MEM_BASE_${seq}
			echo "#========Real Memory status================#"  >> ${MEMDIR}/MEM_BASE_${seq}
			lsdev -C | grep -i mem >> ${MEMDIR}/MEM_BASE_${seq}

			# Free MEM less than 20%
			seq=$(($seq+1))
			cat /dev/null > ${LVMDIR}/MEM_BASE_${seq}
			echo "#========Free Memory less than 20%=========#"  >> ${MEMDIR}/MEM_BASE_${seq}
			USE_MEM=$(svmon -G | grep memory  | awk '{print $3}') 
			FREE_MEM_PERCENT=$(echo "${USE_MEM}/${TOTLE_MEM} * 100" | bc -l )
			if [[ $FREE_MEM_PERCENT -lt "20" ]];then echo "[WARN] FREE_MEM_PERCENT:${FREE_MEM_PERCENT}%" ; else echo "[INFO] FREE_MEM_PERCENT:${FREE_MEM_PERCENT}%" ; fi

			# Real MEM parameter
			seq=$(($seq+1))
			cat /dev/null > ${LVMDIR}/MEM_BASE_${seq}
			echo "#========Real Memory status================#"  >> ${MEMDIR}/MEM_BASE_${seq}
			vmo -a >> ${MEMDIR}/MEM_BASE_${seq}

			#exit the ssh connection
			exit
EOF
	done
}
#}}}

#{{{main
main () {

clear
echo "          << FIX/FAST 資訊傳輸系統維運操作介面(Base Create) (ALL AIX LPAR) >> "
echo ""
echo "        1. Lvm Base"
echo ""
echo "        2. Memory Base"
echo ""
echo "        3. Cpu Base"
echo ""
echo "        4. Process Base"
echo ""
echo "        5. Network Base"
echo ""
echo "        6. All Base"
echo ""
echo "                                (隨時可輸 q 以離開 )"
echo ""
read Menu_No?"                                 請選擇選項 ($FIST-$LAST) : "

case $Menu_No in
	1)
		START_1
		;;
	2)
		START_2
		;;
	3)
		START_3
		;;
	4)
		START_4
		;;
	5)
		START_5
		;;
	6)
		START_6
		;;
	q|Q)
		exit
		;;
	*)
        echo ""
		echo "        [Error]  輸入錯誤, 請輸入 ($FIST-$LAST)的選項"
		read ANSWR?"               按Enter鍵繼續 "
		return 1
		;;
esac
}
#}}}

main
