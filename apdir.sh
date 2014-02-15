#!/bin/ksh
#
#----------------------------------
# Set variable
#----------------------------------
HOSTNAME=`hostname`
DATE=`date +%Y%m%d`
DATE2=`date +%Y%m`
RPATH="/TWSE"
HOST=`echo $HOSTNAME | cut -c1-3`


#----------------------------------
# Create TWSE Directory
#----------------------------------
TWSEDIR() {

   if [ -d $RPATH ]; then

      for dir_type1 in bin bkbin bkcfg bkshell cfg oldbin oldcfg oldshell shell
      do
         mkdir -p $RPATH/$dir_type1
         chown -R exadm:exc $RPATH/$dir_type1
         chmod -R 775 $RPATH/$dir_type1
      done

      for dir_type2 in bkfile file 
      do
         mkdir -p $RPATH/$dir_type2
         chown -R twse:tse $RPATH/$dir_type2
         chmod -R 774 $RPATH/$dir_type2
      done

      for dir_type3 in log bklog
      do
         mkdir -p $RPATH/$dir_type3
         chown -R twse:tse $RPATH/$dir_type3
         chmod -R 775 $RPATH/$dir_type3
      done

   else
      echo "$PATH not exist! Please check.."
      exit
   fi
}

TWSEDIR
