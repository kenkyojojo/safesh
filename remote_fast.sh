#!/usr/bin/ksh
HOSTLIST=/home/se/safechk/cfg/host.lst
#HOSTLIST=/tmp/host.lst
SHDIR=/home/se/safechk/safesh
LOGDIR=/home/se/safechk/safelog
DT=`date +'%Y%m%d'`
#============================================================================#
fast() {

		for HOST in `cat $HOSTLIST`
		do
			echo "$HOST Start"
			ssh -p 2222 -f $HOST "${SHDIR}/Network_test.sh > /dev/null 2>&1 "
			echo "$HOST done"
		done
}

check_log() {

		for HOST in `cat $HOSTLIST`
		do
			echo "################## $HOST ##################" 
			ssh -p 2222 $HOST "cat ${LOGDIR}/network_test${DT}.log"
		done
}

scopy() {

		for HOST in `cat $HOSTLIST`
		do
			echo "$HOST scp Start"
			scp -P 2222 ${SHDIR}/Network_test.sh $HOST:/home/se/safechk/safesh > /dev/null 2>&1
			echo "$HOST scp done"
		done
}

main (){

	scopy
	fast	
	sleep 20
	check_log
}
main
