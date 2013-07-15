#!/bin/ksh
#
#----------------------------------
# Set variable
#----------------------------------
hostname=`hostname`
HOSTN=$(echo $hostname | cut -c 1-3)
CONFIGDIR=/home/se/safechk/cfg
case $HOSTN in
	DAP)
		DIR=`head -1 $CONFIGDIR/dir.conf.dap`
		EXIST=`sed -n '2p' $CONFIGDIR/dir.conf.dap`
		DIRNOTIME=`sed -n '3p' $CONFIGDIR/dir.conf.dap`
		NOCHECK=`sed -n '2p' $CONFIGDIR/dir.conf.dap;sed -n '3p' $CONFIGDIR/dir.conf.dap;sed -n '4p' $CONFIGDIR/dir.conf.dap`
		EXCLUDE=`tail -1 /home/se/safechk/cfg/dir.conf.dap | sed -e 's#\/#\\\/#g' -e 's/ /\/d\" -e \"\//g' -e 's/^/sed -e "\//' -e 's/$/\/d"/'`
		;;
	DAR)
		DIR=`head -1 $CONFIGDIR/dir.conf.dar`
		EXIST=`sed -n '2p' $CONFIGDIR/dir.conf.dar`
		DIRNOTIME=`sed -n '3p' $CONFIGDIR/dir.conf.dar`
		NOCHECK=`sed -n '2p' $CONFIGDIR/dir.conf.dar;sed -n '3p' $CONFIGDIR/dir.conf.dar;sed -n '4p' $CONFIGDIR/dir.conf.dar`
		EXCLUDE=`tail -1 /home/se/safechk/cfg/dir.conf.dar | sed -e 's#\/#\\\/#g' -e 's/ /\/d\" -e \"\//g' -e 's/^/sed -e "\//' -e 's/$/\/d"/'`
		;;
	LOG)
		DIR=`head -1 $CONFIGDIR/dir.conf.log`
		EXIST=`sed -n '2p' $CONFIGDIR/dir.conf.log`
		DIRNOTIME=`sed -n '3p' $CONFIGDIR/dir.conf.log`
		NOCHECK=`sed -n '2p' $CONFIGDIR/dir.conf.log;sed -n '3p' $CONFIGDIR/dir.conf.log;sed -n '4p' $CONFIGDIR/dir.conf.log`
		EXCLUDE=`tail -1 /home/se/safechk/cfg/dir.conf.log | sed -e 's#\/#\\\/#g' -e 's/ /\/d\" -e \"\//g' -e 's/^/sed -e "\//' -e 's/$/\/d"/'`
		;;
	MDS)
		DIR=`head -1 $CONFIGDIR/dir.conf.mds`
		EXIST=`sed -n '2p' $CONFIGDIR/dir.conf.mds`
		DIRNOTIME=`sed -n '3p' $CONFIGDIR/dir.conf.mds`
		NOCHECK=`sed -n '2p' $CONFIGDIR/dir.conf.mds;sed -n '3p' $CONFIGDIR/dir.conf.mds;sed -n '4p' $CONFIGDIR/dir.conf.mds`
		EXCLUDE=`tail -1 /home/se/safechk/cfg/dir.conf.mds | sed -e 's#\/#\\\/#g' -e 's/ /\/d\" -e \"\//g' -e 's/^/sed -e "\//' -e 's/$/\/d"/'`
		;;
	WKL)
		DIR=`head -1 $CONFIGDIR/dir.conf.wkl`
		EXIST=`sed -n '2p' $CONFIGDIR/dir.conf.wkl`
		DIRNOTIME=`sed -n '3p' $CONFIGDIR/dir.conf.wkl`
		NOCHECK=`sed -n '2p' $CONFIGDIR/dir.conf.wkl;sed -n '3p' $CONFIGDIR/dir.conf.wkl;sed -n '4p' $CONFIGDIR/dir.conf.wkl`
		EXCLUDE=`tail -1 /home/se/safechk/cfg/dir.conf.wkl | sed -e 's#\/#\\\/#g' -e 's/ /\/d\" -e \"\//g' -e 's/^/sed -e "\//' -e 's/$/\/d"/'`
		;;
	*)
		DIR=`head -1 $CONFIGDIR/dir.conf`
		EXIST=`sed -n '2p' $CONFIGDIR/dir.conf`
		DIRNOTIME=`sed -n '3p' $CONFIGDIR/dir.conf`
		NOCHECK=`sed -n '2p' $CONFIGDIR/dir.conf;sed -n '3p' $CONFIGDIR/dir.conf;sed -n '4p' $CONFIGDIR/dir.conf`
		EXCLUDE=`tail -1 /home/se/safechk/cfg/dir.conf | sed -e 's#\/#\\\/#g' -e 's/ /\/d\" -e \"\//g' -e 's/^/sed -e "\//' -e 's/$/\/d"/'`
		;;
