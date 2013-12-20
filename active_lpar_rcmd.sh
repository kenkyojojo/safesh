#!/usr/bin/ksh
FNUM=`cat ./FNUM.txt`
LNUM=`cat ./LNUM.txt`
SYSTEM=`cat ./SYSTEM.txt`
TOTLE=70
PFILE=FIX_FAST
WAIT=5
LIMT=25
RANGE=$(($LNUM - $FNUM))

for SYSTEM in $SYSTEM
do
#step 1  only active the one lpar
		if [[ $FNUM -eq $LNUM ]];then
			echo "To Start Active LPAR_ID:$FNUM"
			echo "Command:chsysstate -m $SYSTEM -o on -r lpar --id $FNUM  -f $PFILE"
			chsysstate -m $SYSTEM -o on -r lpar --id $FNUM  -f $PFILE
			STATE=$?
			if [[ $STATE -eq 0 ]];then
				echo "To Start Active LPAR_ID:$FNUM done"
				exit 0
			else 
				echo "To Start Active LPAR_ID:$FNUM Fail"
				exit 1
			fi
		fi

#step 2  active the lpar in the range , If range bigger or equal the LIMT paremeter, when active to the 25 lpar ,and then sleep 5 sec.
		while [[ $FNUM -le $LNUM ]];
        do
			if [[ $RANGE -ge $LIMT ]];then
				count=$(( $count + 1 ))
				if [[ $count -eq $LIMT ]];then
					sleep $WAIT;
					count=0
				fi
			fi

			echo "To Start Active LPAR_ID:$FNUM"
			echo "Command:chsysstate -m $SYSTEM -o on -r lpar --id $FNUM  -f $PFILE"
			chsysstate -m $SYSTEM -o on -r lpar --id $FNUM  -f $PFILE
			STATE=$?
			if [[ $STATE -eq 0 ]];then
			echo "To Start Active LPAR_ID:$FNUM done"
				FNUM=$(($FNUM + 1))
			else
			echo "To Start Active LPAR_ID:$FNUM Fail"
				FNUM=$(($FNUM + 1))
			fi
		done
done
