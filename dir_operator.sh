#!/bin/ksh
CFGDIR=/home/se/safechk/cfg
CFGFILE=$CFGDIR/ap_dir.cfg
main () {
	clear
	echo " << FIX/FAST ��T�ǿ�t�Ψt�ޱ��ާ@���� (ALL AIX LPAR)>> "
	echo ""
    echo "                  1:�s�W�ؿ�"
	echo ""
    echo "                  2:�R���ؿ�" 	
	echo ""
    echo "                  3:�d�ߥؿ�" 	
	echo ""
    read Menu_No?"�п�ܿﶵ(1-3) : "
    case $Menu_No in  
        1)
            DIR_INFO MKDIR
            ;;
        2)
            DIR_INFO RMDIR
            ;;
        3)
            DIR_INFO LSDIR
			;;
        q|Q)
            exit 
            ;;
        *)
            echo "" 
	    echo "[Error]  ��J���~, �п�J (1-3)���ﶵ"
	    read Answer?"  ��Enter���~�� "
	    main
            ;;
    esac

}

# Setting the LPAR information.  
MENU_INPUT () {
#set -x
   echo ""
   HOSTN=""
   HOSTLIST=""
   HOSTDIR="/home/se/safechk/cfg/host.lst" 
   timestamp=`date +"%Y%m%d%H%M%S"`
   HOSTNAME=`hostname`

   if [[ "$HOSTN" == "" ]]; then
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

	   HOSTN=`echo $HOSTN|tr '[a-z]' '[A-Z]'`
       if [[ "$HOSTN" == "q" ]] || [[ "$HOSTN" == "Q" ]]; then
           main
       fi

       case $HOSTN in
           DAP)
               HOSTLIST=`cat $HOSTDIR | grep -i ^DAP`
               ;;
           DAR)
               HOSTLIST=`cat $HOSTDIR | grep -i ^DAR`
               ;;
           MDS)
               HOSTLIST=`cat $HOSTDIR | grep -i ^MDS`
               ;;
           LOG)
               HOSTLIST=`cat $HOSTDIR | grep -i ^LOG`
               ;;
           FIX)
               HOSTLIST=`cat $HOSTDIR | grep -i ^FIXGW`
               ;;
           TS)
               HOSTLIST=`cat $HOSTDIR | grep -i ^TS`
               ;;
           ALL)
               HOSTLIST=`cat $HOSTDIR | grep -i -v $HOSTNAME`
               ;;
           *)
               HOSTLIST=$HOSTN
               ;;
	esac

			   if [[ -z "$HOSTLIST" ]]; then
           	  		echo ""
	    			echo "               [Error]  ��J���ŭ� "
	    			echo ""
	    			read ANSWR?"               ��Enter���~�� "
	    			main
			   fi
    fi
}

# Setting the User information.  
USER_CHECK (){

    DIROWNER=""
    DIRGROUP=""

    if [[ "$DIROWNER" == "" ]]; then
        echo ""
	echo "                  (�H�ɥi�� q �H���} ) "
	echo ""
	read DIROWNER?" ��J�ؿ����֦��� : "
	fi

	if [[ "$DIROWNER" == "q" ]] || [[ "$DIROWNER" == "Q" ]]; then
	    main
    fi

	USERNAMECHK=`grep "^${DIROWNER}:" /etc/passwd | awk -F: '{print $1}'`
	if [[ "$USERNAMECHK" != "$DIROWNER" ]]; then
	    echo ""
	    echo "               [Error]  ��J�ϥΪ̦W�٤��s�b "
	    echo ""
	    read ANSWR?"               ��Enter���~�� "
	    main 
	fi

	if [[ -z "$USERNAMECHK" ]]; then
	    echo ""
	    echo "               [Error]  ��J�ϥΪ̦W�٬��ŭ� "
	    echo ""
	    read ANSWR?"               ��Enter���~�� "
	    main 
	fi

        read DIRGROUP?" ��J�ؿ����֦��s�� : "
	if [[ "$DIRGROUP" == "q" ]] || [[ "$DIRGROUP" == "Q" ]]; then
	    main
	fi

	GROUPCHK=`grep "^${DIRGROUP}:" /etc/group | awk -F: '{print $1}'`

	if [[ "$GROUPCHK" != "$DIRGROUP" ]]; then
	    echo ""
	    echo "               [Error]  ��J�s�դ��s�b "
	    echo ""
	    read ANSWR?"               ��Enter���~�� "
	    main 
	fi

	if [[ -z "$GROUPCHK" ]]; then
  	    echo ""
	    echo "               [Error]  ��J�s�լ��ŭ� "
	    echo ""
	    read ANSWR?"               ��Enter���~�� "
	    main 
	fi
}

