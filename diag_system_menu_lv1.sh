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

user_check $USER
rc=$?
if [[ $rc -eq 0 ]];then
	:
else
	echo ""
	echo "      $USER 無權限使用此功能, 請洽系統管理員"
	read ANSWR?"                 按Enter鍵繼續 "
	exit 1
fi

create_log $USER $LOG

case $Menu_No in
	1)
		${SHDIR}/diag_system_lvm_lv2.sh			
		;;
	2)
		${SHDIR}/diag_system_mem_lv2.sh			
		;;
	3)
		${SHDIR}/diag_system_cpu_lv2.sh			
		;;
	4)
		${SHDIR}/diag_system_pro_lv2.sh			
		;;
	5)
		${SHDIR}/diag_system_net_lv2.sh			
		;;
	6)
		${SHDIR}/diag_system_base_lv2.sh			
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
