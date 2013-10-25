#!/bin/ksh
#
#----------------------------------
# Set variable
#----------------------------------
HOSTNAME=`hostname`
DATE=`date +%Y%m%d`
DATE2=`date +%Y%m`
RPATH="/home/se"
EPATH="/home/exc"
HPATH="/home"
HOST=`echo $HOSTNAME | cut -c1-3`


#----------------------------------
# Create Directory
#----------------------------------
#DIRPATH="/home/se/safechk"
#if [ -d $RPATH ]; then
#   mkdir -p $DIRPATH
#   chown useradm:security $DIRPATH
#   chmod 775 $DIRPATH
#
#   for dir_type1 in safesh safelog
#   do
#      mkdir -p $DIRPATH/$dir_type1
#      chown useradm:security $DIRPATH/$dir_type1
#      chmod 775 $DIRPATH/$dir_type1
#   done
#else
#   echo "$PATH not exist! Please check.."
#fi


#EXCPATH="/home/exc/excwk"
#if [ -d $EPATH ]; then
#   mkdir -p $EXCPATH
#   chown exadm:exc $EXCPATH
#   chmod 770 $EXCPATH
#else
#   echo "$PATH not exist! Please check.."
#fi

DOWNPATH="/home/download"
if [ -d $HPATH ]; then
   mkdir -p $DOWNPATH
   chown useradm:security $DOWNPATH
   chmod 777 $DOWNPATH

   for dir_type1 in file dir
   do
      mkdir -p $DOWNPATH/$dir_type1
      chown useradm:security $DOWNPATH/$dir_type1
      chmod 777 $DOWNPATH/$dir_type1
   done
else
   echo "$PATH not exist! Please check.."
fi

#----------------------------------
# Create syslog Directory and logfile
#----------------------------------
perl /home/se/safechk/safesh/syslog_need.pl

exit
