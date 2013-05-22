#!/bin/ksh
Logfile=/home/se/safechk/safelog/menu.log
USER=$(whoami)
hostname=`hostname`


main () {
clear
echo "             << FIX/FAST 資訊傳輸系統使用者作業 (ALL AIX LPAR)>> "
echo ""
echo "           1. 同步修改密碼 "
echo ""
echo "           2. 共用工作區之檔案上傳至各LPAR(MDS/DAP/DAR/LOG) "
echo ""
echo "           3. 於共用工作區執行指令同步於各LPAR(MDS/DAP/DAR/LOG) "
echo ""
echo "           4. 各LPAR(MDS/DAP/DAR/LOG)中檔案下載至共用工作區 "
echo ""
echo "           5. 將LPAR(MDS/DAP/DAR/LOG)目錄下傳至共用工作區 "
echo ""
echo "               (隨時可輸 q 以離開 )"
echo ""
read Menu_No?"                請選擇選項 (1-5) : "

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
		echo "        [Error]  輸入錯誤, 請輸入 (1-5)的選項"
                read ANSWR?"               按Enter鍵繼續 "
                main
		;;
        esac
}
###############################################################
STARTA () {
   clear
   echo ""
   echo "#============================================#"
   echo "#  此功能會同步變更所有LPAR主機的使用者密碼  #"
   echo "#============================================#"
   echo ""
   echo "欲變更 ${USER} 的密碼?"
   echo ""
   read ANSWER?"               請確認要變更的User 無誤(Y/N): "
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
       echo "                  (隨時可輸 q 以離開 ) "
       echo "#==========================================================#"
       echo "# 輸入格式(每台主機以空格做為分隔): DAP1-1 DAR1-1 LOG1 MDS1#"
       echo "#                                                          #"
       echo "# 群組輸入格式: DAP (一次一個群組)                         #"
       echo "#                                                          #"
       echo "# 全部主機請輸入: ALL                                      #"
       echo "#==========================================================#"
       read HOSTN?"輸入欲傳送的主機名稱 : "
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
       echo "                  (隨時可輸 q 以離開 ) "
       echo "#==========================================================#"
       echo "# 輸入格式(每台主機以空格做為分隔): DAP1-1 DAR1-1 LOG1 MDS1#"
       echo "#                                                          #"
       echo "# 群組輸入格式: DAP (一次一個群組)                         #"
       echo "#                                                          #"
       echo "# 全部主機請輸入: ALL                                      #"
       echo "#==========================================================#"
       read HOSTN?"輸入欲執行指令的主機名稱 : "
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
                for HOST in $HOSTLIST ; do
                   echo "$HOST 執行中..."
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
       echo "                  (隨時可輸 q 以離開 ) "
       echo "#==========================================================#"
       echo "# 輸入格式(每台主機以空格做為分隔): DAP1-1 DAR1-1 LOG1 MDS1#"
       echo "#                                                          #"
       echo "# 群組輸入格式: DAP (一次一個群組)                         #"
       echo "#                                                          #"
       echo "# 全部主機請輸入: ALL                                      #"
       echo "#==========================================================#"
       read HOSTN?"輸入欲取檔案的遠端主機名稱 : "
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
            STARTD
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
       echo "                  (隨時可輸 q 以離開 ) "
       echo "#==========================================================#"
       echo "# 輸入格式(每台主機以空格做為分隔): DAP1-1 DAR1-1 LOG1 MDS1#"
       echo "#                                                          #"
       echo "# 群組輸入格式: DAP (一次一個群組)                         #"
       echo "#                                                          #"
       echo "# 全部主機請輸入: ALL                                      #"
       echo "#==========================================================#"
       read HOSTN?"輸入欲取目錄的遠端主機名稱 : "
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
                STARTE
                ;;
           esac
       fi
   fi
}
###############################################################

main
