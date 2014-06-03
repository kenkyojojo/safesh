#!/usr/bin/ksh
USER=$(whoami)
HOSTNAME=$(hostname)
SHDIR="/home/se/safechk/safesh"
LOGDIR="/home/se/safechk/safelog"
LOG="${LOGDIR}/diag_system.log"
FIST="1"
LAST="6"

FUNC_LIB=${SHDIR}/function_lib.sh
. $FUNC_LIB


#{{{START_1
START_1 (){

menu_input_lpar
HOST_LIST=$(cat /tmp/lparlst${USER}.tmp)

	for host in $HOST_LIST
	do
		tlog "[User:$USER] ssh $host ls -ld /tmp" $LOG
	done
}
#}}}

#{{{main
main () {

clear
echo "          << FIX/FAST 資訊傳輸系統維運操作介面 (ALL AIX LPAR)>> "
echo ""
echo "        1. LVM"
echo ""
echo "        2. MEM"
echo ""
echo "        3. CPU"
echo ""
echo "        4. PROC"
echo ""
echo "        5. NETWOKR"
echo ""
echo "        6. BASE"
echo ""
echo "                                (隨時可輸 q 以離開 )"
echo ""
read Menu_No?"                                 請選擇選項 ($FIST-$LAST) : "
#create_log

case $Menu_No in
	1)
		user_check $USER
		rc=$?
		if [[ $rc -eq 0 ]];then
			START_1
		else
			echo "      $USER 無權限使用此功能, 請洽系統管理員"
			read ANSWR?"                 按Enter鍵繼續 "
			main
		fi
		;;
	2)
		user_check $USER
		rc=$?
		if [[ $rc -eq 0 ]];then
			START_2
		else
			echo "      $USER 無權限使用此功能, 請洽系統管理員"
			read ANSWR?"                 按Enter鍵繼續 "
			main
		fi
		;;
	q|Q)
		exit
		;;
	*)
        echo ""
		echo "        [Error]  輸入錯誤, 請輸入 ($FIST-$LAST)的選項"
		read ANSWR?"               按Enter鍵繼續 "
		main
		;;
esac
}
#}}}

main
