#!/bin/ksh
#For this script to work properly you need to take a snapshot of the directory
#you want to monitor and pipe the result to "BASEFILE".
#You can also enter the directory you would like to monitor by typing it after
#the command to run the script and hit enter example : ./script_name Directory_to_Monitor
#If you dont want to enter a directory to monitor at the command-line you can
#also enter the directory to monitor in the script at the "DIR" line.

#author : Stev.Hsu TWSE
#date	: 2012.02.24
#version: beta 1.0
#add function: multiple dir_list parameters input from commandline - 2012.02.27
#add function: use symbol '^' to mark MODIFIED attribute - 2012.03.03
#add function: add dir.conf to set the searching and exclude folder - 2012.03.08
#add function: use EXCLUDE attribute to bypass special file or folder - 2012.03.13


#----------------------------------
# Set variable
#----------------------------------
hostname=`hostname`
SHELL=filecheck.sh
SHDIR=/home/se/safechk/safesh
SITE=TSEOB1
CONFIGDIR=/home/se/safechk/cfg
FILEDIR=/home/se/safechk/file/fileaudit
LOGDIR=/home/se/safechk/safelog
DATEM=`date +%Y%m`
LOG=$LOGDIR/${DATEM}.${hostname}.${SHELL}.log
HOSTN=$(echo $hostname | cut -c 1-3)

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
	OTC)
		DIR=`head -1 $CONFIGDIR/dir.conf.otc`
		EXIST=`sed -n '2p' $CONFIGDIR/dir.conf.otc`
		DIRNOTIME=`sed -n '3p' $CONFIGDIR/dir.conf.otc`
		NOCHECK=`sed -n '2p' $CONFIGDIR/dir.conf.otc;sed -n '3p' $CONFIGDIR/dir.conf.otc;sed -n '4p' $CONFIGDIR/dir.conf.otc`
		EXCLUDE=`tail -1 /home/se/safechk/cfg/dir.conf.otc | sed -e 's#\/#\\\/#g' -e 's/ /\/d\" -e \"\//g' -e 's/^/sed -e "\//' -e 's/$/\/d"/'`
		;;
	FIX)
		DIR=`head -1 $CONFIGDIR/dir.conf.fix`
		EXIST=`sed -n '2p' $CONFIGDIR/dir.conf.fix`
		DIRNOTIME=`sed -n '3p' $CONFIGDIR/dir.conf.fix`
		NOCHECK=`sed -n '2p' $CONFIGDIR/dir.conf.fix;sed -n '3p' $CONFIGDIR/dir.conf.fix;sed -n '4p' $CONFIGDIR/dir.conf.fix`
		EXCLUDE=`tail -1 /home/se/safechk/cfg/dir.conf.fix | sed -e 's#\/#\\\/#g' -e 's/ /\/d\" -e \"\//g' -e 's/^/sed -e "\//' -e 's/$/\/d"/'`
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
EXCLUDE_EXIST=`echo $EXIST | sed -e 's#\/#\\\/#g' -e 's/ /\$\/d\" -e \"\//g' -e 's/^/sed -e "\//' -e 's/$/\/d"/'`


BASEFILE=$FILEDIR/base/${hostname}_file_attr.bas
EXISTBASE=$FILEDIR/base/${hostname}_file_exist.bas
CURRENT=$FILEDIR/check/${hostname}_`date +%Y%m%d_file_attr.chk`
#CURRENT_MODI=$FILEDIR/check/${hostname}_`date +%Y%m%d_modified_file_attr.chk`
CURRENT_MODI=$FILEDIR/${hostname}_`date +%Y%m%d_modified_file_attr.chk`
CURRENT_EXIST=$FILEDIR/check/${hostname}_`date +%Y%m%d_file_exist.chk`
RESULT=$FILEDIR/result/${hostname}_`date +%Y%m%d_file_attr.rst`
RESULT_EXIST=$FILEDIR/result/${hostname}_`date +%Y%m%d_file_exist.rst`
FILECHG=$LOGDIR/${hostname}_`date +%Y%m%d_file_attr.chg`
FILECHG_EXIST=$LOGDIR/${hostname}_`date +%Y%m%d_file_exist.chg`
CHKDIR=/home/se/chk/fileaudit
debugmod="1"		# for debug! (1=on , 0=off)

