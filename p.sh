#!/bin/ksh
Logfile=/home/se/safechk/safelog/menu.log
USER=$(whoami)
hostname=`hostname`


main () {
clear
echo "             << FIX/FAST ��T�ǿ�t�ΨϥΪ̧@�~ (ALL AIX LPAR)>> "
echo ""
echo "           1. �P�B�ק�K�X "
echo ""
echo "           2. �@�Τu�@�Ϥ��ɮפW�ǦܦULPAR(MDS/DAP/DAR/LOG) "
echo ""
echo "           3. ��@�Τu�@�ϰ�����O�P�B��ULPAR(MDS/DAP/DAR/LOG) "
echo ""
echo "           4. �ULPAR(MDS/DAP/DAR/LOG)���ɮפU���ܦ@�Τu�@�� "
echo ""
echo "           5. �NLPAR(MDS/DAP/DAR/LOG)�ؿ��U�Ǧܦ@�Τu�@�� "
echo ""
echo "               (�H�ɥi�� q �H���} )"
echo ""
read Menu_No?"                �п�ܿﶵ (1-5) : "

case $Menu_No in
	1)
		STARTA
		;;
	2)
                STARTB
		;;
        3)
                STARTC
                ;;
        4)
                STARTD
                ;;
        5)
                STARTE
                ;;
	q|Q)
		exit
		;;
		
	*)
                echo ""
		echo "        [Error]  ��J���~, �п�J (1-5)���ﶵ"
                read ANSWR?"               ��Enter���~�� "
                main
		;;
        esac
}
###############################################################
STARTA () {
   clear
   echo ""
   echo "#============================================#"
   echo "#  ���\��|�P�B�ܧ�Ҧ�LPAR�D�����ϥΪ̱K�X  #"
   echo "#============================================#"
   echo ""
   echo "���ܧ� ${USER} ���K�X?"
   echo ""
   read ANSWER?"               �нT�{�n�ܧ�User �L�~(Y/N): "
   case $ANSWER in
   n|N)
        main
        ;;
   y|Y)
        /home/se/safechk/safesh/pwchg_all.sh
        read ANSWR?"               ��Enter���~�� "
        main
        ;;
   *)
        echo ""
        echo "[Error]  ��J���~, �п�J(Y/N)"
        read ANSWR?"               ��Enter���~�� "
        main
        ;;
    esac
}