# Setting the Directory information.  
DIR_CHECK () {
	
DIRPATH=""
DIRPERM=""
MODE=$1

    read DIRPATH?" ��J�ؿ������|��m(������|) : "

    if [[ "$DIRPATH" == "q" ]] || [[ "$DIRPATH" == "Q" ]]; then
        main
    fi

    if [[ -z "$DIRPATH" ]]; then
        echo ""
        echo "               [Error]  ��J�ؿ����ŭ� "
		echo ""
		read ANSWR?"               ��Enter���~�� "
        main
    fi


	if [[ $MODE = MKDIR ]]; then

		read DIRPERM?" ��J�ؿ����v��,�п�J3��(0-7�Ʀr),�p755: "

		if [[ "$DIRPERM" == "q" ]] || [[ "$DIRPERM" == "Q" ]]; then
			main
		fi

		if [[ "$DIRPERM" != [1-7][0-7][0-7] ]]; then
			echo ""
			echo "               [Error]  ��JPermission�D�Ʀr�榡,�п�J3��(0-7�d��)���Ʀr"
			echo ""
			read ANSWR?"               ��Enter���~�� "
			main
		fi
	fi
}

# Setting the main information.  
DIR_INFO () {
#set -x 

MODE=$1
DIRPATH=""
DIRPERM=""
CHKFLG=0

# User the MENU_INPUT function, to Set the LPAR information.  
MENU_INPUT
# User the USER_CHECK function, to Set the USER information.  
USER_CHECK

# User the DIR_CHECK function, to Set the Directory information.  
if [[ $MODE = MKDIR ]]; then
    DIR_CHECK MKDIR
fi

# User the DIR_CHECK function, to Set the Directory information.  
if [[ $MODE = RMDIR ]]; then
    DIR_CHECK RMDIR
fi

# User the DIR_CHECK function, to Set the Directory information.  
if [[ $MODE = LSDIR ]]; then
    DIR_CHECK LSDIR
fi
    if [[ "$CHKFLG" != "0" ]]; then
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
	echo "#===�D���C��===#"
	echo "$HOSTLIST"
    echo "#==============#"
		   
	read ANSWER?"             �нT�{�W�z��T�L�~(Y/N): "
	case $ANSWER in
	    n|N)
	        main
	        ;;
	    y|Y)

			LPARTYPE=`echo $HOSTN|cut -c1-3`

			if [[ $MODE = RMDIR ]]; then
				CONFIRM=`awk -v LPARTYPE=$LPARTYPE -v DIRPATH=$DIRPATH '{if ($2==LPARTYPE && $3==DIRPATH) {print $0}}' $CFGFILE`
				if [[ ! -z  $CONFIRM ]]; then
				    grep -v ".*${LPARTYPE}.*${DIRPATH}[[:space:]].*" $CFGFILE > ${CFGFILE}.bak  
					mv ${CFGFILE}.bak $CFGFILE
				fi
			fi

			#LINE=$(grep -n "$LPARTYPE[[:space:]]" $CFGFILE | awk -F: '{print $1}'| tail -1)
			#LINE=$(grep -v '^#' $APCFG|grep $HOST|wc -l)

			if [[ $MODE = MKDIR ]];then 
				CMDTYPE="$DIROWNER:$DIRGROUP $DIRPATH $DIRPERM $MODE "
			else 
				CMDTYPE="$DIRPATH $MODE "
			fi

#			exit

			for HOST in $HOSTLIST ; do
	            echo "$HOST ���椤..."

