#!/usr/bin/expect

if { $argc != 3 } {
    puts "Usage:"
    puts "$argv0 username adminUser adminUserpwd"
    exit
}

#set machine  [lindex $argv 0]
set username [lindex $argv 0]
set adminname   [lindex $argv 1]
set adminpwd   [lindex $argv 2]
set completed_list " "
set machine_list [exec cat /home/se/safechk/cfg/host.lst]
#-----------------------------------------
# All machines where set password on
#-----------------------------------------
#set machine_list {
#   dev1
#   dap1-1
#   dar1-1
#   log1
#   mds1
#}

#----------------------------------------------------
# Ping machines to see which ones are available
#   ok machines in run_list
#----------------------------------------------------
foreach machine $machine_list {
    if { [ catch { exec ping -c 1 $machine  } ] == 0 } {
        lappend run_list $machine
    }
}



foreach machine $run_list { 
    set change 0
    spawn ssh -p 2222 -o StrictHostKeyChecking=no $adminname@$machine
    while {1} {
        expect  { 
            timeout         break
            "\rlogin:"        { 
                              send "${adminname}\r" }
            "New password"  { send "${newpwd}\r" 
                              set change 1 }
            "new password"  { send "${newpwd}\r" 
                             set change 1 }
            "Old password:" { send "${oldpwd}\r" }
            "Password:"     { send "${adminpwd}\r" }
            "\\\#"            { if {$change == 0} { 
                                  send "chsec -f /etc/security/lastlog -a unsuccessful_login_count=0 -s ${username}\r"
                                  send "chuser account_locked=false ${username}\r"
                                  send "pwdadm -c ${username}\r"
                                  lappend completed_list $machine
                                  set change 1 
                              } else {
                                  send "exit\r" }
                            }
            "changed"       { send "exit\r" }
            "Permission denied," { break }
            "refused"        { break }
            "closed"        { break }
        }
        #sleep 1
    }
}
    
puts "#====================================#"
puts "#  登入失敗紀錄Reset完成之主機清單:  #"
puts "#====================================#"
foreach machine $completed_list {
    puts $machine
}

puts " "
puts "#====================================#"
puts "#  登入失敗紀錄Reset失敗之主機清單:  #"
puts "#====================================#"
foreach machine $machine_list {
    if { [ lsearch $completed_list $machine ] < 0 } {
        puts $machine
    }
}
puts " "

exit
