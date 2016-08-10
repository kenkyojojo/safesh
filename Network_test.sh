#!/bin/ksh
V101="10.204.3.161"
V102="10.240.102.101"
V34="10.3.10.254"
V34_2="10.4.10.254"
V134="10.13.10.254"
V134_2="10.14.10.254"
V21="10.204.103.254"
V2="10.204.102.254"
V3="10.204.102.254"
V4="10.199.168.171"
V5="10.203.3.254"
V6="10.203.1.254"
V9="11.201.108.254"
V109="17.201.108.254"
V10="10.204.2.254"
IB="10.204.5.71"
HOSTNAME=`hostname`
DT=`date +'%Y%m%d'`
LOGFILE="/home/se/safechk/safelog/network_test${DT}.log"
echo $HOSTNAME > $LOGFILE

MIS () {
	ping -q	-c 2 -w	2 $V101	> /dev/null 2>&1
	if [ $?	== 0 ];	then
		echo "V101 ping	$V101 OK" >> $LOGFILE
	else
		echo "V101 ping	$V101 Fail" >> $LOGFILE
	fi

	ping -q	-c 2 -w	2 $V102	> /dev/null 2>&1
	if [ $?	== 0 ];	then
		echo "V102 ping	$V102 OK" >> $LOGFILE
	else
		echo "V102 ping	$V102 Fail" >> $LOGFILE
	fi

}

FIXGW () {
	ping -q	-c 2 -w	2 $V21 > /dev/null 2>&1
	if [ $?	== 0 ];	then
		echo "V21 ping $V21 OK"	>> $LOGFILE
	else
		echo "V21 ping $V21 Fail" >> $LOGFILE
	fi

	ping -q	-c 2 -w	2 $IB >	/dev/null 2>&1
	if [ $?	== 0 ];	then
		echo "IB ping $IB OK" >> $LOGFILE
	else
		echo "IB ping $IB Fail"	>> $LOGFILE
	fi

}

manage_VLAN () {
	ping -q	-c 2 -w	2 $V4 >	/dev/null 2>&1
	if [ $?	== 0 ];	then
		echo "V4 ping $V4 OK" >> $LOGFILE
	else
		echo "V4 ping $V4 Fail"	>> $LOGFILE
	fi

	ping -q	-c 2 -w	2 $V5 >	/dev/null 2>&1
	if [ $?	== 0 ];	then
		echo "V5 ping $V5 OK" >> $LOGFILE
	else
		echo "V5 ping $V5 Fail"	>> $LOGFILE
	fi


}
shared_VLAN () {
	ping -q	-c 2 -w	2 $V6 >	/dev/null 2>&1
	if [ $?	== 0 ];	then
		echo "V6 ping $V6 OK" >> $LOGFILE
	else
		echo "V6 ping $V6 Fail"	>> $LOGFILE
	fi

	ping -q	-c 2 -w	2 $V10 > /dev/null 2>&1
	if [ $?	== 0 ];	then
		echo "V10 ping $V10 OK"	>> $LOGFILE
	else
		echo "V10 ping $V10 Fail" >> $LOGFILE
	fi

}

