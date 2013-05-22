#!/bin/ksh
#

#----------------------------------
# Set variable
#----------------------------------
hostname=`hostname`
FILEDIR=/home/se/safechk/file/account
BASEFILE=$FILEDIR/base/${hostname}_account_attr.bas
CURRENT=$FILEDIR/check/${hostname}_`date +%Y%m%d_account_attr.chk`
RESULT=$FILEDIR/result/${hostname}_`date +%Y%m%d_user_attr.rst`

#----------------------------------
# Temp file for compare and debug
#----------------------------------
TMP_CUR=$FILEDIR/tmp_current
TMP_BASE=$FILEDIR/tmp_base
LIST_ADD=$FILEDIR/user_add
LIST_DEL=$FILEDIR/user_del
TMP_CHANGE=$FILEDIR/tmp_change
TMP1_CHANGE=$FILEDIR/tmp1_change
LIST_CHANGE=$FILEDIR/user_change

#----------------------------------
# Clear temporary files
#----------------------------------
clear_tmp(){
	rm -f $TMP_BASE
	rm -f $TMP_CUR
	rm -f $TMP_CHANGE
	rm -f $TMP1_CHANGE
	if [ -f $LIST_ADD ]; then
		rm -f $LIST_ADD
	fi
	if [ -f $LIST_DEL ]; then	
		rm -f $LIST_DEL
	fi
	if [ -f $LIST_CHANGE ]; then
		rm -f $LIST_CHANGE
	fi
}

#----------------------------------
# If item were different then show the '^' symbol below it
#----------------------------------
seperater(){
let x=0
while((x<$1))
do
    print -n "$2"
    let x+=1
done
print -n " "
}

#----------------------------------
# Check account had been MODIFIED
#----------------------------------
if [ -f $BASEFILE ]; then #if BASEFILE exist
   echo ---------------------------------------
   echo Date: `date +%Y/%m/%d\ %H:%M`

   lsuser ALL | awk '{print $1}' > $FILEDIR/user.lst
   cat /dev/null > $CURRENT
   while read user
   do
       lsuser $user | awk '{print $1, $3, $4, $5, $6, $19, $2, $23, $24, $38, $39, $28, $27, $37}' >> $CURRENT
   done < $FILEDIR/user.lst

   awk '{print $1}' $CURRENT  > $TMP_CUR
   awk '{print $1}' $BASEFILE > $TMP_BASE
   sort $TMP_CUR -o $TMP_CUR
   sort $TMP_BASE -o $TMP_BASE
   diff $CURRENT $BASEFILE > $TMP_CHANGE

   if [ -s $TMP_CHANGE ]; then
      echo "Failed" > $RESULT
      grep "^< " $TMP_CHANGE > $TMP1_CHANGE
      echo "---------------------------------------"
      echo "Something are different comparing with the basefile:"
      awk '{print $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15}' $TMP1_CHANGE | sort | grep "pgrp" > $LIST_CHANGE
      if [ -s $LIST_CHANGE ]; then
          echo "There are `awk 'END {print NR}' $LIST_CHANGE` users had been MODIFIED"
          echo
          for LINE in `cat $LIST_CHANGE`
          do
             set -A LINE1 `grep "^${LINE}" $BASEFILE`
             execStatus1=$?
             if [ $execStatus1 -eq 0 ]; then
                echo "Base   :" ${LINE1[@]}
             fi

             set -A LINE2 `grep "^${LINE}" $CURRENT`
             execStatus2=$?
             if [ $execStatus2 -eq 0 ]; then
                echo "Current:" ${LINE2[@]}
                print -n "         "				

             let i=0
             while [ $i -lt ${#LINE2[@]} ] ; do
                COUNT=${#LINE2[$i]} #count item length
                if [[ ${LINE1[$i]} = ${LINE2[$i]} ]]; then
                   seperater $COUNT ' '
                else
                   seperater $COUNT '^'
                fi
                let i+=1
             done
             echo
             fi
          done
          echo ---------------------------------------
       else
          echo No users been modified!
          echo ---------------------------------------
       fi

       comm -23 $TMP_CUR $TMP_BASE |grep -v '^$' > $LIST_ADD #compare current and base, delete the empty line then output the added file
       if [ -s $LIST_ADD ]; then #if file not empty
          echo "There are `awk 'END {print NR}' $LIST_ADD` users had been ADDED"
          awk 'NR==FNR{arr[$1];next}$10 in arr' $LIST_ADD $CURRENT #print the added file(s) with Current attributes
          cat $LIST_ADD
          echo ---------------------------------------
       else
          echo No users been added!
          echo ---------------------------------------
       fi
       comm -13 $TMP_CUR $TMP_BASE |grep -v '^$' > $LIST_DEL #compare current and base, delete the empty line then output the deleted file
       if [ -s $LIST_DEL ]; then #if file not empty
          echo "There are `awk 'END {print NR}' $LIST_DEL` users had been DELETED"
          awk 'NR==FNR{arr[$1];next}$10 in arr' $LIST_DEL $BASEFILE #print the deleted file(s) with Base attributes
          cat $LIST_DEL
          echo ---------------------------------------
       else
          echo No users been deleted!
          echo ---------------------------------------
       fi
   else
       echo "OK" > $RESULT
       echo ---------------------------------------
       echo Congratulations!!
       echo
       echo Check status SUCCESS, no user been modified.
       clear_tmp #Clear tmp files, mark "#" before this function to remain temp files for debug
       exit 0
   fi
clear_tmp #Clear tmp files, mark "#" before this function to remain temp files for debug
exit 1
else
   echo Basefile not exist, please execute the script '"genbas_account_attr.sh"' to create !
   exit 1
fi
