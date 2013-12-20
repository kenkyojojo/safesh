#!/usr/bin/ksh
FNUM=`cat ./FNUM.txt`
LNUM=`cat ./LNUM.txt`
SYSTEM=`cat ./SYSTEM.txt`
TOTLE=70
WAIT=5
LIMT=25
RANGE=$(($LNUM - $FNUM))

for SYSTEM in $SYSTEM
#for SYSTEM in ibm
do
#step 1  only shutdown the one lpar
		if [[ $FNUM -eq $LNUM ]];then
			echo "To Start Shutdown LPAR_ID:$FNUM"
			echo "Command:chsysstate -m $SYSTEM -o osshutdown -r lpar --id $FNUM --immed"
			chsysstate -m $SYSTEM -o osshutdown -r lpar --id $FNUM --immed 
			STATE=$?
			if [[ $STATE -eq 0 ]];then
				echo "To Start Shutdown LPAR_ID:$FNUM done"
				exit 0
			else 
				echo "To Start Shutdown LPAR_ID:$FNUM Fail"
				exit 1
			fi
		fi

#step 2  shutdown the lpar in the range , If range bigger or equal the LIMT paremeter, when shutdown to the 25 lpar ,and then sleep 5 sec.
		while [[ $FNUM -le $LNUM ]];
        do
			if [[ $RANGE -ge $LIMT ]];then
				count=$(( $count + 1 ))
				if [[ $count -eq $LIMT ]];then
					sleep $WAIT;
					count=0
				fi
			fi
			echo "To Start Shutdown LPAR_ID:$FNUM"
			echo "Command:chsysstate -m $SYSTEM -o osshutdown -r lpar --id $FNUM --immed "
			chsysstate -m $SYSTEM -o osshutdown -r lpar --id $FNUM --immed 
			STATE=$?
			if [[ $STATE -eq 0 ]];then
			echo "To Start Shutdown LPAR_ID:$FNUM done"
				FNUM=$(($FNUM + 1))
			else
			echo "To Start Shutdown LPAR_ID:$FNUM Fail"
				FNUM=$(( $FNUM + 1))
			fi

		done
done