#----------------------------------
# Temp file for compare and debug
#----------------------------------
TMP_CUR=$FILEDIR/tmp_current
TMP_CUR_MODI=$FILEDIR/tmp_current_modi
TMP_BASE=$FILEDIR/tmp_base
TMP_CHANGE=$FILEDIR/tmp_change
TMP_CHANGETWO=$FILEDIR/tmp_changetwo
TMP_CHANGETRE=$FILEDIR/tmp_changetre
TMP_DEBUG=$FILEDIR/DEBUG
LIST_ADD=$FILEDIR/file_add
LIST_DEL=$FILEDIR/file_del
LIST_CHANGE=$FILEDIR/file_change

TMP_EXISTCUR=$FILEDIR/tmp_exist_current
TMP_EXISTBASE=$FILEDIR/tmp_exist_base
TMP_EXISTCHANGE=$FILEDIR/tmp_exist_change
LIST_EXISTADD=$FILEDIR/file_exist_add
LIST_EXISTDEL=$FILEDIR/file_exist_del
LIST_EXISTCHANGE=$FILEDIR/file_exist_change

echo "#============================================================#" >> $LOG

#{{{tlog
#-----------------------
# Show running step status
#-----------------------
tlog() {
    msg=$1
	if [ "$debugmod" = "1" ]; then
		dt=`date +"%y/%m/%d %H:%M:%S"`
		echo "DATE: [${dt}] $msg" >> $LOG
	fi
}
#}}}

#{{{check_base_file
#----------------------------------
# To check the  base files exists
#----------------------------------
check_base_file(){
tlog "Running check_base_file start"
BASE_FILE=`grep 'exists' $CHKDIR/fileaudit.status|wc -l`
	cat /dev/null > $CHKDIR/fileaudit.status

	if [ ! -f $BASEFILE ];then 
		echo "Failed:The $BASEFILE file is not exists" 
		echo "Failed:The $BASEFILE file is not exists" >> $CHKDIR/fileaudit.status
	fi
	if [ ! -f $EXISTBASE ];then 
		echo "Failed:The $EXISTBASE file is not exists"
		echo "Failed:The $EXISTBASE file is not exists" >> $CHKDIR/fileaudit.status 
	fi

	if  [ "$BASE_FILE" -ge 1 ] ;then
		exit
	fi
tlog "Running check_base_file end"
}
#}}}

#{{{clear_tmp
#----------------------------------
# Clear temporary files
#----------------------------------
clear_tmp(){
tlog "Running clear_tmp start"
   rm $TMP_BASE
   rm $TMP_CUR
   rm $TMP_CUR_MODI
#   rm $TMP_CHANGE
   rm $TMP_EXISTBASE
   rm $TMP_EXISTCUR
   rm $TMP_EXISTCHANGE


   if [ -f $TMP_DEBUG ]; then
      rm $TMP_DEBUG
   fi

   if [ -f $TMP_CHANGETWO ]; then
      rm $TMP_CHANGETWO
   fi

   if [ -f $LIST_ADD ]; then
      rm $LIST_ADD
   fi
   if [ -f $LIST_DEL ]; then	
      rm $LIST_DEL
   fi
   if [ -f $LIST_CHANGE ]; then
      rm $LIST_CHANGE
   fi

   if [ -f $LIST_EXISTADD ]; then
      rm $LIST_EXISTADD
   fi
   if [ -f $LIST_EXISTDEL ]; then	
      rm $LIST_EXISTDEL
   fi
   if [ -f $LIST_EXISTCHANGE ]; then
      rm $LIST_EXISTCHANGE
   fi

   if [ -f $CURRENT_MODI ]; then
	  rm -f $CURRENT_MODI
   fi
tlog "Running clear_tmp end"
}
#}}}

#{{{seperater
#----------------------------------
# If item were different then show the '^' symbol below it
#----------------------------------
seperater() {
let x=0
while((x<$1))
do
    print -n "$2"
	let x+=1
done
print -n " "
}
#}}}

