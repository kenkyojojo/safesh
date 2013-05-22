#!/bin/ksh

SELOG=/home/se/safechk/selog
CHGDIR=$SELOG/chg
FILECHG=$CHGDIR/`date +%Y%m%d_file_attr.chga`
DATE=`date +%Y%m%d`
INDEXLOG=$CHGDIR/`date +%Y%m%d_fileattr.index`
HOSTLIST=`cat /home/se/safechk/cfg/host.lst`


seperater() {
let x=0
while((x<$1))
do
    print -n "$2"
    let x+=1
done
print -n " "
}

STEP1 () {
  cd $CHGDIR
  cat /dev/null > $FILECHG
  for HOST in $HOSTLIST ; do
     if [ -f $CHGDIR/${HOST}_`date +%Y%m%d_file_attr.chg` ]; then
        cat ${HOST}_`date +%Y%m%d_file_attr.chg` >> $FILECHG
     fi
  done
  sort -u $FILECHG -o $FILECHG
}

STEP2 () {
  cd $CHGDIR
  cat /dev/null > $INDEXLOG
  if [ -s $FILECHG ]; then
     echo "---------- 主機資料異動Summary ---------" >> $INDEXLOG
     echo "格式:" >> $INDEXLOG
     echo "異動資料名稱" >> $INDEXLOG
     echo "有被異動的主機名稱" >> $INDEXLOG
     echo "----------------------------------------" >> $INDEXLOG
     while read LINE
     do
        echo $LINE >> $INDEXLOG
        grep "^${LINE}$" *.chg | awk -F_ '{print $1}' >> $INDEXLOG
        echo "----------------------------------------" >> $INDEXLOG
     done < $FILECHG
  else
     echo "---------- 主機資料異動Summary ---------" >> $INDEXLOG
     echo "Congratulations!!" >> $INDEXLOG
     echo "No files been modified" >> $INDEXLOG
     echo "----------------------------------------" >> $INDEXLOG
  fi
}

STEP3 () {
  cd $CHGDIR
  echo "---------- 資料檔案異動細項 ---------"
  echo "-------------------------------------"
  if [ -s $FILECHG ]; then
     for LINE in `cat $FILECHG`
     do
        for HOST in $HOSTLIST ; do
        grep ${LINE}$ $CHGDIR/safelog.${HOST}.fileattr.${DATE} > /dev/null
        execStatus=$?
        if [ $execStatus -eq 0 ]; then
           set -A LINE1 `grep " ${LINE}$" ${HOST}_file_attr.bas`
           execStatus1=$?
           if [ $execStatus1 -eq 0 ]; then
              echo ${HOST}':'
              echo "Base   :" ${LINE1[@]}
           fi

           set -A LINE2 `grep " ${LINE}$" ${HOST}_${DATE}_file_attr.chk`
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
        fi
        done
     #echo ---------------------------------------
     echo
     done
  else
     echo "Congratulations!!"
     echo "No files been modified"
     echo "----------------------------------------"
  fi
}

clear_tmp(){  #clear temperary files
cd $CHGDIR
rm -f safelog.*.fileattr.*
rm -f *file_attr.chg
rm -f *file_attr.chk
rm -f *file_attr.bas

if [ -f $FILECHG ]; then
   rm -f $FILECHG
fi

find $CHGDIR/ -type f -mtime +14 -exec rm {} \;
find $SELOG/itm/ -type f -mtime +14 -exec rm {} \;
find $SELOG/log/ -type f -mtime +30 -exec rm {} \;
find $SELOG/csv/ -type f -mtime +30 -exec rm {} \;
}

STEP1
STEP2
STEP3
clear_tmp

exit
