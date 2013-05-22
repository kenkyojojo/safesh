#!/bin/ksh

DIR=`head -1 check.conf` #read examine list from the first line of config file check.conf
EXCLUDE=`tail -1 /home/se/safechk/safesh/checksum/check.conf | sed -e 's#\/#\\\/#g' -e 's/ /\/d\" -e \"\//g' -e 's/^/sed -e "\//' -e 's/$/\/d"/'`

CURRENT=/home/se/safechk/safesh/checksum/check/`date +%Y%m%d_chksum_attr.chk`
BASEFILE=/home/se/safechk/safesh/checksum/base/chksum_attr.bas
RESULT=/home/se/safechk/safesh/checksum/result/`date +%Y%m%d_file_attr.rst`
LIST=/home/se/safechk/safesh/checksum/file.lst

#-------------------
#Temp file for compare and debug
TMP_CHANGE=/home/se/safechk/safesh/checksum/tmp_change
#TMP1_CHANGE=/home/se/safechk/safesh/checksum/tmp1_change
LIST_CHANGE=/home/se/safechk/safesh/checksum/file_change

clear_tmp(){  #clear temperary files
	rm $TMP_CHANGE
	#rm $TMP1_CHANGE
	if [ -f $LIST_CHANGE ]; then
		rm $LIST_CHANGE
	fi
}

seperater(){
let x=0
while((x<$1))
do
    print -n "$2"
	let x+=1
done
print -n " "
}

if [ -f $BASEFILE ]; then #if BASEFILE exist
    echo
    echo Reading Basefile to compare Checksum ...
    echo
    echo Total `awk 'END {print NR}' $BASEFILE` files in the checking list #print line number in the end
    echo
    echo Date: `date +%Y/%m/%d\ %H:%M`

    cat /dev/null > $LIST #flush the file to make sure it's fresh
    for DIRNAME in $DIR #import all dir_list from commandline prompt
    do
        find $DIRNAME -ls | eval $EXCLUDE | awk '{print $11}' >> $LIST
    done


    #cat /dev/null > $CURRENT #flush the file to make sure it's fresh
    #for CHKNAME in $DIR #import all dir_list from commandline prompt
    #do
    #   sum $CHKNAME >> $CURRENT
    #done
    while read file
    do
       sum $file >> $BASEFILE
    done < $LIST
    diff $CURRENT $BASEFILE > $TMP_CHANGE   #creat origin difference file
	
    if [ -s $TMP_CHANGE ]; then
       echo "Failed" > $RESULT #write faild log to result
       #grep "^. " $TMP_CHANGE > $TMP1_CHANGE
       echo ---------------------------------------
       echo Something are different comparing with the basefile:
       echo "Format: CheckSUM Block Filename"
       echo
       awk '{print $4, $2, $3}' $TMP_CHANGE | sort > $LIST_CHANGE
       if [ -s $LIST_CHANGE ]; then
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
                     if [[ ${LINE1[$i]} = ${LINE2[$i]} ]]; then #compare LINE1 and LINE2
                          seperater $COUNT ' ' #first para "count length", second para "insert char"
                     else
                          seperater $COUNT '^' #if item were different than show the '^' symbol below it
                     fi
                     let i+=1
               done
               echo
               fi
           done
        echo ---------------------------------------
        else
           echo No files been modified!
           echo ---------------------------------------
        fi
	else
           echo "OK" > $RESULT #return the final result to file
           echo ---------------------------------------
           echo Congratulations!!
           echo
           echo Auditing check status SUCCESS, no files been touched.
           clear_tmp #Clear tmp files, mark "#" before this function to remain temp files for debug
           exit 0
	fi
        clear_tmp #Clear tmp files, mark "#" before this function to remain temp files for debug
else
    echo Basefile not exist, please execute the script '"genbas_chksum.sh"' to create !
    exit 1
fi