#{{{daily_check_status
#----------------------------------
# check_status 
# 1.echo "OK" or "failed" to $CHKDIR/fileaudit.status for the /home/se/chk/'s dailycheck.
# 2.if the fileaudit.status no file has modified, then cp the current attr.bas over write the original attr.bas .
# 3.為seadm日檢核所產生確認檔
#----------------------------------
daily_check_status(){
RESULT=`grep 'Failed' $RESULT|wc -l`
RESULT_EXIST=`grep 'Failed' $RESULT_EXIST|wc -l`
tlog "Running daily_check_status start"

cat /dev/null > $CHKDIR/fileaudit.status

if  [ "$RESULT_EXIST" -ge 1 ] ;then
	echo "Check_exist Failed" >> $CHKDIR/fileaudit.status
else
	echo "Check_exist OK" >>  $CHKDIR/fileaudit.status
fi

if [ "$RESULT" -ge 1 ] ;then
	echo "Check_modified Failed" >> $CHKDIR/fileaudit.status
else
	tlog "Current attr.bas has over write the original attr.bas"
	echo "Check_modified OK" >> $CHKDIR/fileaudit.status
	cp $CURRENT $BASEFILE
fi
 
tlog "Running daily_check_status end"
}
#}}}

#{{{check_exist
#----------------------------------
# Check File or Directory exist
# 不檢查檔案時間屬性
#----------------------------------
check_exist(){
#set -x 

tlog "Running check_exist start"
echo 
echo "#============================================================#"
echo "# The SITE:$SITE"
echo "# The Hostname:$hostname"
#echo "# File or Directory exist check"
echo "# 檢查檔案及目錄(無時間屬性)"
#echo "# Total `awk 'END {print NR}' $EXISTBASE` files in the checking list"
echo "# 共檢查 `awk 'END {print NR}' $EXISTBASE` 檔案"
echo "# Date: `date +%Y/%m/%d\ %H:%M`"
echo "#============================================================#"
cat /dev/null > $RESULT_EXIST #flush the check_status_file

if [ -f $EXISTBASE ]; then
   cat /dev/null > $CURRENT_EXIST
   for DIRNAME in $EXIST
   do
		ls -ld  $DIRNAME  2>/dev/null | eval $EXCLUDE |awk '{print $3,$4,$1,$9}'  >> $CURRENT_EXIST 
		#${SHDIR}/sels -ld $DIRNAME  2>/dev/null | eval $EXCLUDE |awk '{print $3,$4,$1,$9}'  >> $CURRENT_EXIST 
   done

   for DIRNAME in $DIRNOTIME #Recursive list dir, but don't list the file and directory time.
   do
		find $DIRNAME -ls 2>/dev/null | eval $EXCLUDE | awk '{print $5,$6,$3,$NF}'  >> $CURRENT_EXIST
		#${SHDIR}/sefind $DIRNAME -ls 2>/dev/null | eval $EXCLUDE | awk '{print $5,$6,$3,$NF}'  >> $CURRENT_EXIST
   done

   awk '{if ($4~/\/dev\// || $5~/\/dev\//) if ($1~/c/ || $1~/b/) {print $4} else {print $4} else {print $4}}' $CURRENT_EXIST > $TMP_EXISTCUR
   awk '{if ($4~/\/dev\// || $5~/\/dev\//) if ($1~/c/ || $1~/b/) {print $4} else {print $4} else {print $4}}' $EXISTBASE > $TMP_EXISTBASE
   sort $CURRENT_EXIST  -o  $CURRENT_EXIST
   sort $EXISTBASE -o $EXISTBASE
   #diff $CURRENT_EXIST $EXISTBASE | sed -e "/ \/etc$/d" > $TMP_EXISTCHANGE
   diff $CURRENT_EXIST $EXISTBASE  > $TMP_EXISTCHANGE

####################################################################################
# 檢查是否有檔案異動
####################################################################################
   if [ -s $TMP_EXISTCHANGE ]; then
		  echo "#============================================================#"
#echo Something are different comparing with the basefile:
		  awk '{print $5}' $TMP_EXISTCHANGE | sort | uniq -d | grep -v '^$' > $LIST_EXISTCHANGE
		  if [ -s $LIST_EXISTCHANGE ]; then
			  echo "EXISTCHANGE Failed" > $RESULT_EXIST
			  cat $LIST_EXISTCHANGE > $FILECHG_EXIST
#echo "There are `awk 'END {print NR}' $LIST_EXISTCHANGE` files had been MODIFIED"
			  echo "共有 `awk 'END {print NR}' $LIST_EXISTCHANGE` 檔案異動"

			  for LINE in `cat $LIST_EXISTCHANGE`
			  do
				 set -A LINE1 `grep " ${LINE}$" $EXISTBASE`
				 execStatus1=$?
				 if [ $execStatus1 -eq 0 ]; then
					echo "Base   :" ${LINE1[@]}
				 fi

				 set -A LINE2 `grep " ${LINE}$" $CURRENT_EXIST`
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
                	echo ""
				 fi
			  done
			  echo ---------------------------------------
		  else
          	  echo 無異動檔案
#	  echo No files been modified!
			  echo ---------------------------------------
		  fi
	 else
          echo 無異動檔案
		  #echo No files been modified!
		  echo ---------------------------------------
   fi
####################################################################################
# 檢查是否有新增檔案
####################################################################################
      sort $TMP_EXISTCUR -o $TMP_EXISTCUR
      sort $TMP_EXISTBASE -o $TMP_EXISTBASE
      comm -23 $TMP_EXISTCUR $TMP_EXISTBASE |grep -v '^$' > $LIST_EXISTADD #compare current and base, delete the empty line then output the added file
      if [ -s $LIST_EXISTADD ]; then #if file not empty
          echo "EXISTCHANGE ADD Failed" >> $RESULT_EXIST
		  #echo "There are `awk 'END {print NR}' $LIST_EXISTADD` files had been ADDED"
          echo "共有 `awk 'END {print NR}' $LIST_EXISTADD` 檔案新增"
#          awk 'NR==FNR{arr[$1];next}$4 in arr' $LIST_EXISTADD $CURRENT_EXIST #print the added file(s) with Current attributes

		  for ADD in `cat $LIST_EXISTADD`
		  do
			  grep "${ADD}$" $CURRENT_EXIST
		  done
#cat $LIST_EXISTADD
          echo ---------------------------------------
      else
          echo 無新增檔案
	      #echo No files been added!
          echo ---------------------------------------
      fi
####################################################################################
# 檢查是否有被檔案刪除
####################################################################################
      comm -13 $TMP_EXISTCUR $TMP_EXISTBASE |grep -v '^$' > $LIST_EXISTDEL
      if [ -s $LIST_EXISTDEL ]; then
      echo "EXISTCHANGE DEL Failed" >> $RESULT_EXIST
		  #echo "There are `awk 'END {print NR}' $LIST_EXISTDEL` files had been DELETED"
          echo "共有 `awk 'END {print NR}' $LIST_EXISTDEL` 檔案刪除"
#          awk 'NR==FNR{arr[$1];next}$4 in arr' $LIST_EXISTDEL $EXISTBASE #print the deleted file(s) with Base attributes

		  for DEL in `cat $LIST_EXISTDEL`
		  do
			  grep "${DEL}$" $EXISTBASE
		  done
#          cat $LIST_EXISTDEL
	  	  echo ---------------------------------------
      else
          echo 無檔案刪除
		  #echo No files been deleted!
          echo ---------------------------------------
      fi

      if [ ! -s $TMP_EXISTCHANGE ] && [ ! -s $LIST_EXISTADD ] && [ ! -s $LIST_EXISTDEL ] ; then #if file not empty
		  echo "EXISTCHANGE OK" >> $RESULT_EXIST
# 		  echo Congratulations!!
#		  echo Auditing check status SUCCESS, no files been touched.
      fi

else
   echo Basefile not exist, please execute the script '"genbas_file_attr.sh"' to create !
fi
tlog "Running check_exist end"
}
#}}}