###############################################################
STARTB () {
   clear
   echo ""
   DIRPATH=""
   HOSTN=""
   HOSTLIST=""
   MUSER=$(whoami)
   HOMEDIR=`lsuser $MUSER | awk '{print $5}' | cut -c6-`
   CHKFLG=0
   if [ "$HOSTN" == "" ]; then
       echo ""
       echo "                  (�H�ɥi�� q �H���} ) "
       echo "#==========================================================#"
       echo "# ��J�榡(�C�x�D���H�Ů氵�����j): DAP1-1 DAR1-1 LOG1 MDS1#"
       echo "#                                                          #"
       echo "# �s�տ�J�榡: DAP (�@���@�Ӹs��)                         #"
       echo "#                                                          #"
       echo "# �����D���п�J: ALL                                      #"
       echo "#==========================================================#"
       read HOSTN?"��J���ǰe���D���W�� : "
       if [ "$HOSTN" == "q" ] || [ "$HOSTN" == "Q" ]; then
           main
       fi

       case $HOSTN in
           DAP)
               HOSTLIST=`cat /home/se/safechk/cfg/host.lst | grep -i ^DAP`
               ;;
           DAR)
               HOSTLIST=`cat /home/se/safechk/cfg/host.lst | grep -i ^DAR`
               ;;
           MDS)
               HOSTLIST=`cat /home/se/safechk/cfg/host.lst | grep -i ^MDS`
               ;;
           LOG)
               HOSTLIST=`cat /home/se/safechk/cfg/host.lst | grep -i ^LOG`
               ;;
           ALL)
               HOSTLIST=`cat /home/se/safechk/cfg/host.lst | grep -i -v $hostname`
               ;;
           *)
               HOSTLIST=$HOSTN
               ;;
       esac

       if [ -z "$HOSTLIST" ]; then
          echo ""
          echo "               [Error]  ��J���ŭ� "
          echo ""
          read ANSWR?"               ��Enter���~�� "
          main
       fi

       read DIRPATH?"��J�ɮשҦb���ؿ����|��m(������|) : "
       if [ "$DIRPATH" == "q" ] || [ "$DIRPATH" == "Q" ]; then
           main
       fi

       if [ ! -d $DIRPATH ]; then
           echo ""
           echo "               [Error]  ��J���ؿ����s�b "
           CHKFLG=1
       fi
       if [ -z "$DIRPATH" ]; then
           echo ""
           echo "               [Error]  ��J���ŭ� "
           CHKFLG=1
       fi

       if [ "$CHKFLG" != "0" ]; then
           echo ""
           read ANSWR?"               ��Enter���~�� "
           main
       else
           echo "Directory PATH: $DIRPATH"
           echo ""
           ls -ltr $DIRPATH
           read FILENAME?"             �п�J�ݭn�P�B���L�xLPAR�ɮצW��: "
           if [ -d $DIRPATH/$FILENAME ]; then
              echo ""
              echo "               [Error]  ��J���ɦW���ؿ� "
              read ANSWR?"               ��Enter���~�� "
              main
           fi
           if [ ! -f $DIRPATH/$FILENAME ]; then
              echo ""
              echo "               [Error]  ��J���ɦW���s�b "
              read ANSWR?"               ��Enter���~�� "
              main
           fi

           echo ""
           echo "#===�D���C��===#"
           echo "$HOSTLIST"
           echo "#==============#"
           echo "�P�B�ɮ�: $DIRPATH/$FILENAME"
           echo ""
           read ANSWER?"             �нT�{�W�z��T�O�_���T(Y/N): "
           case $ANSWER in
           n|N)
                main
                ;;
           y|Y)
                read RDIRPATH?"             �п�J�ɮ׭n�ǰe�컷�ݥD�����ؿ�(������|): "
                for HOST in $HOSTLIST ; do
                   echo "$HOST �ɮ׶ǰe��..."
                   scp -P 2222 $DIRPATH/$FILENAME $HOST:$RDIRPATH/
                done

                ## for check ##
                #/home/se/safechk/safesh/scpfile_ssh.sh $DIRPATH $FILENAME $RDIRPATH
                exec 4>&1
                for HOST in $HOSTLIST ; do
                   ssh -p 2222 -t -t $HOST >&4 2>/dev/null |&
                   print -p "test -e $RDIRPATH/$FILENAME && touch scpdatafile.${HOST}"
                   print -p exit
                   wait
                done

                ## Retrieve check files ##
                for HOST in $HOSTLIST ; do
                   echo "$HOST ���G�ˬd��..."
                   scp -P 2222 ${MUSER}@${HOST}:$HOMEDIR/scpdatafile.${HOST} /tmp/
                   ssh -p 2222 ${MUSER}@${HOST} "rm -f $HOMEDIR/scpdatafile.${HOST}"
                done

                errors=0
                echo
                echo "#==========================#"
                echo "#  �P�B�ɮץD�����G�M��:   #"
                echo "#==========================#"
                for HOST in $HOSTLIST ; do
                   if [[ -f /tmp/scpdatafile.${HOST} ]] ; then
                      rm /tmp/scpdatafile.${HOST}
                      echo $HOST OK!
                   else
                      echo $HOST has a problem!
                      ((errors=errors+1))
                   fi
                done
                ((errors)) && exit 1

                read ANSWR?"               ��Enter���~�� "
                main
                ;;
           *)
                echo "[Error]  ��J���~, �п�J(Y/N)"
                read ANSWR?"               ��Enter���~�� "
                STARTB
                ;;
           esac
       fi
   fi
}