case $HOSTNAME in
	MIS1)
	  MIS

	  ping -q -c 2 -w 2 $V34 > /dev/null 2>&1
	  if [ $? == 0 ]; then
		  echo "V34 ping $V34 OK" >> $LOGFILE
	  else
		  echo "V34 ping $V34 Fail" >> $LOGFILE
	  fi

	  ping -q -c 2 -w 2 $V3	> /dev/null 2>&1
	  if [ $? == 0 ]; then
		  echo "V3 ping	$V3 OK"	>> $LOGFILE
	  else
		  echo "V3 ping	$V3 Fail" >> $LOGFILE
	  fi

	  ping -q -c 2 -w 2 $V9	> /dev/null 2>&1
	  if [ $? == 0 ]; then
		  echo "V9 ping	$V9 OK"	>> $LOGFILE
	  else
		  echo "V9 ping	$V9 Fail" >> $LOGFILE
	  fi

	  manage_VLAN
	  shared_VLAN
	  ;;

	MIS2)
	  MIS

	  ping -q -c 2 -w 2 $V34_2 > /dev/null 2>&1
	  if [ $? == 0 ]; then
		  echo "V34_2 ping $V34_2 OK" >> $LOGFILE
	  else
		  echo "V34_2 ping $V34_2 Fail"	>> $LOGFILE
	  fi

	  ping -q -c 2 -w 2 $V3	> /dev/null 2>&1
	  if [ $? == 0 ]; then
		  echo "V3 ping	$V3 OK"	>> $LOGFILE
	  else
		  echo "V3 ping	$V3 Fail" >> $LOGFILE
	  fi

	  ping -q -c 2 -w 2 $V9	> /dev/null 2>&1
	  if [ $? == 0 ]; then
		  echo "V9 ping	$V9 OK"	>> $LOGFILE
	  else
		  echo "V9 ping	$V9 Fail" >> $LOGFILE
	  fi

	  manage_VLAN
	  shared_VLAN
	  ;;
	OTCMIS1)
	  MIS

	  ping -q -c 2 -w 2 $V134 > /dev/null 2>&1
	  if [ $? == 0 ]; then
		  echo "V134 ping $V134	OK" >> $LOGFILE
	  else
		  echo "V134 ping $V134	Fail" >> $LOGFILE
	  fi

	  ping -q -c 2 -w 2 $V2	> /dev/null 2>&1
	  if [ $? == 0 ]; then
		  echo "V2 ping	$V2 OK"	>> $LOGFILE
	  else
		  echo "V2 ping	$V2 Fail" >> $LOGFILE
	  fi

	  ping -q -c 2 -w 2 $V109 > /dev/null 2>&1
	  if [ $? == 0 ]; then
		  echo "V109 ping $V109	OK" >> $LOGFILE
	  else
		  echo "V109 ping $V109	Fail" >> $LOGFILE
	  fi

	  manage_VLAN
	  shared_VLAN
	  ;;
	OTCMIS2)
	  MIS

	  ping -q -c 2 -w 2 $V134_2 > /dev/null	2>&1
	  if [ $? == 0 ]; then
		  echo "V134_2 ping $V134_2 OK"	>> $LOGFILE
	  else
		  echo "V134_2 ping $V134_2 Fail" >> $LOGFILE
	  fi

	  ping -q -c 2 -w 2 $V2	> /dev/null 2>&1
	  if [ $? == 0 ]; then
		  echo "V2 ping	$V2 OK"	>> $LOGFILE
	  else
		  echo "V2 ping	$V2 Fail" >> $LOGFILE
	  fi

	  ping -q -c 2 -w 2 $V109 > /dev/null 2>&1
	  if [ $? == 0 ]; then
		  echo "V109 ping $V109	OK" >> $LOGFILE
	  else
		  echo "V109 ping $V109	Fail" >> $LOGFILE
	  fi

	  manage_VLAN
	  shared_VLAN
	;;
	FIXGW01P)
	  FIXGW

	  ping -q -c 2 -w 2 $V9	> /dev/null 2>&1
	  if [ $? == 0 ]; then
		  echo "V9 ping	$V9 OK"	>> $LOGFILE
	  else
		  echo "V9 ping	$V9 Fail" >> $LOGFILE
	  fi

	  manage_VLAN
	  shared_VLAN
	  ;;
	FIXGW01B)
	  FIXGW

	  ping -q -c 2 -w 2 $V9	> /dev/null 2>&1
	  if [ $? == 0 ]; then
		  echo "V9 ping	$V9 OK"	>> $LOGFILE
	  else
		  echo "V9 ping	$V9 Fail" >> $LOGFILE
	  fi

	  manage_VLAN
	  shared_VLAN
	  ;;
	FIXGW02P)
	  FIXGW

	  ping -q -c 2 -w 2 $V9	> /dev/null 2>&1
	  if [ $? == 0 ]; then
		  echo "V9 ping	$V9 OK"	>> $LOGFILE
	  else
		  echo "V9 ping	$V9 Fail" >> $LOGFILE
	  fi

	  manage_VLAN
	  shared_VLAN
	  ;;
	FIXGW02B)
	  FIXGW

	  ping -q -c 2 -w 2 $V9	> /dev/null 2>&1
	  if [ $? == 0 ]; then
		  echo "V9 ping	$V9 OK"	>> $LOGFILE
	  else
		  echo "V9 ping	$V9 Fail" >> $LOGFILE
	  fi

	  manage_VLAN
	  shared_VLAN
	  ;;
	OTCFIXGW01P)
	  FIXGW

	  ping -q -c 2 -w 2 $V109 > /dev/null 2>&1
	  if [ $? == 0 ]; then
		  echo "V109 ping $V109	OK" >> $LOGFILE
	  else
		  echo "V109 ping $V109	Fail" >> $LOGFILE
	  fi

	  manage_VLAN
	  shared_VLAN
	  ;;
	OTCFIXGW01B)
	  FIXGW

	  ping -q -c 2 -w 2 $V109 > /dev/null 2>&1
	  if [ $? == 0 ]; then
		  echo "V109 ping $V109	OK" >> $LOGFILE
	  else
		  echo "V109 ping $V109	Fail" >> $LOGFILE
	  fi

	  manage_VLAN
	  shared_VLAN
	  ;;
	OTCFIXGW02P)
	  FIXGW

	  ping -q -c 2 -w 2 $V109 > /dev/null 2>&1
	  if [ $? == 0 ]; then
		  echo "V109 ping $V109	OK" >> $LOGFILE
	  else
		  echo "V109 ping $V109	Fail" >> $LOGFILE
	  fi

	  manage_VLAN
	  shared_VLAN
	  ;;
	OTCFIXGW02B)
	  FIXGW

	  ping -q -c 2 -w 2 $V109 > /dev/null 2>&1
	  if [ $? == 0 ]; then
		  echo "V109 ping $V109	OK" >> $LOGFILE
	  else
		  echo "V109 ping $V109	Fail" >> $LOGFILE
	  fi

	  manage_VLAN
	  shared_VLAN
	  ;;

	*)
	  manage_VLAN
	  ;;
esac

cat  $LOGFILE