esac

ALLEXCLUDE=`echo $NOCHECK | sed -e 's#\/#\\\/#g' -e 's/ /\/d\" -e \"\//g' -e 's/^/sed -e "\//' -e 's/$/\/d"/'`

FILEDIR=/home/se/safechk/file/fileaudit

BASEFILE=$FILEDIR/base/${hostname}_file_attr.bas
EXISTBASE=$FILEDIR/base/${hostname}_file_exist.bas
BACKUP_BASE=$FILEDIR/base/${hostname}_previous_file_attr.bas
BACKUP_EXISTBASE=$FILEDIR/base/${hostname}_previous_file_exist.bas
#----------------------------------
#Create the fileaudit base file. 
#----------------------------------

creat_base(){
for DIRNAME in $DIR #import all dir_list from prompt
do
   find $DIRNAME -ls | eval $ALLEXCLUDE | sort -k2  >> $BASEFILE #generate CURRENT status to compare with BASEFILE
done
}


creat_existbase(){
for DIRNAME in $EXIST #import all dir_list from prompt
do
   ls -ld  $DIRNAME  2> /dev/null | eval $EXCLUDE |awk '{print $3,$4,$1,$9}' >> $EXISTBASE
done

for DIRNAME in $DIRNOTIME #Recursive list dir, but don't list the file and directory time. 
do
   find $DIRNAME -ls | eval $EXCLUDE | awk '{print $5,$6,$3,$NF}'  >> $EXISTBASE
done
}


echo Generating the Basefile for auditing
echo ---------------------------------------------------------------
echo IMPORTANT NOTES:
if [ -f $BASEFILE ]; then
	echo Basefile \"$BASEFILE\" already existed
	echo create at \"`ls -l $BASEFILE | awk '{print $6,$7,$8,"and owner/group is",$3"/"$4}'`\"
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
#creat_base $DIR #call function and import the parameter
					creat_base  #call function and import the parameter
                    mv $EXISTBASE $BACKUP_EXISTBASE
#creat_existbase $EXIST $DIRNOTIME
					creat_existbase #call function and import the parameter
# creat_existbase $DIRNOTIME
		    echo "Overwrite basefile $BASEFILE with CURRENT status, Total `awk 'END {print NR}' $BASEFILE` lines"
		    echo "Old basefile backup to \"$BACKUP_BASE\", Total `awk 'END {print NR}' $BACKUP_BASE` lines"
		    echo "Overwrite basefile $EXISTBASE with CURRENT status, Total `awk 'END {print NR}' $EXISTBASE` lines"
		    echo "Old basefile backup to \"$BACKUP_EXISTBASE\", Total `awk 'END {print NR}' $BACKUP_EXISTBASE` lines"
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
#creat_base $DIR
#    creat_existbase $EXIST $DIRNOTIME
	creat_base
    creat_existbase
	exit 0
fi

exit
