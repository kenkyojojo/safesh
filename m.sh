#!/bin/ksh
LOG=/home/se/safechk/safelog/menu.log
SHDIR=/home/se/safechk/safesh
USER=$(whoami)
tlog=$SHDIR/tlog.sh
hostname=$(hostname)

###############################################################
#{{{create_log
create_log () {

	if [[ ! -f $LOG ]]; then 
		if [[ $USER = "root" ]];then
			touch $LOG
			chown useradm:security $LOG
			chmod 666 $LOG
		elif [[ $USER = "useradm" ]]; then
			touch $LOG
			chmod 666 $LOG
		else
			echo "create_log:Please use the useradm or root user to running the script first"
			exit 1
		fi
	fi
}
#}}}
###############################################################
#{{{main
main () {


clear
echo "          << FIX/FAST ��T�ǿ�t�Ψt�޻P�w���ާ@���� (ALL AIX LPAR)>> "
echo ""
echo "        1. �s�W�ϥΪ̱b��                        11. ����Telnet �A��"
echo ""
echo "        2. �R���ϥΪ̱b��                        12. �}��Telnet �A��"
echo ""
echo "        3. �P�B���K�X                          13. ���滷�ݫ��O"
echo ""
echo "        4. �Ѱ��b����w���A                      14. ���o�����ɮ�"
echo ""
echo "        5. �s�إؿ�                              15. ���o���ݥؿ�"
echo ""
echo "        6. �R���ؿ�                              16. Faillogin����reset"
echo ""
echo "        7. �s�W�s��                              17. ����SSH Key"
echo ""
echo "        8. �R���s��                              18. ���ͦw���ˮ�Base��"
echo ""
echo "        9. �P�B�ɮ�                              19. �P�B�ؿ�"
echo ""
echo "       10. �C��ȯZ�ˮֳ����ɮ׭���"
echo ""
echo "                                (�H�ɥi�� q �H���} )"
echo ""
read Menu_No?"                                 �п�ܿﶵ (1-19) : "

create_log

case $Menu_No in
	1)
                if [ "$USER" == "root" ] || [ "$USER" == "useradm" ]; then
                   STARTA
                else
                   echo ""
                   echo "      $USER �L�v���ϥΦ��\��, �Ь��t�κ޲z��"
                   read ANSWR?"                 ��Enter���~�� "
                   main
                fi
		;;
	2)
                if [ "$USER" == "root" ] || [ "$USER" == "useradm" ]; then
                   STARTB
                else
                   echo ""
                   echo "      $USER �L�v���ϥΦ��\��, �Ь��t�κ޲z��"
                   read ANSWR?"                 ��Enter���~�� "
                   main
                fi
		;;
	3)
		STARTC
		;;
	4)
                if [ "$USER" == "root" ] || [ "$USER" == "useradm" ]; then
                   STARTD
                else
                   echo ""
                   echo "      $USER �L�v���ϥΦ��\��, �Ь��t�κ޲z��"
                   read ANSWR?"                 ��Enter���~�� "
                   main
                fi
		;;
	5)
                if [ "$USER" == "root" ] || [ "$USER" == "useradm" ]; then
                   STARTE
                else
                   echo ""
                   echo "      $USER �L�v���ϥΦ��\��, �Ь��t�κ޲z��"
                   read ANSWR?"                 ��Enter���~�� "
                   main
                fi
		;;
	6)
                if [ "$USER" == "root" ] || [ "$USER" == "useradm" ]; then
                   STARTF
                else
                   echo ""
                   echo "      $USER �L�v���ϥΦ��\��, �Ь��t�κ޲z��"
                   read ANSWR?"                 ��Enter���~�� "
                   main
                fi
		;;
	7)
                if [ "$USER" == "root" ] || [ "$USER" == "useradm" ]; then
                   STARTG
                else
                   echo ""
                   echo "      $USER �L�v���ϥΦ��\��, �Ь��t�κ޲z��"
                   read ANSWR?"                 ��Enter���~�� "
                   main
                fi
		;;
	8)
                if [ "$USER" == "root" ] || [ "$USER" == "useradm" ]; then
                   STARTH
                else
                   echo ""
                   echo "      $USER �L�v���ϥΦ��\��, �Ь��t�κ޲z��"
                   read ANSWR?"                 ��Enter���~�� "
                   main
                fi
		;;
	9)
                if [ "$USER" == "root" ] || [ "$USER" == "useradm" ]; then
                   STARTI
                else
                   echo ""
                   echo "      $USER �L�v���ϥΦ��\��, �Ь��t�κ޲z��"
                   read ANSWR?"                 ��Enter���~�� "
                   main
                fi
		;;
	10)
                if [ "$USER" == "root" ] || [ "$USER" == "useradm" ]; then
                   STARTJ
                else
                   echo ""
                   echo "      $USER �L�v���ϥΦ��\��, �Ь��t�κ޲z��"
                   read ANSWR?"                 ��Enter���~�� "
                   main
                fi
		;;
	11)
                if [ "$USER" == "root" ] || [ "$USER" == "useradm" ]; then
                   STARTK
                else
                   echo ""
                   echo "      $USER �L�v���ϥΦ��\��, �Ь��t�κ޲z��"
                   read ANSWR?"                 ��Enter���~�� "
                   main
                fi
		;;
	12)
                if [ "$USER" == "root" ] || [ "$USER" == "useradm" ]; then
                   STARTL
                else
                   echo ""
                   echo "      $USER �L�v���ϥΦ��\��, �Ь��t�κ޲z��"
                   read ANSWR?"                 ��Enter���~�� "
                   main
                fi
		;;
	13)
                if [ "$USER" == "root" ] || [ "$USER" == "useradm" ]; then
                   STARTM
                else
                   echo ""
                   echo "      $USER �L�v���ϥΦ��\��, �Ь��t�κ޲z��"
                   read ANSWR?"                 ��Enter���~�� "
                   main
                fi
		;;
	14)
                if [ "$USER" == "root" ] || [ "$USER" == "useradm" ]; then
                   STARTN
                else
                   echo ""
                   echo "      $USER �L�v���ϥΦ��\��, �Ь��t�κ޲z��"
                   read ANSWR?"                 ��Enter���~�� "
                   main
                fi
		;;
	15)
                if [ "$USER" == "root" ] || [ "$USER" == "useradm" ]; then
                   STARTO
                else
                   echo ""
                   echo "      $USER �L�v���ϥΦ��\��, �Ь��t�κ޲z��"
                   read ANSWR?"                 ��Enter���~�� "
                   main
                fi
		;;
    16)
                if [ "$USER" == "root" ] || [ "$USER" == "useradm" ]; then
                   STARTP
                else
                   echo ""
                   echo "      $USER �L�v���ϥΦ��\��, �Ь��t�κ޲z��"
                   read ANSWR?"                 ��Enter���~�� "
                   main
                fi
                ;;
    17)
                if [ "$USER" == "root" ] || [ "$USER" == "useradm" ]; then
                   STARTQ
                else
                   echo ""
                   echo "      $USER �L�v���ϥΦ��\��, �Ь��t�κ޲z��"
                   read ANSWR?"                 ��Enter���~�� "
                   main
                fi
                ;;
    18)
                if [ "$USER" == "root" ] ; then
                   STARTR
                else
                   echo ""
                   echo "      $USER �L�v���ϥΦ��\��, �Ь��t�κ޲z��"
                   read ANSWR?"                 ��Enter���~�� "
                   main
                fi
                ;;
	19)
                if [ "$USER" == "root" ] || [ "$USER" == "useradm" ]; then
                   STARTS
                else
                   echo ""
                   echo "      $USER �L�v���ϥΦ��\��, �Ь��t�κ޲z��"
                   read ANSWR?"                 ��Enter���~�� "
                   main
                fi
		;;
	q|Q)
		exit
		;;
		
	*)
                echo ""
		echo "        [Error]  ��J���~, �п�J (1-19)���ﶵ"
                read ANSWR?"               ��Enter���~�� "
                main
		;;
        esac
}
#}}}
###############################################################
#{{{STARTA
STARTA() {
   clear
   echo ""
   GROUP=""
   UMASK=""
   UID=""
   USERNAME=""
   CHKFLG=0
   if [ "$GROUP" == "" ]; then
       echo ""
       echo "                  (�H�ɥi�� q �H���} ) "
       echo ""

       read GROUP?" ��J�s�զW��( ���� ) : "
       if [ "$GROUP" == "q" ] || [ "$GROUP" == "Q" ]; then
           main
       fi

       read UMASK?" ��Jumask( ���� ) : "
       if [ "$UMASK" == "q" ] || [ "$UMASK" == "Q" ]; then
           main
       fi

       read UID?" ��Juser id( ���� ) : "
       if [ "$UID" == "q" ] || [ "$UID" == "Q" ]; then
           main
       fi

       read USERNAME?" ��Juser name( ���� ) : "
       if [ "$USERNAME" == "q" ] || [ "$USERNAME" == "Q" ]; then
           main
       fi

       if [ -z "$GROUP" ]; then
           echo ""
           echo "               [Error]  ��J�s�զW�٬��ŭ� "
           CHKFLG=1
       fi
       GROUPCHK=`grep "^${GROUP}:" /etc/group | awk -F: '{print $1}'`
       if [ "$GROUPCHK" != "$GROUP" ]; then
           echo ""
           echo "               [Error]  ��J�s�դ��s�b "
           CHKFLG=1
       fi

       if [[ "$UMASK" != ?(+|-)+([0-7][0-7][0-7]) ]]; then
           echo ""
           echo "               [Error]  ��JUMASK�D�Ʀr�榡 "
           CHKFLG=1
       fi

       if [[ "$UID" != ?(+|-)+([0-7][0-7][0-7]) ]]; then
           echo "               [Error]  ��JUID�D�Ʀr�榡 "
           CHKFLG=1
       else
           UIDCHK=`cat /etc/passwd | awk -F: '{print $3}' | grep "${UID}"`
           if [ "$UIDCHK" == "$UID" ]; then
               echo ""
               echo "               [Error]  ��JUID�w�s�b "
               CHKFLG=1
           fi
       fi

       if [ -z "$USERNAME" ]; then
           echo ""
           echo "               [Error]  ��J�ϥΪ̦W�٬��ŭ� "
           CHKFLG=1
       fi
       USERNAMECHK=`grep "^${USERNAME}:" /etc/passwd | awk -F: '{print $1}'`
       if [ "$USERNAMECHK" == "$USERNAME" ]; then
           echo ""
           echo "               [Error]  ��Jusername�w�s�b "
           CHKFLG=1
       fi
       
       if [ "$CHKFLG" != "0" ]; then
           echo ""
           read ANSWR?"               ��Enter���~�� "
           main
       else
           echo ""
           echo "Group name:         $GROUP"
           echo "Umask:              $UMASK"
           echo "User ID:            $UID"
           echo "User Name:          $USERNAME"
           echo ""
           read ANSWER?"             �нT�{�W�z��T�L�~(Y/N): "
           case $ANSWER in
           n|N)
                main
                ;;
           y|Y)
                /home/se/safechk/safesh/adduser_ssh.sh $GROUP $GROUP $UMASK $UID $USERNAME
                read ANSWR?"               ��Enter���~�� "
                main
                ;;
           *)
                echo "[Error]  ��J���~, �п�J(Y/N)"
                read ANSWR?"               ��Enter���~�� "
                STARTA
                ;;
           esac
       fi
   fi
}
#}}}
###############################################################
#{{{STARTB
STARTB () {
   clear
   echo ""
   USERNAME=""
   CHKFLG=0
   if [ "$USERNAME" == "" ]; then
       echo ""
       echo "                  (�H�ɥi�� q �H���} ) "
       echo ""
       read USERNAME?" ��JUser name( ���� ) : "
       if [ "$USERNAME" == "q" ] || [ "$USERNAME" == "Q" ]; then
           main
       fi

       if [ -z "$USERNAME" ]; then
           echo ""
           echo "               [Error]  ��J���ŭ� "
           CHKFLG=1
       fi

       USERCHK=`grep "^${USERNAME}:" /etc/passwd | awk -F: '{print $1}'`
       if [ "$USERCHK" != "$USERNAME" ]; then
           echo ""
           echo "               [Error]  ��J�ϥΪ̦W�٤��s�b "
           CHKFLG=1
       fi

       if [ "$CHKFLG" != "0" ]; then
           echo ""
           read ANSWR?"               ��Enter���~�� "
           main
       else
           echo ""
           echo "���R����User: $USERNAME"
           read ANSWER?"             �нT�{�W�z��T�L�~(Y/N): "
           case $ANSWER in
           n|N)
                main
                ;;
           y|Y)
                /home/se/safechk/safesh/deluser_ssh.sh $USERNAME
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
#}}}
###############################################################
#{{{STARTC
STARTC () {
   clear
   echo ""
   echo "#============================================#"
   echo "#  ���\��|�P�B�ܧ�Ҧ�LPAR�D�����ϥΪ̱K�X  #"
   echo "#============================================#"
   echo ""
   echo "���ܧ� ${USER} ���K�X?"
   echo ""
   read ANSWER?"            �нT�{�n�ܧ�User �L�~(Y/N): "
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
#}}}
###############################################################
#{{{STARTD
STARTD () {
   clear
   echo ""
   USERNAME=""
   CHKFLG=0
   if [ "$USERNAME" == "" ]; then
       echo ""
       echo "                  (�H�ɥi�� q �H���} ) "
       echo ""
       read USERNAME?" ��J�ݸ��ꪺUser name( ���� ) : "
       if [ "$USERNAME" == "q" ] || [ "$USERNAME" == "Q" ]; then
           main
       fi

       read USERPASS?" ��J�ݸ��ꪺUser �w�]Password( ���� ) : "
       if [ "$USERPASS" == "q" ] || [ "$USERPASS" == "Q" ]; then
           main
       fi

       if [ -z "$USERNAME" ]; then
           echo ""
           echo "               [Error]  ��J���ŭ� "
           CHKFLG=1
       fi
       USERCHK=`grep "^${USERNAME}:" /etc/passwd | awk -F: '{print $1}'`
       if [ "$USERCHK" != "$USERNAME" ]; then
           echo ""
           echo "               [Error]  ��J�ϥΪ̦W�٤��s�b "
           CHKFLG=1
       fi

       if [ -z "$USERPASS" ]; then
           echo ""
           echo "               [Error]  �K�X��J���ŭ� "
           CHKFLG=1
       fi


       if [ "$CHKFLG" != "0" ]; then
           echo ""
           read ANSWR?"               ��Enter���~�� "
           main
       else
           echo ""
           echo "�����ꪺUser Name: $USERNAME"
           echo "�����ꪺUser Password: $USERPASS"
           read ANSWER?"             �нT�{�W�z��T�L�~(Y/N): "
           case $ANSWER in
           n|N)
                main
                ;;
           y|Y)
                /home/se/safechk/safesh/usrlock_ssh.sh $USERNAME $USERPASS
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
#}}}
###############################################################
#{{{STARTE
STARTE () {
   clear
   echo ""
   DIROWNER=""
   DIRGROUP=""
   DIRPATH=""
   DIRPERM=""
   CHKFLG=0
   if [ "$DIROWNER" == "" ]; then
       echo ""
       echo "                  (�H�ɥi�� q �H���} ) "
       echo ""
       read DIROWNER?" ��J�ؿ����֦��� : "
       if [ "$DIROWNER" == "q" ] || [ "$DIROWNER" == "Q" ]; then
           main
       fi

       read DIRGROUP?" ��J�ؿ����֦��s�� : "
       if [ "$DIRGROUP" == "q" ] || [ "$DIRGROUP" == "Q" ]; then
           main
       fi

       read DIRPATH?" ��J�ؿ������|��m(������|) : "
       if [ "$DIRPATH" == "q" ] || [ "$DIRPATH" == "Q" ]; then
           main
       fi

       read DIRPERM?" ��J�ؿ����v�� (�Ʀr) : "
       if [ "$DIRPERM" == "q" ] || [ "$DIRPERM" == "Q" ]; then
           main
       fi

       USERNAMECHK=`grep "^${DIROWNER}:" /etc/passwd | awk -F: '{print $1}'`
       if [ "$USERNAMECHK" != "$DIROWNER" ]; then
           echo ""
           echo "               [Error]  ��J�ϥΪ̦W�٤��s�b "
           CHKFLG=1
       fi
       if [ -z "$USERNAMECHK" ]; then
           echo ""
           echo "               [Error]  ��J�ϥΪ̦W�٬��ŭ� "
           CHKFLG=1
       fi

       GROUPCHK=`grep "^${DIRGROUP}:" /etc/group | awk -F: '{print $1}'`
       if [ "$GROUPCHK" != "$DIRGROUP" ]; then
           echo ""
           echo "               [Error]  ��J�s�դ��s�b "
           CHKFLG=1
       fi
       if [ -z "$GROUPCHK" ]; then
           echo ""
           echo "               [Error]  ��J�s�լ��ŭ� "
           CHKFLG=1
       fi

       if [ -z "$DIRPATH" ]; then
           echo ""
           echo "               [Error]  ��J�ؿ����ŭ� "
           CHKFLG=1
       fi

       if [[ "$DIRPERM" != ?(+|-)+([0-9]) ]]; then
           echo ""
           echo "               [Error]  ��JPermission�D�Ʀr�榡 "
           CHKFLG=1
       fi

       if [ "$CHKFLG" != "0" ]; then
           echo ""
           read ANSWR?"               ��Enter���~�� "
           main
       else
           echo ""
           echo "Directory OWNER:      $DIROWNER"
           echo "Directory GROUP:      $DIRGROUP"
           echo "Directory PATH:       $DIRPATH"
           echo "Directory Permission: $DIRPERM"
           echo ""
           read ANSWER?"             �нT�{�W�z��T�L�~(Y/N): "
           case $ANSWER in
           n|N)
                main
                ;;
           y|Y)
                /home/se/safechk/safesh/mkdir_ssh.sh $DIROWNER:$DIRGROUP $DIRPATH $DIRPERM
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
#}}}
###############################################################
#{{{STARTF
STARTF () {
   clear
   echo ""
   DIRPATH=""
   CHKFLG=0
   if [ "$DIRPATH" == "" ]; then
       echo ""
       echo "                  (�H�ɥi�� q �H���} ) "
       echo ""
       read DIRPATH?" ��J�ؿ������|��m(������|) : "
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
           echo ""
           echo "Directory PATH: $DIRPATH"
           echo ""
           echo "                       [Warning] ���ʧ@�L�k�_��, �Яd�N!!!"
           echo ""
           read ANSWER?"             �нT�{�W�z�ؿ��O�_�n�R��, �����ؿ��P�ɮ׬ҷ|�R��(Y/N): "
           case $ANSWER in
           n|N)
                main
                ;;
           y|Y)
                /home/se/safechk/safesh/rmdir_ssh.sh $DIRPATH
                read ANSWR?"               ��Enter���~�� "
                main
                ;;
           *)
                echo "[Error]  ��J���~, �п�J(Y/N)"
                read ANSWR?"               ��Enter���~�� "
                STARTF
                ;;
           esac
       fi
   fi
}
#}}}
###############################################################
#{{{STARTG
STARTG () {
   clear
   echo ""
   GROUP=""
   GID=""
   CHKFLG=0
   if [ "$GROUP" == "" ]; then
       echo ""
       echo "                  (�H�ɥi�� q �H���} ) "
       echo ""
       read GROUP?" ��J�n�s�W���s�զW��: "
       if [ "$GROUP" == "q" ] || [ "$GROUP" == "Q" ]; then
           main
       fi

       read GID?" ��J�n�s�W���s��GID: "
       if [ "$GID" == "q" ] || [ "$GID" == "Q" ]; then
           main
       fi

       if [ -z "$GROUP" ]; then
           echo ""
           echo "               [Error]  ��J�s�զW�٬��ŭ� "
           CHKFLG=1
       fi
       GROUPCHK=`grep "^${GROUP}:" /etc/group | awk -F: '{print $1}'`
       if [ "$GROUPCHK" == "$GROUP" ]; then
           echo ""
           echo "               [Error]  ��J�s�դw�s�b "
           CHKFLG=1
       fi

       if [[ "$GID" != ?(+|-)+([0-9]) ]]; then
           echo "               [Error]  ��JGID�D�Ʀr�榡 "
           CHKFLG=1
       else
           GIDCHK=`cut -f "3" -d : /etc/group | grep "^$GID"`
           if [ "$GIDCHK" == "$GID" ]; then
               echo ""
               echo "               [Error]  ��JGID�w�s�b "
               CHKFLG=1
           fi
       fi

       if [ "$CHKFLG" != "0" ]; then
           echo ""
           read ANSWR?"               ��Enter���~�� "
           main
       else
           echo ""
           echo "Group Name: $GROUP"
           echo "Group ID: $GID"
           echo ""
           read ANSWER?"             �нT�{�W�z��T�L�~(Y/N): "
           case $ANSWER in
           n|N)
                main
                ;;
           y|Y)
                /home/se/safechk/safesh/mkgroup_ssh.sh $GID $GROUP
                read ANSWR?"               ��Enter���~�� "
                main
                ;;
           *)
                echo "[Error]  ��J���~, �п�J(Y/N)"
                read ANSWR?"               ��Enter���~�� "
                STARTG
                ;;
           esac
       fi
   fi
}
#}}}
###############################################################
#{{{STARTH
STARTH () {
   clear
   echo ""
   GROUP=""
   CHKFLG=0
   if [ "$GROUP" == "" ]; then
       echo ""
       echo "                  (�H�ɥi�� q �H���} ) "
       echo ""
       read GROUP?" ��J�n�R�����s�զW��: "
       if [ "$GROUP" == "q" ] || [ "$GROUP" == "Q" ]; then
           main
       fi

       if [ -z "$GROUP" ]; then
           echo ""
           echo "               [Error]  ��J�s�զW�٬��ŭ� "
           CHKFLG=1
       fi
       GROUPCHK=`grep "^${GROUP}:" /etc/group | awk -F: '{print $1}'`
       if [ "$GROUPCHK" != "$GROUP" ]; then
           echo ""
           echo "               [Error]  ��J�s�դ��s�b "
           CHKFLG=1
       fi

       if [ "$CHKFLG" != "0" ]; then
           echo ""
           read ANSWR?"               ��Enter���~�� "
           main
       else
           echo ""
           echo "Group Name: $GROUP"
           echo ""
           read ANSWER?"             �нT�{�W�z�n�R�����s�զW�ٵL�~(Y/N): "
           case $ANSWER in
           n|N)
                main
                ;;
           y|Y)
                /home/se/safechk/safesh/rmgroup_ssh.sh $GROUP
                read ANSWR?"               ��Enter���~�� "
                main
                ;;
           *)
                echo "[Error]  ��J���~, �п�J(Y/N)"
                read ANSWR?"               ��Enter���~�� "
                STARTH
                ;;
           esac
       fi
   fi
}
#}}}
###############################################################
#{{{STARTI
STARTI () {
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
	   HOSTN=$(echo $HOSTN|tr '[a-z]' '[A-Z]')

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
           FIX)
               HOSTLIST=`cat /home/se/safechk/cfg/host.lst | grep -i ^FIX`
               ;;
           TS)
               HOSTLIST=`cat /home/se/safechk/cfg/host.lst | grep -i ^TS`
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
                STARTI
                ;;
           esac
       fi
   fi
}
#}}}
###############################################################
#{{{STARTJ 
STARTJ () {
   clear
   echo ""
   HOSTLIST=""
   DATE2=`date +%Y%m`
   USER=$(whoami)
   SEDIR=/home/se/safechk/safelog/
   CSVDIR=/home/se/safechk/selog/csv/
   LOGDIR=/home/se/safechk/selog/log/
   ITMDIR=/home/se/safechk/selog/itm/
   CHKFLG=0
   if [ "$HOSTLIST" == "" ]; then
       echo ""
       echo "                  (�H�ɥi�� q �H���} ) "
       echo ""
       echo "��J�榡(�C�x�D���H�Ů氵�����j): DAP1-1 DAR1-1 LOG1 MDS1"
       read HOSTLIST?" ��J�����Ǫ��D���W�� (����J�w�]������) : "
       if [ "$HOSTLIST" == "q" ] || [ "$HOSTLIST" == "Q" ]; then
           main
       fi

       if [ -z "$HOSTLIST" ]; then
           echo ""
           echo "               ��J���ŭ�, �w�]�|�N�J�������D��LPAR"
           echo ""
           read ANSWER?"               �нT�{�O�_�~��(Y/N): "
           case $ANSWER in
           n|N)
                main
                ;;
           y|Y)
                HOSTLIST=`cat /home/se/safechk/cfg/host.lst`
                ;;
           *)
                echo "[Error]  ��J���~, �п�J(Y/N)"
                read ANSWR?"               ��Enter���~�� "
                STARTJ
                ;;
           esac
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
           echo ""
           read ANSWER?"             �нT�{�W�z��T�O�_���T(Y/N): "
           case $ANSWER in
           n|N)
                main
                ;;
           y|Y)
                for HOST in $HOSTLIST ; do
                   echo "$HOST �ǿ餤..."
                   scp -P 2222 ${USER}@${HOST}:$SEDIR/$DATE2.$HOST.*.txt $CSVDIR
                   scp -P 2222 ${USER}@${HOST}:$SEDIR/$DATE2.$HOST.*.csv $LOGDIR
                   scp -P 2222 ${USER}@${HOST}:$SEDIR/dailycheck/account/result/${HOST}_`date +%Y%m%d_user_attr.rst` $ITMDIR
                   scp -P 2222 ${USER}@${HOST}:$SEDIR/dailycheck/file_audit/result/${HOST}_`date +%Y%m%d_file_attr.rst` $ITMDIR
                   echo "$HOST �ǿ鵲��..."
                   echo ""
                done
                read ANSWR?"               ��Enter���~�� "
                main
                ;;
           *)
                echo "[Error]  ��J���~, �п�J(Y/N)"
                read ANSWR?"               ��Enter���~�� "
                STARTJ
                ;;
           esac
       fi
   fi

}
#}}}
###############################################################
#{{{STARTK
STARTK () {
   clear
   echo ""
   read ANSWER?"             �нT�{�n�O�_�n����telnet Service(Y/N): "
   case $ANSWER in
   n|N)
        main
        ;;
   y|Y)
        /home/se/safechk/safesh/stoptelnet.sh
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
#}}}
###############################################################
#{{{STARTL
STARTL () {
   clear
   echo ""
   read ANSWER?"             �нT�{�n�O�_�n�}��telnet Service(Y/N): "
   case $ANSWER in
   n|N)
        main
        ;;
   y|Y)
        /home/se/safechk/safesh/starttelnet.sh
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
#}}}
###############################################################
#{{{STARTM
STARTM () {
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
	   HOSTN=$(echo $HOSTN|tr '[a-z]' '[A-Z]')

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
           FIX)
               HOSTLIST=`cat /home/se/safechk/cfg/host.lst | grep -i ^FIX`
               ;;
           TS)
               HOSTLIST=`cat /home/se/safechk/cfg/host.lst | grep -i ^TS`
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
			   $tlog "#============================================================= " $LOG
                for HOST in $HOSTLIST ; do
                   $tlog "${USER}@${HOST} ���椤..." $LOG
                   $tlog "ssh -p 2222 $HOST "$COMMAND" " $LOG
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
                STARTM
                ;;
           esac
       fi
   fi
}
#}}}
###############################################################
#{{{STARTN
STARTN () {
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
	   HOSTN=$(echo $HOSTN|tr '[a-z]' '[A-Z]')

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
           FIX)
               HOSTLIST=`cat /home/se/safechk/cfg/host.lst | grep -i ^FIX`
               ;;
           TS)
               HOSTLIST=`cat /home/se/safechk/cfg/host.lst | grep -i ^TS`
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
            STARTN
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
                STARTN
                ;;
           esac
       fi
   fi
}
#}}}
###############################################################
#{{{STARTO
STARTO () {
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
	   HOSTN=$(echo $HOSTN|tr '[a-z]' '[A-Z]')

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
           FIX)
               HOSTLIST=`cat /home/se/safechk/cfg/host.lst | grep -i ^FIX`
               ;;
           TS)
               HOSTLIST=`cat /home/se/safechk/cfg/host.lst | grep -i ^TS`
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
                STARTO
                ;;
           esac
       fi
   fi
}
#}}}
###############################################################
#{{{STARTP
STARTP () {
   clear
   echo ""
   USERLIST=""
   USERNAME=""
   CHKFLG=0
   if [ "$USERLIST" == "" ]; then
       echo ""
       echo "                  (�H�ɥi�� q �H���} ) "
       echo ""

       read USERLIST?" ��J�n���ꪺ�b���W��( ���� ) : "
       if [ "$USERLIST" == "q" ] || [ "$USERLIST" == "Q" ]; then
           main
       fi

       if [ -z "$USERLIST" ]; then
           echo ""
           echo "               [Error]  ��J�ϥΪ̦W�٬��ŭ� "
           CHKFLG=1
       fi

       if [ "$CHKFLG" != "0" ]; then
           echo ""
           read ANSWR?"               ��Enter���~�� "
           main
       else
           echo ""
           echo "�����ꪺUser Name: $USERLIST"
           read ANSWER?"             �нT�{�W�z��T�L�~(Y/N): "
           case $ANSWER in
           n|N)
               main
               ;;
           y|Y)
               for USERNAME in $USERLIST ; do
                  /home/se/safechk/safesh/usrlock_all.sh $USERNAME
               done
               read ANSWR?"               ��Enter���~�� "
               main
               ;;
           *)
               echo "[Error]  ��J���~, �п�J(Y/N)"
               read ANSWR?"               ��Enter���~�� "
               STARTP
               ;;
           esac
        fi
   fi
}
#}}}
###############################################################
#{{{STARTQ
STARTQ() {
   clear
   echo ""
   USERLIST=""
   USERNAME=""
   CHKFLG=0
   if [ "$USERLIST" == "" ]; then
       echo ""
       echo "                  (�H�ɥi�� q �H���} ) "
       echo ""

       read USERLIST?" ��J�ϥΪ̱b���W��( ���� ) : "
       if [ "$USERLIST" == "q" ] || [ "$USERLIST" == "Q" ]; then
           main
       fi

       if [ -z "$USERLIST" ]; then
           echo ""
           echo "               [Error]  ��J�ϥΪ̦W�٬��ŭ� "
           CHKFLG=1
       fi

       if [ "$CHKFLG" != "0" ]; then
           echo ""
           read ANSWR?"               ��Enter���~�� "
           main
       else
           echo ""
           echo "������SSH Key���ϥΪ̱b��: $USERLIST"
           read ANSWER?"             �нT�{�W�z��T�L�~(Y/N): "
           case $ANSWER in
           n|N)
               main
               ;;
           y|Y)
               for USERNAME in $USERLIST ; do
                  /home/se/safechk/safesh/sshkey_all.sh $USERNAME
               done
               read ANSWR?"               ��Enter���~�� "
               main
               ;;
           *)
               echo "[Error]  ��J���~, �п�J(Y/N)"
               read ANSWR?"               ��Enter���~�� "
               STARTQ
               ;;
           esac
        fi
   fi
}
#}}}
###############################################################
#{{{STARTK
STARTR () {
   clear
   echo ""
   HOSTLIST=""
   ACCOUNT="/home/se/safechk/safesh/dailycheck/account/genbas_account_attr.sh"
   SYSCHK="/home/se/safechk/safesh/syschk_base.sh"
   FILEAUDIT="/home/se/safechk/safesh/dailycheck/fileaudit/genbas_file_attr.sh"
   timestamp=`date +"%Y%m%d%H%M%S"`
   CHKFLG=0
   if [ "$HOSTLIST" == "" ]; then
       echo ""
       echo "                  (�H�ɥi�� q �H���} ) "
       echo ""
       echo "��J�榡(�C�x�D���H�Ů氵�����j): DAP1-1 DAR1-1 LOG1 MDS1"
       read HOSTLIST?"��J�����Ǫ��D���W�� (����J�w�]������) : "
       if [ "$HOSTLIST" == "q" ] || [ "$HOSTLIST" == "Q" ]; then
           main
       fi

       if [ -z "$HOSTLIST" ]; then
           echo ""
           echo "               ��J���ŭ�, �w�]�|�N�J�������D��LPAR"
           echo ""
           read ANSWER?"               �нT�{�O�_�~��(Y/N): "
           case $ANSWER in
           n|N)
                main
                ;;
           y|Y)
                HOSTLIST=`cat /home/se/safechk/cfg/host.lst`
                ;;
           *)
                echo "[Error]  ��J���~, �п�J(Y/N)"
                read ANSWR?"               ��Enter���~�� "
                STARTR
                ;;
           esac
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
           echo ""
           read ANSWER?"             �нT�{�W�z��T�O�_���T(Y/N): "
           case $ANSWER in
           n|N)
                main
                ;;
           y|Y)
			   $tlog "#============================================================= " $LOG
                for HOST in $HOSTLIST ; do
                   $tlog "${USER}@${HOST} ���椤..." $LOG
                   $tlog "ssh -p 2222 -f $HOST "$ACCOUNT" " $LOG
                   ssh -p 2222 -f $HOST "$ACCOUNT"
                   execStatus1=$?
                   if [ $execStatus1 -eq 0 ]; then
                      echo "$HOST OK!" >> /tmp/$USER.account.$timestamp
                   else
                      echo "$HOST Fail!" >> /tmp/$USER.account.$timestamp
                   fi

					#$tlog "${USER}@${HOST} ���椤..." $LOG
                   $tlog "ssh -p 2222 -f $HOST "$SYSCHK" " $LOG
                   ssh -p 2222 -f $HOST "$SYSCHK"
                   execStatus1=$?
                   if [ $execStatus1 -eq 0 ]; then
                      echo "$HOST OK!" >> /tmp/$USER.syschk.$timestamp
                   else
                      echo "$HOST Fail!" >> /tmp/$USER.syschk.$timestamp
                   fi

				   sleep 5

					#$tlog "${USER}@${HOST} ���椤..." $LOG
                   $tlog "ssh -p 2222 -f $HOST "$FILEAUDIT" " $LOG
                   ssh -p 2222 -f $HOST "$FILEAUDIT"
                   execStatus2=$?
                   if [ $execStatus2 -eq 0 ]; then
                      echo "$HOST OK!" >> /tmp/$USER.fileaudit.$timestamp
                   else
                      echo "$HOST Fail!" >> /tmp/$USER.fileaudit.$timestamp
                   fi
                done
                echo ""
                echo "#====================================#"
                echo "#  ���ͱb��Base�ɥD�����G�M��:       #"
                echo "#====================================#"
                cat /tmp/$USER.account.$timestamp
                echo ""
                echo "#====================================#"
                echo "#  ���ͨt���ˮ�Base�ɥD�����G�M��:   #"
                echo "#====================================#"
                cat /tmp/$USER.syschk.$timestamp
                echo ""
                echo "#====================================#"
                echo "#  �����ɮײ���Base�ɥD�����G�M��:   #"
                echo "#====================================#"
                cat /tmp/$USER.fileaudit.$timestamp
                rm /tmp/$USER.syschk.$timestamp
                rm /tmp/$USER.account.$timestamp
                rm /tmp/$USER.fileaudit.$timestamp
                read ANSWR?"               ��Enter���~�� "
                main
                ;;
           *)
                echo "[Error]  ��J���~, �п�J(Y/N)"
                read ANSWR?"               ��Enter���~�� "
                STARTR
                ;;
           esac
       fi
   fi
}
#}}}
###############################################################
#{{{STARTS
STARTS () {
   clear
   echo ""
   DIRPATH=""
   HOSTN=""
   HOSTLIST=""
   MUSER=$(whoami)
   HOMEDIR=`lsuser $MUSER | awk '{print $5}' | cut -c6-`
   timestamp=`date +"%Y%m%d%H%M"`
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
	   HOSTN=$(echo $HOSTN|tr '[a-z]' '[A-Z]')

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
           FIX)
               HOSTLIST=`cat /home/se/safechk/cfg/host.lst | grep -i ^FIX`
               ;;
           TS)
               HOSTLIST=`cat /home/se/safechk/cfg/host.lst | grep -i ^TS`
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

       read DIRPATH?"��J�ؿ��Ҧb���ؿ����|��m(������|) : "
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
           read FILENAME?"             �п�J�ݭn�P�B���L�xLPAR�ؿ��W��: "
           if [ -f $DIRPATH/$FILENAME ]; then
              echo ""
              echo "               [Error]  ��J���ɦW���ɮ� "
              read ANSWR?"               ��Enter���~�� "
              main
           fi
           if [ ! -d $DIRPATH/$FILENAME ]; then
              echo ""
              echo "               [Error]  ��J���ؿ����s�b "
              read ANSWR?"               ��Enter���~�� "
              main
           fi

           echo ""
           echo "#===�D���C��===#"
           echo "$HOSTLIST"
           echo "#==============#"
           echo "�P�B�ؿ�: $DIRPATH/$FILENAME"
           echo ""
           read ANSWER?"             �нT�{�W�z��T�O�_���T(Y/N): "
           case $ANSWER in
           n|N)
                main
                ;;
           y|Y)
                        read RDIRPATH?"           �п�J�ɮ׭n�ǰe�컷�ݥD�����ؿ�(������|): "
			read ANSWER?"             �нT�{�W�z��T�O�_���T(Y/N): "
           		case $ANSWER in
           		n|N)
                	STARTS
					;;
           		y|Y)
                	cd $DIRPATH ;tar cvf - $FILENAME | gzip > $DIRPATH/$FILENAME.tar.gz
                        for HOST in $HOSTLIST ; do
                           echo "$HOST �ɮ׳ƥ���..."
                           ssh -p 2222 $HOST "mv $DIRPATH/$FILENAME $RDIRPATH/$FILENAME.$timestamp > /dev/null 2>&1"
                           echo "$HOST �ɮ׶ǰe��..."
                           scp -P 2222 $DIRPATH/$FILENAME.tar.gz $HOST:$RDIRPATH/
                           ssh -p 2222 $HOST "cd $DIRPATH ;gzip -cd $FILENAME.tar.gz | tar xvf -"
                           ssh -p 2222 $HOST "rm  $DIRPATH/$FILENAME.tar.gz"
                        done
			rm -f $DIRPATH/$FILENAME.tar.gz
			;;
			esac
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
                STARTS
                ;;
           esac
       fi
   fi
}
#}}}
###############################################################
main