#				echo "SSH_CMD $CMDTYPE"
				SSH_CMD $CMDTYPE

				if [[ $MODE = MKDIR ]] || [[ $MODE = LSDIR ]] ;then 
					if [[ -e /tmp/dirdatafile.${HOST} ]] && [[  -s /tmp/dirdatafile.${HOST} ]] ; then
						echo $HOST OK! >> /tmp/$USER.$timestamp
						cat /tmp/dirdatafile.${HOST} >> /tmp/$USER.$timestamp
						rm /tmp/dirdatafile.${HOST}
					else
						echo "$HOST has a problem!,The $DIR is not exist"  >> /tmp/$USER.$timestamp
					fi
				else
					if [[ -e /tmp/dirdatafile.${HOST} ]] && [[  ! -s /tmp/dirdatafile.${HOST} ]] ; then
						echo "$HOST OK!,The $DIR is remove Success" >> /tmp/$USER.$timestamp
						cat /tmp/dirdatafile.${HOST} >> /tmp/$USER.$timestamp
						rm /tmp/dirdatafile.${HOST}
					else
						echo "$HOST has a problem!,The $DIR remove Failed"  >> /tmp/$USER.$timestamp
					fi

				fi
	        done
#-----------------------------------------------------------
# Section 2 --- Verify that the directory were created
#    Part 2 --- Inspect the retrieved files
#-----------------------------------------------------------

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
	         	main
	         ;;
        esac
    fi
}

# Use the ssh Remote excution to the LPAR .
SSH_CMD() {
#set -x 

#-----------------------------------------------------------
#Create or delete directory --- create or delete directory on a list of hosts
#You will need to adjust HOSTLIST, OWNER, PERMIT.  You may need to adjust DELAY
#-----------------------------------------------------------

if [[ $# -lt 2 ]]; then
    echo "Please Input mkdir_ssh.sh Owner:Group Directory Permission"
    echo
    echo "Example: mkdir_ssh.sh useradm:security /home/se/test 755 MKDIR/RMDIR"
    echo "Example: mkdir_ssh.sh /home/se/test MKDIR/RMDIR"
    exit 1
fi

#-----------------------------------------------------------
# Section 0 --- Set variable
#-----------------------------------------------------------

DELAY=1
USER=$(whoami)
HOMEDIR=`lsuser $USER | awk '{print $5}' | cut -c6-`

# When Paremeter is 4 , then the mode is mkdir.
if [[ $# -eq 4 ]]; then
	OWNER=$1
	DIR=$2
	PERMIT=$3
	MODE=$4
fi

# When Paremeter is 2 , then the mode is rmdir. 
if [[ $# -eq 2 ]]; then
	DIR=$1
	MODE=$2
fi


exec 4>&1

#-----------------------------------------------------------
# Section 1 --- Create Directory
#-----------------------------------------------------------
if [[ $MODE = "MKDIR" ]]; then
    ssh -p 2222 -t -t $HOST >&4 2>/dev/null |&
    print -p mkdir -p $DIR
    print -p chown $OWNER $DIR
    print -p chmod $PERMIT $DIR
    print -p "test -d $DIR && touch /tmp/dirdatafile.${HOST}"
	print -p "ls -ld $DIR > /tmp/dirdatafile.${HOST}"
    print -p exit
    wait
fi

if [[ $MODE = "RMDIR" ]] ; then
    ssh -p 2222 -t -t $HOST >&4 2>/dev/null |&
    print -p rm -rf $DIR
    print -p "test ! -d $DIR && touch /tmp/dirdatafile.${HOST}"
    print -p exit
    wait
fi

if [[ $MODE = "LSDIR" ]]; then
    ssh -p 2222 -t -t $HOST >&4 2>/dev/null |&
    print -p "test -d $DIR && touch /tmp/dirdatafile.${HOST}"
	print -p "ls -ld $DIR > /tmp/dirdatafile.${HOST}"
    print -p exit
    wait
fi

#-----------------------------------------------------------
# Section 2 --- Verify that the directory were created
#    Part 1 --- Retrieve those check files
#-----------------------------------------------------------
	echo "$HOST ���G�ˬd��..."
    scp -P 2222 ${USER}@${HOST}:/tmp/dirdatafile.${HOST} /tmp/
	ssh -p 2222 ${USER}@${HOST} "rm -f /tmp/dirdatafile.${HOST}"
}

main
