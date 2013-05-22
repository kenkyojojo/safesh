#!/bin/ksh

DATE=`date +"%Y%m%d"`
hostname=`hostname`
DIR=/home/se/safechk/file/account
BASEFILE=/home/se/safechk/file/account/base/${hostname}_account_attr.bas
BACKUP_BASE=/home/se/safechk/file/account/base/${hostname}_previous_account_attr.bas

lsuser ALL | awk '{print $1}' > $DIR/user.lst

creat_base(){
while read user
do
   lsuser $user | awk '{print $1, $3, $4, $5, $6, $19, $2, $23, $24, $38, $39, $28, $27, $37}' >> $DIR/base/${hostname}_account_attr.bas
done < $DIR/user.lst
}



echo Generating the Basefile for auditing
echo ---------------------------------------------------------------
if [ -f $BASEFILE ]; then
   echo Basefile \"$BASEFILE\" already existed
   echo
   #echo If you wants to OVERWRITE it, please press \"Y\" or \"N\" to cancle
   #echo Don\'t worry, the previous record will be backup!
   #while [ $BOTTOM!="Y|y|N|n|Q|q" ]; do
      #echo
      #read BOTTOM?"Type your choise HERE "\>" "
      #case $BOTTOM in
           #N|n|Q|q)
               #echo "Basefile generate process  CANCLE by user."
               #exit 1 ;;
           #Y|y)
               mv $BASEFILE $BACKUP_BASE
               creat_base
               echo "Overwrite basefile $BASEFILE with CURRENT status, Total `awk 'END {print NR}' $BASEFILE` lines"
               echo "Old basefile backup to \"$BACKUP_BASE\", Total `awk 'END {print NR}' $BACKUP_BASE` lines"
               #exit 0 ;;
               exit 0
           #*)
               #echo You enter the wrong input \"$BOTTOM\", please enter the vaild option.
               #echo If you wants to OVERWRITE the exist basefile, please press \"Y\" or \"N\" to cancle
	       #;;
      #esac
   #done
   exit 0
else
   echo "Creating basefile $BASEFILE and writing the current status in it."
   creat_base
   exit 0
fi

exit
