#!/bin/ksh

DIR=`head -1 /home/se/safechk/safesh/checksum/check.conf`
EXCLUDE=`tail -1 /home/se/safechk/safesh/checksum/check.conf | sed -e 's#\/#\\\/#g' -e 's/ /\/d\" -e \"\//g' -e 's/^/sed -e "\//' -e 's/$/\/d"/'`

BASEFILE=/home/se/safechk/safesh/checksum/base/chksum_attr.bas
BACKUP_BASE=/home/se/safechk/safesh/checksum/base/previous_chksum_attr.bas
LIST=/home/se/safechk/safesh/checksum/base/base.lst

echo Date: `date +%Y/%m/%d\ %H:%M:%S` >> filecheck.txt

cat /dev/null > $LIST #flush the file to make sure it's fresh
for DIRNAME in $DIR #import all dir_list from commandline prompt
do
   find $DIRNAME -ls | eval $EXCLUDE | awk '{print $11}' >> $LIST
done

creat_base(){
#for CHKNAME in $DIR
#do
#   sum $CHKNAME >> $BASEFILE #generate CURRENT status to compare with BASEFILE
#done
while read file
do
    sum $file >> $BASEFILE
done < $LIST
}


echo Generating the Basefile for auditing
echo ---------------------------------------------------------------
echo IMPORTANT NOTES:
if [ -f $BASEFILE ]; then
	echo Basefile \"$BASEFILE\" already existed
	echo
	echo If you wants to OVERWRITE it, please press \"Y\" or \"N\" to cancle
	echo Don\'t worry, the previous record will be backup!
	while [ $BOTTOM!="Y|y|N|n|Q|q" ]; do
		echo
		read BOTTOM?"Type your choise HERE "\>" "
		case $BOTTOM in
            N|n|Q|q)
                echo "Basefile generate process  CANCLE by user."
                exit 1 ;;
		Y|y)
                mv $BASEFILE $BACKUP_BASE
		creat_base $DIR #call function and import the parameter
		echo "Overwrite basefile $BASEFILE with CURRENT status, Total `awk 'END {print NR}' $BASEFILE` lines"
		echo "Old basefile backup to \"$BACKUP_BASE\", Total `awk 'END {print NR}' $BACKUP_BASE` lines"
		exit 0 ;;
		*)
		echo You enter the wrong input \"$BOTTOM\", please enter the vaild option.
		echo If you wants to OVERWRITE the exist basefile, please press \"Y\" or \"N\" to cancle
		;;
		esac
	done
else
	echo "Creating basefile $BASEFILE and writing the current status in it."
	creat_base $DIR
	exit 0
fi
echo Date: `date +%Y/%m/%d\ %H:%M:%S` >> filecheck.txt
exit