#{{{check_modified
#----------------------------------
# Check files had been MODIFIED
# 檢查檔案時間屬性
#----------------------------------
check_modified(){
#set -x 

tlog "Running check_modified start"
if [ -f $BASEFILE ]; then #if BASEFILE exist
echo 
echo 
echo "#============================================================#"
echo "# The SITE:$SITE"
echo "# The Hostname:$hostname"
#echo "# File or Directory attribute check"
echo "# 檢查檔案及目錄(含時間屬性)"
#echo "# Total `awk 'END {print NR}' $BASEFILE` files in the checking list"
echo "# 共檢查 `awk 'END {print NR}' $BASEFILE` 檔案"
echo "# Date: `date +%Y/%m/%d\ %H:%M`"
echo "#============================================================#"
   cat /dev/null > $CURRENT #flush the file to make sure it's fresh
   cat /dev/null > $CURRENT_MODI #flush the file to make sure it's fresh
   cat /dev/null > $RESULT #flush the check_status_file
   for DIRNAME in $DIR #import all dir_list from commandline prompt
   do
	   find $DIRNAME -exec ls -cdils {} \; 2>/dev/null >> $CURRENT 2>/dev/null
#	   find $DIRNAME -mtime -14 -ls 2> /dev/null | eval $ALLEXCLUDE >> $CURRENT_MODI
#	   find $DIRNAME -ls 2> /dev/null | eval $ALLEXCLUDE | sort -k2  >> $CURRENT
#	   find $DIRNAME -mtime -14 -ls 2> /dev/null | eval $ALLEXCLUDE | sort -k2  >> $CURRENT_MODI
#	   ${SHDIR}/sefind $DIRNAME -ls 2> /dev/null | eval $ALLEXCLUDE | sort -k2  >> $CURRENT
#	   ${SHDIR}/sefind $DIRNAME -mtime -14 -ls 2> /dev/null | eval $ALLEXCLUDE | sort -k2  >> $CURRENT_MODI
   done
   cat $CURRENT | eval $ALLEXCLUDE > ${CURRENT}.tmp #generate CURRENT status to compare with BASEFILE
   mv ${CURRENT}.tmp $CURRENT
   sort -k 11 $CURRENT -o $CURRENT
   awk '{if ($11~/\/dev\// || $12~/\/dev\//) if ($3~/c/ || $3~/b/) {print $12} else {print $11} else {print $11}}' $CURRENT > $TMP_CUR
   awk '{if ($11~/\/dev\// || $12~/\/dev\//) if ($3~/c/ || $3~/b/) {print $12} else {print $11} else {print $11}}' $BASEFILE > $TMP_BASE
#   awk '{if ($11~/\/dev\// || $12~/\/dev\//) if ($3~/c/ || $3~/b/) {print $12} else {print $11} else {print $11}}' $CURRENT_MODI > $TMP_CUR_MODI
	##diff $CURRENT $BASEFILE  > $TMP_CHANGE   #creat origin difference file
	#awk '$4 !~ /^l/' $TMP_CHANGE > $TMP_CHANGETWO #if the file is link file, then it take off.
	diff $CURRENT $BASEFILE | sed -e "/ \/etc$/d" > $TMP_CHANGE   #creat origin difference file
	
 	#如無diff無異動時，直接離開該function
	#diff  $CURRENT $BASEFILE > /dev/null	#creat origin difference file
#sort $CURRENT -o $CURRENT
#   sort $BASEFILE -o $BASEFILE
#   diff  $CURRENT $BASEFILE > /dev/null	#creat origin difference file
#   rc=$?
#   if [[ $rc = "0" ]];then
#	   echo 無異動檔案
#	   echo ---------------------------------------
#	   echo 無新增檔案
#	   echo ---------------------------------------
#	   echo 無檔案刪除
#	   echo ---------------------------------------
#	   return 0
#   fi

#   cat $TMP_CUR_MODI | sed -e "/\/etc$/d" > $TMP_CHANGE   #creat origin difference file, /etc 不檢查其時間異動
#   touch $TMP_CHANGETRE
#   for FILE_LST in `cat $TMP_CHANGE`
#   do
#	   FILE_A=`grep " ${FILE_LST}$" $BASEFILE`
#	   FILE_B=`grep " ${FILE_LST}$" $CURRENT`
#
#	   if [[ -z $FILE_A ]];then
#			continue
#	   fi
#
#	   if [[ $FILE_A != $FILE_B ]];then
#			echo "$FILE_LST" >> $TMP_CHANGETRE
#	   fi
#   done
#   mv $TMP_CHANGETRE $TMP_CHANGETWO
#   mv $TMP_CHANGETWO $TMP_CHANGE

####################################################################################
# 檢查是否有檔案異動
####################################################################################
   if [ -s $TMP_CHANGE ]; then
#      echo "Something are different comparing with the basefile:"
       awk '{print $12}' $TMP_CHANGE | sort | uniq -d | grep -v '^$' > $LIST_CHANGE
#	   awk '{print $1}' $TMP_CHANGE  > $LIST_CHANGE
      if [ -s $LIST_CHANGE ]; then
	      echo "MODIFIED Failed" > $RESULT #write faild log to result
          cat $LIST_CHANGE > $FILECHG 
		  #echo "There are `awk 'END {print NR}' $LIST_CHANGE` files had been MODIFIED"
          echo "共有 `awk 'END {print NR}' $LIST_CHANGE` 檔案異動"

          for LINE in `cat $LIST_CHANGE`
          do
			#set -A LINE1 `grep " ${LINE}$" $BASEFILE`
			 grep -q " ${LINE}$" $BASEFILE 
             execStatus1=$?
             if [ $execStatus1 -eq 0 ]; then
			 	set -A LINE1 `grep " ${LINE}$" $BASEFILE | awk '$3 !~ /^l/'`
                echo "Base   :" ${LINE1[@]}
		  	 else
				 continue
             fi
			#set -A LINE2 `grep " ${LINE}$" $CURRENT`
			 grep -q " ${LINE}$" $CURRENT_MODI
             execStatus2=$?
             if [ $execStatus2 -eq 0 ]; then
			 set -A LINE2 `grep " ${LINE}$" $CURRENT | awk '$3 !~ /^l/'`
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
				 echo ""
             fi
          done
          echo ---------------------------------------
      else
		  #echo No files been modified!
          echo 無異動檔案
          echo ---------------------------------------
      fi
  else	
      echo 無異動檔案
	  echo ---------------------------------------
  fi
####################################################################################
# 檢查是否有新增檔案
####################################################################################
      sort $TMP_CUR -o $TMP_CUR
      sort $TMP_BASE -o $TMP_BASE
#      echo "comm -23 $TMP_CUR $TMP_BASE |grep -v '^$' > $LIST_ADD" #compare current and base, delete the empty line then output the added file
      comm -23 $TMP_CUR $TMP_BASE |grep -v '^$' > $LIST_ADD #compare current and base, delete the empty line then output the added file
      if [ -s $LIST_ADD ]; then #if file not empty
          echo "MODIFIED ADD Failed" >> $RESULT 
#echo "There are `awk 'END {print NR}' $LIST_ADD` files had been ADDED"
          echo "共有 `awk 'END {print NR}' $LIST_ADD` 檔案新增"
          echo ---------------------------------------
#          awk 'NR==FNR{arr[$1];next}$10 in arr' $LIST_ADD $CURRENT #print the added file(s) with Current attributes
		  for ADD in `cat $LIST_ADD`
		  do
			  grep "${ADD}$" $CURRENT
		  done
#              cat $LIST_ADD 
		  echo ---------------------------------------
      else
		  #echo No files been added!
          echo 無新增檔案
          echo ---------------------------------------
      fi

####################################################################################
# 檢查是否有被檔案刪除
####################################################################################
      comm -13 $TMP_CUR $TMP_BASE |grep -v '^$' > $LIST_DEL #compare current and base, delete the empty line then output the deleted file
      if [ -s $LIST_DEL ]; then #if file not empty
          echo "MODIFIED DEL Failed" >> $RESULT 
#echo "There are `awk 'END {print NR}' $LIST_DEL` files had been DELETED"
          echo "共有 `awk 'END {print NR}' $LIST_DEL` 檔案刪除"
          echo ---------------------------------------
#awk 'NR==FNR{arr[$1];next}$10 in arr' $LIST_DEL $BASEFILE #print the deleted file(s) with Base attributes

		  for DEL in `cat $LIST_DEL`
		  do
			  grep "${DEL}$" $BASEFILE
		  done
#          cat $LIST_DEL
	  echo ---------------------------------------
      else
		  #echo No files been deleted!
          echo 無檔案刪除
          echo ---------------------------------------
      fi

      if [ ! -s $TMP_CHANGE ] && [ ! -s $LIST_ADD ] && [ ! -s $LIST_DEL ] ; then #if file not empty
		  echo "MODIFIED OK" >> $RESULT #return the final result to file
#		  echo Congratulations!!
#		  echo Auditing check status SUCCESS, no files been touched.
	  fi
else
   echo Basefile not exist, please execute the script '"genbas_file_attr.sh"' to create !
   exit 1
fi
tlog "Running check_modified end"
}
#}}}

check_base_file
check_exist
check_modified
daily_check_status
clear_tmp
