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

#main() {
#   case $HOST in
#        DAP)
#             DAP
#             ;;
#        DAR)
#             DAR
#             ;;
#        MDS)
#             MDS
#             ;;
#        LOG)
#             LOG
#             ;;
#        *)
#             echo ""
#             echo " [Error] $HOST 主機名稱不在定義之中,請確認 "
#             exit 1
#             ;;
#        esac
#}

#----------------------------------
# Create TWSE Directory
#----------------------------------
TWSEDIR() {

   if [ -d $RPATH ]; then

      for dir_type1 in bin bkbin bkcfg bkshell cfg oldbin oldcfg oldshell shell
      do
         mkdir -p $RPATH/$dir_type1
         chown exadm:exc $DIRPATH/$dir_type1
         chmod 775 $RPATH/$dir_type1
      done

      for dir_type2 in bkfile file 
      do
         mkdir -p $RPATH/$dir_type2
         chown twse:tse $DIRPATH/$dir_type2
         chmod 774 $RPATH/$dir_type2
      done

      for dir_type3 in log bklog
      do
         mkdir -p $RPATH/$dir_type2
         chown twse:tse $DIRPATH/$dir_type2
         chmod 775 $RPATH/$dir_type2
      done

   else
      echo "$PATH not exist! Please check.."
      exit
   fi
}

TWSEDIR

#----------------------------------
# Create DAR Directory
#----------------------------------
#DAR() {
#   DIRPATH="/TWSE/MIS/DAPRB"
#
#   if [ -d $RPATH ]; then
#      mkdir -p $DIRPATH
#      chown root:system $DIRPATH
#      chmod 755 $DIRPATH
#
#      mkdir -p /TWSE/MIS/SE/tcpdump
#      mkdir -p /TWSE/MIS/SE/lbmmon
#      chown seadm:se /TWSE/MIS/SE/tcpdump
#      chmod 770 /TWSE/MIS/SE/tcpdump
#      chown seadm:se /TWSE/MIS/SE/lbmmon
#      chmod 770 /TWSE/MIS/SE/lbmmon
#
#      for dir_type1 in sh cfg lib oldsh oldcfg oldlib
#      do
#         mkdir -p $DIRPATH/$dir_type1
#         chown exadm:exc $DIRPATH/$dir_type1
#         chmod 775 $DIRPATH/$dir_type1
#      done
#
#      for dir_type2 in file log bkfile bklog
#      do
#         mkdir -p $DIRPATH/$dir_type2
#         chown twse:tse $DIRPATH/$dir_type2
#         chmod 774 $DIRPATH/$dir_type2
#      done
#   else
#      echo "$PATH not exist! Please check.."
#      exit
#   fi
#}
#
##----------------------------------
## Create MDS Directory
##----------------------------------
#MDS() {
#   DIRPATH="/TWSE/MIS/MDS"
#
#   if [ -d $RPATH ]; then
#      mkdir -p $DIRPATH
#      chown root:system $DIRPATH
#      chmod 755 $DIRPATH
#
#      mkdir -p /TWSE/MIS/SE/tcpdump
#      mkdir -p /TWSE/MIS/SE/lbmmon
#      chown seadm:se /TWSE/MIS/SE/tcpdump
#      chmod 770 /TWSE/MIS/SE/tcpdump
#      chown seadm:se /TWSE/MIS/SE/lbmmon
#      chmod 770 /TWSE/MIS/SE/lbmmon
#
#      for dir_type1 in sh cfg lib oldsh oldcfg oldlib
#      do
#         mkdir -p $DIRPATH/$dir_type1
#         chown exadm:exc $DIRPATH/$dir_type1
#         chmod 775 $DIRPATH/$dir_type1
#      done
#
#      for dir_type2 in file log bkfile bklog
#      do
#         mkdir -p $DIRPATH/$dir_type2
#         chown twse:tse $DIRPATH/$dir_type2
#         chmod 774 $DIRPATH/$dir_type2
#      done
#   else
#      echo "$PATH not exist! Please check.."
#      exit
#   fi
#}
#
#
##----------------------------------
## Create LOG Directory
##----------------------------------
#LOG() {
#   DIRPATH="/TWSE/MIS/LOG"
#   DIRPATH1="/TWSE/MIS/LogAgent"
#
#   if [ -d $RPATH ]; then
#      mkdir -p $DIRPATH
#      chown root:system $DIRPATH
#      chmod 755 $DIRPATH
#      chown exadm:exc $DIRPATH1
#      chmod 755 $DIRPATH1
#
#      mkdir -p /TWSE/MIS/SE/tcpdump
#      mkdir -p /TWSE/MIS/SE/lbmmon
#      chown seadm:se /TWSE/MIS/SE/tcpdump
#      chmod 770 /TWSE/MIS/SE/tcpdump
#      chown seadm:se /TWSE/MIS/SE/lbmmon
#      chmod 770 /TWSE/MIS/SE/lbmmon
#
#      for dir_type1 in sh cfg lib oldsh oldcfg oldlib
#      do
#         mkdir -p $DIRPATH/$dir_type1
#         chown exadm:exc $DIRPATH/$dir_type1
#         chmod 775 $DIRPATH/$dir_type1
#      done
#
#      for dir_type2 in sh cfg lib oldsh oldcfg oldlib
#      do
#         mkdir -p $DIRPATH1/$dir_type2
#         chown exadm:exc $DIRPATH1/$dir_type2
#         chmod 775 $DIRPATH1/$dir_type2
#      done
#
#      for dir_type3 in file log bkfile bklog
#      do
#         mkdir -p $DIRPATH/$dir_type3
#         chown twse:tse $DIRPATH/$dir_type3
#         chmod 774 $DIRPATH/$dir_type3
#      done
#
#      for dir_type4 in file log bkfile bklog
#      do
#         mkdir -p $DIRPATH1/$dir_type4
#         chown twse:tse $DIRPATH1/$dir_type4
#         chmod 774 $DIRPATH1/$dir_type4
#      done
#   else
#      echo "$PATH not exist! Please check.."
#      exit
#   fi
#}

