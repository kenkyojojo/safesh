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
echo "          << FIX/FAST 資訊傳輸系統系管與安控操作介面 (ALL AIX LPAR)>> "
echo ""
echo "        1. 新增使用者帳號                        11. 關閉Telnet 服務"
echo ""
echo "        2. 刪除使用者帳號                        12. 開啟Telnet 服務"
echo ""
echo "        3. 同步更改密碼                          13. 執行遠端指令"
echo ""
echo "        4. 解除帳戶鎖定狀態                      14. 取得遠端檔案"
echo ""
echo "        5. 新建目錄                              15. 取得遠端目錄"
echo ""
echo "        6. 刪除目錄                              16. Faillogin次數reset"
echo ""
echo "        7. 新增群組                              17. 產生SSH Key"
echo ""
echo "        8. 刪除群組                              18. 產生安控檢核Base檔"
echo ""
echo "        9. 同步檔案                              19. 同步目錄"
echo ""
echo "       10. 每日值班檢核報表檔案重傳"
echo ""
echo "                                (隨時可輸 q 以離開 )"
echo ""
read Menu_No?"                                 請選擇選項 (1-19) : "

create_log

case $Menu_No in
	1)
                if [ "$USER" == "root" ] || [ "$USER" == "useradm" ]; then
                   STARTA
                else
                   echo ""
                   echo "      $USER 無權限使用此功能, 請洽系統管理員"
                   read ANSWR?"                 按Enter鍵繼續 "
                   main
                fi
		;;
	2)
                if [ "$USER" == "root" ] || [ "$USER" == "useradm" ]; then
                   STARTB
                else
                   echo ""
                   echo "      $USER 無權限使用此功能, 請洽系統管理員"
                   read ANSWR?"                 按Enter鍵繼續 "
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
                   echo "      $USER 無權限使用此功能, 請洽系統管理員"
                   read ANSWR?"                 按Enter鍵繼續 "
                   main
                fi
		;;
	5)
                if [ "$USER" == "root" ] || [ "$USER" == "useradm" ]; then
                   STARTE
                else
                   echo ""
                   echo "      $USER 無權限使用此功能, 請洽系統管理員"
                   read ANSWR?"                 按Enter鍵繼續 "
                   main
                fi
		;;
	6)
                if [ "$USER" == "root" ] || [ "$USER" == "useradm" ]; then
                   STARTF
                else
                   echo ""
                   echo "      $USER 無權限使用此功能, 請洽系統管理員"
                   read ANSWR?"                 按Enter鍵繼續 "
                   main
                fi
		;;
	7)
                if [ "$USER" == "root" ] || [ "$USER" == "useradm" ]; then
                   STARTG
                else
                   echo ""
                   echo "      $USER 無權限使用此功能, 請洽系統管理員"
                   read ANSWR?"                 按Enter鍵繼續 "
                   main
                fi
		;;
	8)
                if [ "$USER" == "root" ] || [ "$USER" == "useradm" ]; then
                   STARTH
                else
                   echo ""
                   echo "      $USER 無權限使用此功能, 請洽系統管理員"
                   read ANSWR?"                 按Enter鍵繼續 "
                   main
                fi
		;;
	9)
                if [ "$USER" == "root" ] || [ "$USER" == "useradm" ]; then
                   STARTI
                else
                   echo ""
                   echo "      $USER 無權限使用此功能, 請洽系統管理員"
                   read ANSWR?"                 按Enter鍵繼續 "
                   main
                fi
		;;
	10)
                if [ "$USER" == "root" ] || [ "$USER" == "useradm" ]; then
                   STARTJ
                else
                   echo ""
                   echo "      $USER 無權限使用此功能, 請洽系統管理員"
                   read ANSWR?"                 按Enter鍵繼續 "
                   main
                fi
		;;
	11)
                if [ "$USER" == "root" ] || [ "$USER" == "useradm" ]; then
                   STARTK
                else
                   echo ""
                   echo "      $USER 無權限使用此功能, 請洽系統管理員"
                   read ANSWR?"                 按Enter鍵繼續 "
                   main
                fi
		;;
	12)
                if [ "$USER" == "root" ] || [ "$USER" == "useradm" ]; then
                   STARTL
                else
                   echo ""
                   echo "      $USER 無權限使用此功能, 請洽系統管理員"
                   read ANSWR?"                 按Enter鍵繼續 "
                   main
                fi
		;;
	13)
                if [ "$USER" == "root" ] || [ "$USER" == "useradm" ]; then
                   STARTM
                else
                   echo ""
                   echo "      $USER 無權限使用此功能, 請洽系統管理員"
                   read ANSWR?"                 按Enter鍵繼續 "
                   main
                fi
		;;
	14)
                if [ "$USER" == "root" ] || [ "$USER" == "useradm" ]; then
                   STARTN
                else
                   echo ""
                   echo "      $USER 無權限使用此功能, 請洽系統管理員"
                   read ANSWR?"                 按Enter鍵繼續 "
                   main
                fi
		;;
	15)
                if [ "$USER" == "root" ] || [ "$USER" == "useradm" ]; then
                   STARTO
                else
                   echo ""
                   echo "      $USER 無權限使用此功能, 請洽系統管理員"
                   read ANSWR?"                 按Enter鍵繼續 "
                   main
                fi
		;;
    16)
                if [ "$USER" == "root" ] || [ "$USER" == "useradm" ]; then
                   STARTP
                else
                   echo ""
                   echo "      $USER 無權限使用此功能, 請洽系統管理員"
                   read ANSWR?"                 按Enter鍵繼續 "
                   main
                fi
                ;;
    17)
                if [ "$USER" == "root" ] || [ "$USER" == "useradm" ]; then
                   STARTQ
                else
                   echo ""
                   echo "      $USER 無權限使用此功能, 請洽系統管理員"
                   read ANSWR?"                 按Enter鍵繼續 "
                   main
                fi
                ;;
    18)
                if [ "$USER" == "root" ] ; then
                   STARTR
                else
                   echo ""
                   echo "      $USER 無權限使用此功能, 請洽系統管理員"
                   read ANSWR?"                 按Enter鍵繼續 "
                   main
                fi
                ;;
	19)
                if [ "$USER" == "root" ] || [ "$USER" == "useradm" ]; then
                   STARTS
                else
                   echo ""
                   echo "      $USER 無權限使用此功能, 請洽系統管理員"
                   read ANSWR?"                 按Enter鍵繼續 "
                   main
                fi
		;;
	q|Q)
		exit
		;;
		
	*)
                echo ""
		echo "        [Error]  輸入錯誤, 請輸入 (1-19)的選項"
                read ANSWR?"               按Enter鍵繼續 "
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
       echo "                  (隨時可輸 q 以離開 ) "
       echo ""

       read GROUP?" 輸入群組名稱( 必須 ) : "
       if [ "$GROUP" == "q" ] || [ "$GROUP" == "Q" ]; then
           main
       fi

       read UMASK?" 輸入umask( 必須 ) : "
       if [ "$UMASK" == "q" ] || [ "$UMASK" == "Q" ]; then
           main
       fi

       read UID?" 輸入user id( 必須 ) : "
       if [ "$UID" == "q" ] || [ "$UID" == "Q" ]; then
           main
       fi

       read USERNAME?" 輸入user name( 必須 ) : "
       if [ "$USERNAME" == "q" ] || [ "$USERNAME" == "Q" ]; then
           main
       fi

       if [ -z "$GROUP" ]; then
           echo ""
           echo "               [Error]  輸入群組名稱為空值 "
           CHKFLG=1
       fi
       GROUPCHK=`grep "^${GROUP}:" /etc/group | awk -F: '{print $1}'`
       if [ "$GROUPCHK" != "$GROUP" ]; then
           echo ""
           echo "               [Error]  輸入群組不存在 "
           CHKFLG=1
       fi

       if [[ "$UMASK" != ?(+|-)+([0-7][0-7][0-7]) ]]; then
           echo ""
           echo "               [Error]  輸入UMASK非數字格式 "
           CHKFLG=1
       fi

       if [[ "$UID" != ?(+|-)+([0-7][0-7][0-7]) ]]; then
           echo "               [Error]  輸入UID非數字格式 "
           CHKFLG=1
       else
           UIDCHK=`cat /etc/passwd | awk -F: '{print $3}' | grep "${UID}"`
           if [ "$UIDCHK" == "$UID" ]; then
               echo ""
               echo "               [Error]  輸入UID已存在 "
               CHKFLG=1
           fi
       fi

       if [ -z "$USERNAME" ]; then
           echo ""
           echo "               [Error]  輸入使用者名稱為空值 "
           CHKFLG=1
       fi
       USERNAMECHK=`grep "^${USERNAME}:" /etc/passwd | awk -F: '{print $1}'`
       if [ "$USERNAMECHK" == "$USERNAME" ]; then
           echo ""
           echo "               [Error]  輸入username已存在 "
           CHKFLG=1
       fi
       
       if [ "$CHKFLG" != "0" ]; then
           echo ""
           read ANSWR?"               按Enter鍵繼續 "
           main
       else
           echo ""
           echo "Group name:         $GROUP"
           echo "Umask:              $UMASK"
           echo "User ID:            $UID"
           echo "User Name:          $USERNAME"
           echo ""
           read ANSWER?"             請確認上述資訊無誤(Y/N): "
           case $ANSWER in
           n|N)
                main
                ;;
           y|Y)
                /home/se/safechk/safesh/adduser_ssh.sh $GROUP $GROUP $UMASK $UID $USERNAME
                read ANSWR?"               按Enter鍵繼續 "
                main
                ;;
           *)
                echo "[Error]  輸入錯誤, 請輸入(Y/N)"
                read ANSWR?"               按Enter鍵繼續 "
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
       echo "                  (隨時可輸 q 以離開 ) "
       echo ""
       read USERNAME?" 輸入User name( 必須 ) : "
       if [ "$USERNAME" == "q" ] || [ "$USERNAME" == "Q" ]; then
           main
       fi

       if [ -z "$USERNAME" ]; then
           echo ""
           echo "               [Error]  輸入為空值 "
           CHKFLG=1
       fi

       USERCHK=`grep "^${USERNAME}:" /etc/passwd | awk -F: '{print $1}'`
       if [ "$USERCHK" != "$USERNAME" ]; then
           echo ""
           echo "               [Error]  輸入使用者名稱不存在 "
           CHKFLG=1
       fi

       if [ "$CHKFLG" != "0" ]; then
           echo ""
           read ANSWR?"               按Enter鍵繼續 "
           main
       else
           echo ""
           echo "欲刪除的User: $USERNAME"
           read ANSWER?"             請確認上述資訊無誤(Y/N): "
           case $ANSWER in
           n|N)
                main
                ;;
           y|Y)
                /home/se/safechk/safesh/deluser_ssh.sh $USERNAME
                read ANSWR?"               按Enter鍵繼續 "
                main
                ;;
           *)
                echo "[Error]  輸入錯誤, 請輸入(Y/N)"
                read ANSWR?"               按Enter鍵繼續 "
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
   echo "#  此功能會同步變更所有LPAR主機的使用者密碼  #"
   echo "#============================================#"
   echo ""
   echo "欲變更 ${USER} 的密碼?"
   echo ""
   read ANSWER?"            請確認要變更的User 無誤(Y/N): "
   case $ANSWER in
   n|N)
        main
        ;;
   y|Y)
        /home/se/safechk/safesh/pwchg_all.sh
        read ANSWR?"               按Enter鍵繼續 "
        main
        ;;
   *)
        echo ""
        echo "[Error]  輸入錯誤, 請輸入(Y/N)"
        read ANSWR?"               按Enter鍵繼續 "
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
       echo "                  (隨時可輸 q 以離開 ) "
       echo ""
       read USERNAME?" 輸入需解鎖的User name( 必須 ) : "
       if [ "$USERNAME" == "q" ] || [ "$USERNAME" == "Q" ]; then
           main
       fi

       read USERPASS?" 輸入需解鎖的User 預設Password( 必須 ) : "
       if [ "$USERPASS" == "q" ] || [ "$USERPASS" == "Q" ]; then
           main
       fi

       if [ -z "$USERNAME" ]; then
           echo ""
           echo "               [Error]  輸入為空值 "
           CHKFLG=1
       fi
       USERCHK=`grep "^${USERNAME}:" /etc/passwd | awk -F: '{print $1}'`
       if [ "$USERCHK" != "$USERNAME" ]; then
           echo ""
           echo "               [Error]  輸入使用者名稱不存在 "
           CHKFLG=1
       fi

       if [ -z "$USERPASS" ]; then
           echo ""
           echo "               [Error]  密碼輸入為空值 "
           CHKFLG=1
       fi


       if [ "$CHKFLG" != "0" ]; then
           echo ""
           read ANSWR?"               按Enter鍵繼續 "
           main
       else
           echo ""
           echo "欲解鎖的User Name: $USERNAME"
           echo "欲解鎖的User Password: $USERPASS"
           read ANSWER?"             請確認上述資訊無誤(Y/N): "
           case $ANSWER in
           n|N)
                main
                ;;
           y|Y)
                /home/se/safechk/safesh/usrlock_ssh.sh $USERNAME $USERPASS
                read ANSWR?"               按Enter鍵繼續 "
                main
                ;;
           *)
                echo "[Error]  輸入錯誤, 請輸入(Y/N)"
                read ANSWR?"               按Enter鍵繼續 "
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
       echo "                  (隨時可輸 q 以離開 ) "
       echo ""
       read DIROWNER?" 輸入目錄的擁有者 : "
       if [ "$DIROWNER" == "q" ] || [ "$DIROWNER" == "Q" ]; then
           main
       fi

       read DIRGROUP?" 輸入目錄的擁有群組 : "
       if [ "$DIRGROUP" == "q" ] || [ "$DIRGROUP" == "Q" ]; then
           main
       fi

       read DIRPATH?" 輸入目錄的路徑位置(絕對路徑) : "
       if [ "$DIRPATH" == "q" ] || [ "$DIRPATH" == "Q" ]; then
           main
       fi

       read DIRPERM?" 輸入目錄的權限 (數字) : "
       if [ "$DIRPERM" == "q" ] || [ "$DIRPERM" == "Q" ]; then
           main
       fi

       USERNAMECHK=`grep "^${DIROWNER}:" /etc/passwd | awk -F: '{print $1}'`
       if [ "$USERNAMECHK" != "$DIROWNER" ]; then
           echo ""
           echo "               [Error]  輸入使用者名稱不存在 "
           CHKFLG=1
       fi
       if [ -z "$USERNAMECHK" ]; then
           echo ""
           echo "               [Error]  輸入使用者名稱為空值 "
           CHKFLG=1
       fi

       GROUPCHK=`grep "^${DIRGROUP}:" /etc/group | awk -F: '{print $1}'`
       if [ "$GROUPCHK" != "$DIRGROUP" ]; then
           echo ""
           echo "               [Error]  輸入群組不存在 "
           CHKFLG=1
       fi
       if [ -z "$GROUPCHK" ]; then
           echo ""
           echo "               [Error]  輸入群組為空值 "
           CHKFLG=1
       fi

       if [ -z "$DIRPATH" ]; then
           echo ""
           echo "               [Error]  輸入目錄為空值 "
           CHKFLG=1
       fi

       if [[ "$DIRPERM" != ?(+|-)+([0-9]) ]]; then
           echo ""
           echo "               [Error]  輸入Permission非數字格式 "
           CHKFLG=1
       fi

       if [ "$CHKFLG" != "0" ]; then
           echo ""
           read ANSWR?"               按Enter鍵繼續 "
           main
       else
           echo ""
           echo "Directory OWNER:      $DIROWNER"
           echo "Directory GROUP:      $DIRGROUP"
           echo "Directory PATH:       $DIRPATH"
           echo "Directory Permission: $DIRPERM"
           echo ""
           read ANSWER?"             請確認上述資訊無誤(Y/N): "
           case $ANSWER in
           n|N)
                main
                ;;
           y|Y)
                /home/se/safechk/safesh/mkdir_ssh.sh $DIROWNER:$DIRGROUP $DIRPATH $DIRPERM
                read ANSWR?"               按Enter鍵繼續 "
                main
                ;;
           *)
                echo "[Error]  輸入錯誤, 請輸入(Y/N)"
                read ANSWR?"               按Enter鍵繼續 "
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
       echo "                  (隨時可輸 q 以離開 ) "
       echo ""
       read DIRPATH?" 輸入目錄的路徑位置(絕對路徑) : "
       if [ "$DIRPATH" == "q" ] || [ "$DIRPATH" == "Q" ]; then
           main
       fi

       if [ ! -d $DIRPATH ]; then
           echo ""
           echo "               [Error]  輸入的目錄不存在 "
           CHKFLG=1
       fi
       if [ -z "$DIRPATH" ]; then
           echo ""
           echo "               [Error]  輸入為空值 "
           CHKFLG=1
       fi

       if [ "$CHKFLG" != "0" ]; then
           echo ""
           read ANSWR?"               按Enter鍵繼續 "
           main
       else
           echo ""
           echo "Directory PATH: $DIRPATH"
           echo ""
           echo "                       [Warning] 此動作無法復原, 請留意!!!"
           echo ""
           read ANSWER?"             請確認上述目錄是否要刪除, 執行後目錄與檔案皆會刪除(Y/N): "
           case $ANSWER in
           n|N)
                main
                ;;
           y|Y)
                /home/se/safechk/safesh/rmdir_ssh.sh $DIRPATH
                read ANSWR?"               按Enter鍵繼續 "
                main
                ;;
           *)
                echo "[Error]  輸入錯誤, 請輸入(Y/N)"
                read ANSWR?"               按Enter鍵繼續 "
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
       echo "                  (隨時可輸 q 以離開 ) "
       echo ""
       read GROUP?" 輸入要新增的群組名稱: "
       if [ "$GROUP" == "q" ] || [ "$GROUP" == "Q" ]; then
           main
       fi

       read GID?" 輸入要新增的群組GID: "
       if [ "$GID" == "q" ] || [ "$GID" == "Q" ]; then
           main
       fi

       if [ -z "$GROUP" ]; then
           echo ""
           echo "               [Error]  輸入群組名稱為空值 "
           CHKFLG=1
       fi
       GROUPCHK=`grep "^${GROUP}:" /etc/group | awk -F: '{print $1}'`
       if [ "$GROUPCHK" == "$GROUP" ]; then
           echo ""
           echo "               [Error]  輸入群組已存在 "
           CHKFLG=1
       fi

       if [[ "$GID" != ?(+|-)+([0-9]) ]]; then
           echo "               [Error]  輸入GID非數字格式 "
           CHKFLG=1
       else
           GIDCHK=`cut -f "3" -d : /etc/group | grep "^$GID"`
           if [ "$GIDCHK" == "$GID" ]; then
               echo ""
               echo "               [Error]  輸入GID已存在 "
               CHKFLG=1
           fi
       fi

       if [ "$CHKFLG" != "0" ]; then
           echo ""
           read ANSWR?"               按Enter鍵繼續 "
           main
       else
           echo ""
           echo "Group Name: $GROUP"
           echo "Group ID: $GID"
           echo ""
           read ANSWER?"             請確認上述資訊無誤(Y/N): "
           case $ANSWER in
           n|N)
                main
                ;;
           y|Y)
                /home/se/safechk/safesh/mkgroup_ssh.sh $GID $GROUP
                read ANSWR?"               按Enter鍵繼續 "
                main
                ;;
           *)
                echo "[Error]  輸入錯誤, 請輸入(Y/N)"
                read ANSWR?"               按Enter鍵繼續 "
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
       echo "                  (隨時可輸 q 以離開 ) "
       echo ""
       read GROUP?" 輸入要刪除的群組名稱: "
       if [ "$GROUP" == "q" ] || [ "$GROUP" == "Q" ]; then
           main
       fi

       if [ -z "$GROUP" ]; then
           echo ""
           echo "               [Error]  輸入群組名稱為空值 "
           CHKFLG=1
       fi
       GROUPCHK=`grep "^${GROUP}:" /etc/group | awk -F: '{print $1}'`
       if [ "$GROUPCHK" != "$GROUP" ]; then
           echo ""
           echo "               [Error]  輸入群組不存在 "
           CHKFLG=1
       fi

       if [ "$CHKFLG" != "0" ]; then
           echo ""
           read ANSWR?"               按Enter鍵繼續 "
           main
       else
           echo ""
           echo "Group Name: $GROUP"
           echo ""
           read ANSWER?"             請確認上述要刪除的群組名稱無誤(Y/N): "
           case $ANSWER in
           n|N)
                main
                ;;
           y|Y)
                /home/se/safechk/safesh/rmgroup_ssh.sh $GROUP
                read ANSWR?"               按Enter鍵繼續 "
                main
                ;;
           *)
                echo "[Error]  輸入錯誤, 請輸入(Y/N)"
                read ANSWR?"               按Enter鍵繼續 "
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
       echo "                  (隨時可輸 q 以離開 ) "
       echo "#==========================================================#"
       echo "# 輸入格式(每台主機以空格做為分隔): DAP1-1 DAR1-1 LOG1 MDS1#"
       echo "#                                                          #"
       echo "# 群組輸入格式: DAP (一次一個群組)                         #"
       echo "#                                                          #"
       echo "# 全部主機請輸入: ALL                                      #"
       echo "#==========================================================#"
       read HOSTN?"輸入欲傳送的主機名稱 : "
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
          echo "               [Error]  輸入為空值 "
          echo ""
          read ANSWR?"               按Enter鍵繼續 "
          main
       fi

       read DIRPATH?"輸入檔案所在的目錄路徑位置(絕對路徑) : "
       if [ "$DIRPATH" == "q" ] || [ "$DIRPATH" == "Q" ]; then
           main
       fi

       if [ ! -d $DIRPATH ]; then
           echo ""
           echo "               [Error]  輸入的目錄不存在 "
           CHKFLG=1
       fi
       if [ -z "$DIRPATH" ]; then
           echo ""
           echo "               [Error]  輸入為空值 "
           CHKFLG=1
       fi

       if [ "$CHKFLG" != "0" ]; then
           echo ""
           read ANSWR?"               按Enter鍵繼續 "
           main
       else
           echo "Directory PATH: $DIRPATH"
           echo ""
           ls -ltr $DIRPATH
           read FILENAME?"             請輸入需要同步到其他台LPAR檔案名稱: "
           if [ -d $DIRPATH/$FILENAME ]; then
              echo ""
              echo "               [Error]  輸入的檔名為目錄 "
              read ANSWR?"               按Enter鍵繼續 "
              main
           fi
           if [ ! -f $DIRPATH/$FILENAME ]; then
              echo ""
              echo "               [Error]  輸入的檔名不存在 "
              read ANSWR?"               按Enter鍵繼續 "
              main
           fi

           echo ""
           echo "#===主機列表===#"
           echo "$HOSTLIST"
           echo "#==============#"
           echo "同步檔案: $DIRPATH/$FILENAME"
           echo ""
           read ANSWER?"             請確認上述資訊是否正確(Y/N): "
           case $ANSWER in
           n|N)
                main
                ;;
           y|Y)
                read RDIRPATH?"             請輸入檔案要傳送到遠端主機的目錄(絕對路徑): "
                for HOST in $HOSTLIST ; do
                   echo "$HOST 檔案傳送中..."
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
                   echo "$HOST 結果檢查中..."
                   scp -P 2222 ${MUSER}@${HOST}:$HOMEDIR/scpdatafile.${HOST} /tmp/
                   ssh -p 2222 ${MUSER}@${HOST} "rm -f $HOMEDIR/scpdatafile.${HOST}"
                done

                errors=0
                echo
                echo "#==========================#"
                echo "#  同步檔案主機結果清單:   #"
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

                read ANSWR?"               按Enter鍵繼續 "
                main
                ;;
           *)
                echo "[Error]  輸入錯誤, 請輸入(Y/N)"
                read ANSWR?"               按Enter鍵繼續 "
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
       echo "                  (隨時可輸 q 以離開 ) "
       echo ""
       echo "輸入格式(每台主機以空格做為分隔): DAP1-1 DAR1-1 LOG1 MDS1"
       read HOSTLIST?" 輸入欲重傳的主機名稱 (未輸入預設為全部) : "
       if [ "$HOSTLIST" == "q" ] || [ "$HOSTLIST" == "Q" ]; then
           main
       fi

       if [ -z "$HOSTLIST" ]; then
           echo ""
           echo "               輸入為空值, 預設會代入全部的主機LPAR"
           echo ""
           read ANSWER?"               請確認是否繼續(Y/N): "
           case $ANSWER in
           n|N)
                main
                ;;
           y|Y)
                HOSTLIST=`cat /home/se/safechk/cfg/host.lst`
                ;;
           *)
                echo "[Error]  輸入錯誤, 請輸入(Y/N)"
                read ANSWR?"               按Enter鍵繼續 "
                STARTJ
                ;;
           esac
       fi

       if [ "$CHKFLG" != "0" ]; then
           echo ""
           read ANSWR?"               按Enter鍵繼續 "
           main
       else
           echo ""
           echo "#===主機列表===#"
           echo "$HOSTLIST"
           echo "#==============#"
           echo ""
           read ANSWER?"             請確認上述資訊是否正確(Y/N): "
           case $ANSWER in
           n|N)
                main
                ;;
           y|Y)
                for HOST in $HOSTLIST ; do
                   echo "$HOST 傳輸中..."
                   scp -P 2222 ${USER}@${HOST}:$SEDIR/$DATE2.$HOST.*.txt $CSVDIR
                   scp -P 2222 ${USER}@${HOST}:$SEDIR/$DATE2.$HOST.*.csv $LOGDIR
                   scp -P 2222 ${USER}@${HOST}:$SEDIR/dailycheck/account/result/${HOST}_`date +%Y%m%d_user_attr.rst` $ITMDIR
                   scp -P 2222 ${USER}@${HOST}:$SEDIR/dailycheck/file_audit/result/${HOST}_`date +%Y%m%d_file_attr.rst` $ITMDIR
                   echo "$HOST 傳輸結束..."
                   echo ""
                done
                read ANSWR?"               按Enter鍵繼續 "
                main
                ;;
           *)
                echo "[Error]  輸入錯誤, 請輸入(Y/N)"
                read ANSWR?"               按Enter鍵繼續 "
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
   read ANSWER?"             請確認要是否要關閉telnet Service(Y/N): "
   case $ANSWER in
   n|N)
        main
        ;;
   y|Y)
        /home/se/safechk/safesh/stoptelnet.sh
        read ANSWR?"               按Enter鍵繼續 "
        main
        ;;
   *)
        echo ""
        echo "[Error]  輸入錯誤, 請輸入(Y/N)"
        read ANSWR?"               按Enter鍵繼續 "
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
   read ANSWER?"             請確認要是否要開啟telnet Service(Y/N): "
   case $ANSWER in
   n|N)
        main
        ;;
   y|Y)
        /home/se/safechk/safesh/starttelnet.sh
        read ANSWR?"               按Enter鍵繼續 "
        main
        ;;
   *)
        echo ""
        echo "[Error]  輸入錯誤, 請輸入(Y/N)"
        read ANSWR?"               按Enter鍵繼續 "
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
       echo "                  (隨時可輸 q 以離開 ) "
       echo "#==========================================================#"
       echo "# 輸入格式(每台主機以空格做為分隔): DAP1-1 DAR1-1 LOG1 MDS1#"
       echo "#                                                          #"
       echo "# 群組輸入格式: DAP (一次一個群組)                         #"
       echo "#                                                          #"
       echo "# 全部主機請輸入: ALL                                      #"
       echo "#==========================================================#"
       read HOSTN?"輸入欲執行指令的主機名稱 : "
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
           echo "               [Error]  輸入為空值 "
           echo ""
           read ANSWR?"               按Enter鍵繼續 "
           main
       fi

       echo ""
       read COMMAND?"               請輸入要執行的指令: "
       if [ "$COMMAND" == "q" ] || [ "$COMMAND" == "Q" ]; then
           main
       fi
       if [ -z "$COMMAND" ]; then
           echo ""
           echo "               [Error]  指令輸入為空值 "
           CHKFLG=1
       fi

       if [ "$CHKFLG" != "0" ]; then
           echo ""
           read ANSWR?"               按Enter鍵繼續 "
           main
       else
           echo ""
           echo "#===主機列表===#"
           echo "$HOSTLIST"
           echo "#==============#"
           echo "執行指令: $COMMAND"
           echo ""
           read ANSWER?"             請確認上述資訊是否正確(Y/N): "
           case $ANSWER in
           n|N)
                main
                ;;
           y|Y)
			   $tlog "#============================================================= " $LOG
                for HOST in $HOSTLIST ; do
                   $tlog "${USER}@${HOST} 執行中..." $LOG
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
                echo "#  執行指令主機結果清單:   #"
                echo "#==========================#"
                cat /tmp/$USER.$timestamp
                rm /tmp/$USER.$timestamp
                read ANSWR?"               按Enter鍵繼續 "
                main
                ;;
           *)
                echo "[Error]  輸入錯誤, 請輸入(Y/N)"
                read ANSWR?"               按Enter鍵繼續 "
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
       echo "                  (隨時可輸 q 以離開 ) "
       echo "#==========================================================#"
       echo "# 輸入格式(每台主機以空格做為分隔): DAP1-1 DAR1-1 LOG1 MDS1#"
       echo "#                                                          #"
       echo "# 群組輸入格式: DAP (一次一個群組)                         #"
       echo "#                                                          #"
       echo "# 全部主機請輸入: ALL                                      #"
       echo "#==========================================================#"
       read HOSTN?"輸入欲取檔案的遠端主機名稱 : "
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
           echo "               [Error]  輸入為空值 "
           echo ""
           read ANSWR?"               按Enter鍵繼續 "
           main
       fi

       echo ""
       read DIRPATH?"輸入檔案所在的目錄的路徑位置(絕對路徑) : "
       if [ "$DIRPATH" == "q" ] || [ "$DIRPATH" == "Q" ]; then
           main
       fi


       echo ""
       read FILENAME?"請輸入要備份下傳的檔案(檔名): "
       if [ "$FILENAME" == "q" ] || [ "$FILENAME" == "Q" ]; then
           main
       fi

       echo ""
       echo "                    [Warning]若遠端LPAR相同檔名下載至本地會覆蓋 "
       echo "                    選 Y 若檔名相同會蓋檔 "
       echo "                    選 N 會於檔名後加上主機與序號避免蓋檔 "
       read ANSWER?"                    請確認是否覆蓋(Y/N): "
       case $ANSWER in
       n|N)
            CHECK=2
            ;;
       y|Y)
            CHECK=1
            ;;
       *)
            echo "[Error]  輸入錯誤, 請輸入(Y/N)"
            read ANSWR?"               按Enter鍵繼續 "
            STARTN
            ;;
       esac

       if [ -z "$DIRPATH" ]; then
           echo ""
           echo "               [Error] 目錄輸入為空值 "
           CHKFLG=1
       fi

       if [ -z "$FILENAME" ]; then
           echo ""
           echo "               [Error]  檔名輸入為空值 "
           CHKFLG=1
       fi

       if [ "$CHKFLG" != "0" ]; then
           echo ""
           read ANSWR?"               按Enter鍵繼續 "
           main
       else
           echo ""
           echo "#===主機列表===#"
           echo "$HOSTLIST"
           echo "#==============#"
           echo "遠端檔案: $DIRPATH/$FILENAME"
           echo ""
           read ANSWER?"             請確認上述資訊是否正確(Y/N): "
           case $ANSWER in
           n|N)
                main
                ;;
           y|Y)
                for HOST in $HOSTLIST ; do
                   echo "$HOST 執行中..."
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
                echo "#  取得檔案主機結果清單:                #"
                echo "#  檔案存放位置 /home/download/file:    #"
                echo "#=======================================#"
                cat /tmp/$USER.$FILENAME.$timestamp
                rm /tmp/$USER.$FILENAME.$timestamp
                read ANSWR?"               按Enter鍵繼續 "
                main
                ;;
           *)
                echo "[Error]  輸入錯誤, 請輸入(Y/N)"
                read ANSWR?"               按Enter鍵繼續 "
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
       echo "                  (隨時可輸 q 以離開 ) "
       echo "#==========================================================#"
       echo "# 輸入格式(每台主機以空格做為分隔): DAP1-1 DAR1-1 LOG1 MDS1#"
       echo "#                                                          #"
       echo "# 群組輸入格式: DAP (一次一個群組)                         #"
       echo "#                                                          #"
       echo "# 全部主機請輸入: ALL                                      #"
       echo "#==========================================================#"
       read HOSTN?"輸入欲取目錄的遠端主機名稱 : "
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
           echo "               [Error]  輸入為空值 "
           echo ""
           read ANSWR?"               按Enter鍵繼續 "
           main
       fi

       echo ""
       read DIRPATH?"輸入目錄的路徑位置(絕對路徑) : "
       if [ "$DIRPATH" == "q" ] || [ "$DIRPATH" == "Q" ]; then
           main
       fi

       echo ""
       read FILENAME?"請輸入本地存檔名稱(檔名): "
       if [ "$FILENAME" == "q" ] || [ "$FILENAME" == "Q" ]; then
           main
       fi

       if [ -z "$DIRPATH" ]; then
           echo ""
           echo "               [Error] 目錄輸入為空值 "
           CHKFLG=1
       fi

       if [ -z "$FILENAME" ]; then
           echo ""
           echo "               [Error]  檔名輸入為空值 "
           CHKFLG=1
       fi

       if [ "$CHKFLG" != "0" ]; then
           echo ""
           read ANSWR?"               按Enter鍵繼續 "
           main
       else
           echo ""
           echo "#===主機列表===#"
           echo "$HOSTLIST"
           echo "#==============#"
           echo "遠端目錄: $DIRPATH"
           echo ""
           read ANSWER?"             請確認上述資訊是否正確(Y/N): "
           case $ANSWER in
           n|N)
                main
                ;;
           y|Y)
                for HOST in $HOSTLIST ; do
                   echo "$HOST 打包中..."
                   ssh -p 2222 $HOST "cd $DIRPATH; tar cf - ./* | gzip > /tmp/$FILENAME.$HOST.$timestamp.tar.gz"
                   execStatus1=$?
                   if [ $execStatus1 -eq 0 ]; then
                      echo "$HOST 打包 OK!" >> /tmp/$USER.$FILENAME.$timestamp
                   else
                      echo "$HOST 打包 Fail!" >> /tmp/$USER.$FILENAME.$timestamp
                   fi
                   echo "$HOST 下載中..."
                   scp -P 2222 $HOST:/tmp/$FILENAME.$HOST.$timestamp.tar.gz $BACKUPDIR/
                   execStatus2=$?
                   if [ $execStatus2 -eq 0 ]; then
                      echo "$HOST 下載 OK!" >> /tmp/$USER.$FILENAME.$timestamp
                   else
                      echo "$HOST 下載 Fail!" >> /tmp/$USER.$FILENAME.$timestamp
                   fi
                   ssh -p 2222 $HOST "cd /tmp; rm -f $FILENAME.$HOST.$timestamp.tar.gz"
                done
                echo ""
                echo "#========================================#"
                echo "#  取得目錄 主機結果清單:                #"
                echo "#  檔案存放位置  /home/download/dir:     #"
                echo "#========================================#"
                cat /tmp/$USER.$FILENAME.$timestamp
                rm /tmp/$USER.$FILENAME.$timestamp
                read ANSWR?"               按Enter鍵繼續 "
                main
                ;;
           *)
                echo "[Error]  輸入錯誤, 請輸入(Y/N)"
                read ANSWR?"               按Enter鍵繼續 "
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
       echo "                  (隨時可輸 q 以離開 ) "
       echo ""

       read USERLIST?" 輸入要解鎖的帳號名稱( 必須 ) : "
       if [ "$USERLIST" == "q" ] || [ "$USERLIST" == "Q" ]; then
           main
       fi

       if [ -z "$USERLIST" ]; then
           echo ""
           echo "               [Error]  輸入使用者名稱為空值 "
           CHKFLG=1
       fi

       if [ "$CHKFLG" != "0" ]; then
           echo ""
           read ANSWR?"               按Enter鍵繼續 "
           main
       else
           echo ""
           echo "欲解鎖的User Name: $USERLIST"
           read ANSWER?"             請確認上述資訊無誤(Y/N): "
           case $ANSWER in
           n|N)
               main
               ;;
           y|Y)
               for USERNAME in $USERLIST ; do
                  /home/se/safechk/safesh/usrlock_all.sh $USERNAME
               done
               read ANSWR?"               按Enter鍵繼續 "
               main
               ;;
           *)
               echo "[Error]  輸入錯誤, 請輸入(Y/N)"
               read ANSWR?"               按Enter鍵繼續 "
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
       echo "                  (隨時可輸 q 以離開 ) "
       echo ""

       read USERLIST?" 輸入使用者帳號名稱( 必須 ) : "
       if [ "$USERLIST" == "q" ] || [ "$USERLIST" == "Q" ]; then
           main
       fi

       if [ -z "$USERLIST" ]; then
           echo ""
           echo "               [Error]  輸入使用者名稱為空值 "
           CHKFLG=1
       fi

       if [ "$CHKFLG" != "0" ]; then
           echo ""
           read ANSWR?"               按Enter鍵繼續 "
           main
       else
           echo ""
           echo "欲產生SSH Key的使用者帳號: $USERLIST"
           read ANSWER?"             請確認上述資訊無誤(Y/N): "
           case $ANSWER in
           n|N)
               main
               ;;
           y|Y)
               for USERNAME in $USERLIST ; do
                  /home/se/safechk/safesh/sshkey_all.sh $USERNAME
               done
               read ANSWR?"               按Enter鍵繼續 "
               main
               ;;
           *)
               echo "[Error]  輸入錯誤, 請輸入(Y/N)"
               read ANSWR?"               按Enter鍵繼續 "
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
       echo "                  (隨時可輸 q 以離開 ) "
       echo ""
       echo "輸入格式(每台主機以空格做為分隔): DAP1-1 DAR1-1 LOG1 MDS1"
       read HOSTLIST?"輸入欲重傳的主機名稱 (未輸入預設為全部) : "
       if [ "$HOSTLIST" == "q" ] || [ "$HOSTLIST" == "Q" ]; then
           main
       fi

       if [ -z "$HOSTLIST" ]; then
           echo ""
           echo "               輸入為空值, 預設會代入全部的主機LPAR"
           echo ""
           read ANSWER?"               請確認是否繼續(Y/N): "
           case $ANSWER in
           n|N)
                main
                ;;
           y|Y)
                HOSTLIST=`cat /home/se/safechk/cfg/host.lst`
                ;;
           *)
                echo "[Error]  輸入錯誤, 請輸入(Y/N)"
                read ANSWR?"               按Enter鍵繼續 "
                STARTR
                ;;
           esac
       fi

       if [ "$CHKFLG" != "0" ]; then
           echo ""
           read ANSWR?"               按Enter鍵繼續 "
           main
       else
           echo ""
           echo "#===主機列表===#"
           echo "$HOSTLIST"
           echo "#==============#"
           echo ""
           read ANSWER?"             請確認上述資訊是否正確(Y/N): "
           case $ANSWER in
           n|N)
                main
                ;;
           y|Y)
			   $tlog "#============================================================= " $LOG
                for HOST in $HOSTLIST ; do
                   $tlog "${USER}@${HOST} 執行中..." $LOG
                   $tlog "ssh -p 2222 -f $HOST "$ACCOUNT" " $LOG
                   ssh -p 2222 -f $HOST "$ACCOUNT"
                   execStatus1=$?
                   if [ $execStatus1 -eq 0 ]; then
                      echo "$HOST OK!" >> /tmp/$USER.account.$timestamp
                   else
                      echo "$HOST Fail!" >> /tmp/$USER.account.$timestamp
                   fi

					#$tlog "${USER}@${HOST} 執行中..." $LOG
                   $tlog "ssh -p 2222 -f $HOST "$SYSCHK" " $LOG
                   ssh -p 2222 -f $HOST "$SYSCHK"
                   execStatus1=$?
                   if [ $execStatus1 -eq 0 ]; then
                      echo "$HOST OK!" >> /tmp/$USER.syschk.$timestamp
                   else
                      echo "$HOST Fail!" >> /tmp/$USER.syschk.$timestamp
                   fi

				   sleep 5

					#$tlog "${USER}@${HOST} 執行中..." $LOG
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
                echo "#  產生帳號Base檔主機結果清單:       #"
                echo "#====================================#"
                cat /tmp/$USER.account.$timestamp
                echo ""
                echo "#====================================#"
                echo "#  產生系統檢核Base檔主機結果清單:   #"
                echo "#====================================#"
                cat /tmp/$USER.syschk.$timestamp
                echo ""
                echo "#====================================#"
                echo "#  產生檔案異動Base檔主機結果清單:   #"
                echo "#====================================#"
                cat /tmp/$USER.fileaudit.$timestamp
                rm /tmp/$USER.syschk.$timestamp
                rm /tmp/$USER.account.$timestamp
                rm /tmp/$USER.fileaudit.$timestamp
                read ANSWR?"               按Enter鍵繼續 "
                main
                ;;
           *)
                echo "[Error]  輸入錯誤, 請輸入(Y/N)"
                read ANSWR?"               按Enter鍵繼續 "
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
       echo "                  (隨時可輸 q 以離開 ) "
       echo "#==========================================================#"
       echo "# 輸入格式(每台主機以空格做為分隔): DAP1-1 DAR1-1 LOG1 MDS1#"
       echo "#                                                          #"
       echo "# 群組輸入格式: DAP (一次一個群組)                         #"
       echo "#                                                          #"
       echo "# 全部主機請輸入: ALL                                      #"
       echo "#==========================================================#"
       read HOSTN?"輸入欲傳送的主機名稱 : "
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
          echo "               [Error]  輸入為空值 "
          echo ""
          read ANSWR?"               按Enter鍵繼續 "
          main
       fi

       read DIRPATH?"輸入目錄所在的目錄路徑位置(絕對路徑) : "
       if [ "$DIRPATH" == "q" ] || [ "$DIRPATH" == "Q" ]; then
           main
       fi

       if [ ! -d $DIRPATH ]; then
           echo ""
           echo "               [Error]  輸入的目錄不存在 "
           CHKFLG=1
       fi
       if [ -z "$DIRPATH" ]; then
           echo ""
           echo "               [Error]  輸入為空值 "
           CHKFLG=1
       fi

       if [ "$CHKFLG" != "0" ]; then
           echo ""
           read ANSWR?"               按Enter鍵繼續 "
           main
       else
           echo "Directory PATH: $DIRPATH"
           echo ""
           ls -ltr $DIRPATH
           read FILENAME?"             請輸入需要同步到其他台LPAR目錄名稱: "
           if [ -f $DIRPATH/$FILENAME ]; then
              echo ""
              echo "               [Error]  輸入的檔名為檔案 "
              read ANSWR?"               按Enter鍵繼續 "
              main
           fi
           if [ ! -d $DIRPATH/$FILENAME ]; then
              echo ""
              echo "               [Error]  輸入的目錄不存在 "
              read ANSWR?"               按Enter鍵繼續 "
              main
           fi

           echo ""
           echo "#===主機列表===#"
           echo "$HOSTLIST"
           echo "#==============#"
           echo "同步目錄: $DIRPATH/$FILENAME"
           echo ""
           read ANSWER?"             請確認上述資訊是否正確(Y/N): "
           case $ANSWER in
           n|N)
                main
                ;;
           y|Y)
                        read RDIRPATH?"           請輸入檔案要傳送到遠端主機的目錄(絕對路徑): "
			read ANSWER?"             請確認上述資訊是否正確(Y/N): "
           		case $ANSWER in
           		n|N)
                	STARTS
					;;
           		y|Y)
                	cd $DIRPATH ;tar cvf - $FILENAME | gzip > $DIRPATH/$FILENAME.tar.gz
                        for HOST in $HOSTLIST ; do
                           echo "$HOST 檔案備份中..."
                           ssh -p 2222 $HOST "mv $DIRPATH/$FILENAME $RDIRPATH/$FILENAME.$timestamp > /dev/null 2>&1"
                           echo "$HOST 檔案傳送中..."
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
                   echo "$HOST 結果檢查中..."
                   scp -P 2222 ${MUSER}@${HOST}:$HOMEDIR/scpdatafile.${HOST} /tmp/
                   ssh -p 2222 ${MUSER}@${HOST} "rm -f $HOMEDIR/scpdatafile.${HOST}"
                done

                errors=0
                echo
                echo "#==========================#"
                echo "#  同步檔案主機結果清單:   #"
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

                read ANSWR?"               按Enter鍵繼續 "
                main
                ;;
           *)
                echo "[Error]  輸入錯誤, 請輸入(Y/N)"
                read ANSWR?"               按Enter鍵繼續 "
                STARTS
                ;;
           esac
       fi
   fi
}
#}}}
###############################################################
main