###############################################################
STARTC () {
   clear
   echo ""
   HOSTN=""
   HOSTLIST=""
   timestamp=`date +"%Y%m%d%H%M%S"`
   CHKFLG=0
   if [ "$HOSTN" == "" ]; then
       echo ""
       echo "                  (�H�ɥi�� q �H���} ) "
       echo "#==========================================================#"
       echo "# ��J�榡(�C�x�D���H�Ů氵�����j): DAP1-1 DAR1-1 LOG1 MDS1#"
       echo "#                                                          #"
       echo "# �s�տ�J�榡: DAP (�@���@�Ӹs��)                         #"
       echo "#                                                          #"
       echo "# �����D���п�J: ALL                                      #"
       echo "#==========================================================#"
       read HOSTN?"��J��������O���D���W�� : "
       if [ "$HOSTN" == "q" ] || [ "$HOSTN" == "Q" ]; then
           main
       fi

       case $HOSTN in
           DAP)
               HOSTLIST=`cat /home/se/safechk/cfg/host.lst | grep -i ^DAP`
               ;;
           DAR)
               HOSTLIST=`cat /home/se/safechk/cfg/host.lst | grep -i ^DAR`
               ;;
           MDS)
               HOSTLIST=`cat /home/se/safechk/cfg/host.lst | grep -i ^MDS`
               ;;
           LOG)
               HOSTLIST=`cat /home/se/safechk/cfg/host.lst | grep -i ^LOG`
               ;;
           ALL)
               HOSTLIST=`cat /home/se/safechk/cfg/host.lst`
               ;;
           *)
               HOSTLIST=$HOSTN
               ;;
       esac

       if [ -z "$HOSTLIST" ]; then
           echo ""
           echo "               [Error]  ��J���ŭ� "
           echo ""
           read ANSWR?"               ��Enter���~�� "
           main
       fi

       echo ""
       read COMMAND?"               �п�J�n���檺���O: "
       if [ "$COMMAND" == "q" ] || [ "$COMMAND" == "Q" ]; then
           main
       fi
       if [ -z "$COMMAND" ]; then
           echo ""
           echo "               [Error]  ���O��J���ŭ� "
           CHKFLG=1
       fi

       if [ "$CHKFLG" != "0" ]; then
           echo ""
           read ANSWR?"               ��Enter���~�� "
           main
       else
           echo ""
           echo "#===�D���C��===#"
           echo "$HOSTLIST"
           echo "#==============#"
           echo "������O: $COMMAND"
           echo ""
           read ANSWER?"             �нT�{�W�z��T�O�_���T(Y/N): "
           case $ANSWER in
           n|N)
                main
                ;;
           y|Y)
                for HOST in $HOSTLIST ; do
                   echo "$HOST ���椤..."
                   ssh -p 2222 $HOST "$COMMAND"
                   execStatus=$?
                   if [ $execStatus -eq 0 ]; then
                      echo "$HOST OK!" >> /tmp/$USER.$timestamp
                   else
                      echo "$HOST Fail!" >> /tmp/$USER.$timestamp
                   fi
                done
                echo ""
                echo "#==========================#"
                echo "#  ������O�D�����G�M��:   #"
                echo "#==========================#"
                cat /tmp/$USER.$timestamp
                rm /tmp/$USER.$timestamp
                read ANSWR?"               ��Enter���~�� "
                main
                ;;
           *)
                echo "[Error]  ��J���~, �п�J(Y/N)"
                read ANSWR?"               ��Enter���~�� "
                STARTC
                ;;
           esac
       fi
   fi
}
###############################################################
STARTD () {
   clear
   echo ""
   HOSTN=""
   HOSTLIST=""
   timestamp=`date +"%Y%m%d%H%M%S"`
   BACKUPDIR="/home/download/file"
   CHKFLG=0
   if [ "$HOSTN" == "" ]; then
       echo ""
       echo "                  (�H�ɥi�� q �H���} ) "
       echo "#==========================================================#"
       echo "# ��J�榡(�C�x�D���H�Ů氵�����j): DAP1-1 DAR1-1 LOG1 MDS1#"
       echo "#                                                          #"
       echo "# �s�տ�J�榡: DAP (�@���@�Ӹs��)                         #"
       echo "#                                                          #"
       echo "# �����D���п�J: ALL                                      #"
       echo "#==========================================================#"
       read HOSTN?"��J�����ɮת����ݥD���W�� : "
       if [ "$HOSTN" == "q" ] || [ "$HOSTN" == "Q" ]; then
           main
       fi

       case $HOSTN in
           DAP)
               HOSTLIST=`cat /home/se/safechk/cfg/host.lst | grep -i ^DAP`
               ;;
           DAR)
               HOSTLIST=`cat /home/se/safechk/cfg/host.lst | grep -i ^DAR`
               ;;
           MDS)
               HOSTLIST=`cat /home/se/safechk/cfg/host.lst | grep -i ^MDS`
               ;;
           LOG)
               HOSTLIST=`cat /home/se/safechk/cfg/host.lst | grep -i ^LOG`
               ;;
           ALL)
               HOSTLIST=`cat /home/se/safechk/cfg/host.lst | grep -i -v $hostname`
               ;;
           *)
               HOSTLIST=$HOSTN
               ;;
       esac

       if [ -z "$HOSTLIST" ]; then
           echo ""
           echo "               [Error]  ��J���ŭ� "
           echo ""
           read ANSWR?"               ��Enter���~�� "
           main
       fi

       echo ""
       read DIRPATH?"��J�ɮשҦb���ؿ������|��m(������|) : "
       if [ "$DIRPATH" == "q" ] || [ "$DIRPATH" == "Q" ]; then
           main
       fi


       echo ""
       read FILENAME?"�п�J�n�ƥ��U�Ǫ��ɮ�(�ɦW): "
       if [ "$FILENAME" == "q" ] || [ "$FILENAME" == "Q" ]; then
           main
       fi

       echo ""
       echo "                    [Warning]�Y����LPAR�ۦP�ɦW�U���ܥ��a�|�л\ "
       echo "                    �� Y �Y�ɦW�ۦP�|�\�� "
       echo "                    �� N �|���ɦW��[�W�D���P�Ǹ��קK�\�� "
       read ANSWER?"                    �нT�{�O�_�л\(Y/N): "
       case $ANSWER in
       n|N)
            CHECK=2
            ;;
       y|Y)
            CHECK=1
            ;;
       *)
            echo "[Error]  ��J���~, �п�J(Y/N)"
            read ANSWR?"               ��Enter���~�� "
            STARTD
            ;;
       esac

       if [ -z "$DIRPATH" ]; then
           echo ""
           echo "               [Error] �ؿ���J���ŭ� "
           CHKFLG=1
       fi

       if [ -z "$FILENAME" ]; then
           echo ""
           echo "               [Error]  �ɦW��J���ŭ� "
           CHKFLG=1
       fi

       if [ "$CHKFLG" != "0" ]; then
           echo ""
           read ANSWR?"               ��Enter���~�� "
           main
       else
           echo ""
           echo "#===�D���C��===#"
           echo "$HOSTLIST"
           echo "#==============#"
           echo "�����ɮ�: $DIRPATH/$FILENAME"
           echo ""
           read ANSWER?"             �нT�{�W�z��T�O�_���T(Y/N): "
           case $ANSWER in
           n|N)
                main
                ;;
           y|Y)
                for HOST in $HOSTLIST ; do
                   echo "$HOST ���椤..."
                   # overwrite
                   if [ "$CHECK" == "1" ]; then
                     scp -P 2222 $HOST:$DIRPATH/$FILENAME $BACKUPDIR/
                     execStatus=$?
                     if [ $execStatus -eq 0 ]; then
                        echo "$HOST OK!" >> /tmp/$USER.$FILENAME.$timestamp
                     else
                        echo "$HOST Fail!" >> /tmp/$USER.$FILENAME.$timestamp
                     fi
                   fi

                   # not overwrite
                   if [ "$CHECK" == "2" ]; then
                     scp -P 2222 $HOST:$DIRPATH/$FILENAME $BACKUPDIR/$FILENAME.$HOST.$timestamp
                     execStatus=$?
                     if [ $execStatus -eq 0 ]; then
                        echo "$HOST OK!" >> /tmp/$USER.$FILENAME.$timestamp
                     else
                        echo "$HOST Fail!" >> /tmp/$USER.$FILENAME.$timestamp
                     fi
                   fi
                done
                echo ""
                echo "#=======================================#"
                echo "#  ���o�ɮץD�����G�M��:                #"
                echo "#  �ɮצs���m /home/download/file:    #"
                echo "#=======================================#"
                cat /tmp/$USER.$FILENAME.$timestamp
                rm /tmp/$USER.$FILENAME.$timestamp
                read ANSWR?"               ��Enter���~�� "
                main
                ;;
           *)
                echo "[Error]  ��J���~, �п�J(Y/N)"
                read ANSWR?"               ��Enter���~�� "
                STARTD
                ;;
           esac
       fi
   fi
}
###############################################################
STARTE () {
   clear
   echo ""
   HOSTN=""
   HOSTLIST=""
   timestamp=`date +"%Y%m%d%H%M%S"`
   BACKUPDIR="/home/download/dir"
   CHKFLG=0
   if [ "$HOSTN" == "" ]; then
       echo ""
       echo "                  (�H�ɥi�� q �H���} ) "
       echo "#==========================================================#"
       echo "# ��J�榡(�C�x�D���H�Ů氵�����j): DAP1-1 DAR1-1 LOG1 MDS1#"
       echo "#                                                          #"
       echo "# �s�տ�J�榡: DAP (�@���@�Ӹs��)                         #"
       echo "#                                                          #"
       echo "# �����D���п�J: ALL                                      #"
       echo "#==========================================================#"
       read HOSTN?"��J�����ؿ������ݥD���W�� : "
       if [ "$HOSTN" == "q" ] || [ "$HOSTN" == "Q" ]; then
           main
       fi

       case $HOSTN in
           DAP)
               HOSTLIST=`cat /home/se/safechk/cfg/host.lst | grep -i ^DAP`
               ;;
           DAR)
               HOSTLIST=`cat /home/se/safechk/cfg/host.lst | grep -i ^DAR`
               ;;
           MDS)
               HOSTLIST=`cat /home/se/safechk/cfg/host.lst | grep -i ^MDS`
               ;;
           LOG)
               HOSTLIST=`cat /home/se/safechk/cfg/host.lst | grep -i ^LOG`
               ;;
           ALL)
               HOSTLIST=`cat /home/se/safechk/cfg/host.lst | grep -i -v $hostname`
               ;;
           *)
               HOSTLIST=$HOSTN
               ;;
       esac

       if [ -z "$HOSTLIST" ]; then
           echo ""
           echo "               [Error]  ��J���ŭ� "
           echo ""
           read ANSWR?"               ��Enter���~�� "
           main
       fi

       echo ""
       read DIRPATH?"��J�ؿ������|��m(������|) : "
       if [ "$DIRPATH" == "q" ] || [ "$DIRPATH" == "Q" ]; then
           main
       fi

       echo ""
       read FILENAME?"�п�J���a�s�ɦW��(�ɦW): "
       if [ "$FILENAME" == "q" ] || [ "$FILENAME" == "Q" ]; then
           main
       fi

       if [ -z "$DIRPATH" ]; then
           echo ""
           echo "               [Error] �ؿ���J���ŭ� "
           CHKFLG=1
       fi

       if [ -z "$FILENAME" ]; then
           echo ""
           echo "               [Error]  �ɦW��J���ŭ� "
           CHKFLG=1
       fi

       if [ "$CHKFLG" != "0" ]; then
           echo ""
           read ANSWR?"               ��Enter���~�� "
           main
       else
           echo ""
           echo "#===�D���C��===#"
           echo "$HOSTLIST"
           echo "#==============#"
           echo "���ݥؿ�: $DIRPATH"
           echo ""
           read ANSWER?"             �нT�{�W�z��T�O�_���T(Y/N): "
           case $ANSWER in
           n|N)
                main
                ;;
           y|Y)
                for HOST in $HOSTLIST ; do
                   echo "$HOST ���]��..."
                   ssh -p 2222 $HOST "cd $DIRPATH; tar cf - ./* | gzip > /tmp/$FILENAME.$HOST.$timestamp.tar.gz"
                   execStatus1=$?
                   if [ $execStatus1 -eq 0 ]; then
                      echo "$HOST ���] OK!" >> /tmp/$USER.$FILENAME.$timestamp
                   else
                      echo "$HOST ���] Fail!" >> /tmp/$USER.$FILENAME.$timestamp
                   fi
                   echo "$HOST �U����..."
                   scp -P 2222 $HOST:/tmp/$FILENAME.$HOST.$timestamp.tar.gz $BACKUPDIR/
                   execStatus2=$?
                   if [ $execStatus2 -eq 0 ]; then
                      echo "$HOST �U�� OK!" >> /tmp/$USER.$FILENAME.$timestamp
                   else
                      echo "$HOST �U�� Fail!" >> /tmp/$USER.$FILENAME.$timestamp
                   fi
                   ssh -p 2222 $HOST "cd /tmp; rm -f $FILENAME.$HOST.$timestamp.tar.gz"
                done
                echo ""
                echo "#========================================#"
                echo "#  ���o�ؿ� �D�����G�M��:                #"
                echo "#  �ɮצs���m  /home/download/dir:     #"
                echo "#========================================#"
                cat /tmp/$USER.$FILENAME.$timestamp
                rm /tmp/$USER.$FILENAME.$timestamp
                read ANSWR?"               ��Enter���~�� "
                main
                ;;
           *)
                echo "[Error]  ��J���~, �п�J(Y/N)"
                read ANSWR?"               ��Enter���~�� "
                STARTE
                ;;
           esac
       fi
   fi
}
###############################################################

main
