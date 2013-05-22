#!/usr/bin/expect

if { $argc != 4 } {
    puts "Usage:"
    puts "$argv0 username password sshdir wlpar"
    exit
}

set username [lindex $argv 0]
set oldpwd [lindex $argv 1]
set homedir [lindex $argv 2]
set wlpar [lindex $argv 3]
set completed_keylist " "
set completed_dowlist " "
set machine_list [exec cat /home/se/safechk/cfg/host.lst]
set timeout 20
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
    #spawn ssh -o StrictHostKeyChecking=no $username@$machine
    spawn ssh -p 2222 $username@$machine
    while {1} {
        expect  { 
            timeout         break
            "\rlogin:"        { 
                              send "${usernname}\r" }
            "New password"  { send "${newpwd}\r" 
                              set change 1 }
            "new password"  { send "${newpwd}\r" 
                             set change 1 }
            "Old password:" { send "${oldpwd}\r" }
            "password:"     { send "${oldpwd}\r" }
            "\\\#"            { if {$change == 0} { 
                                  send "ssh-keygen -t rsa\r"
                                  lappend completed_keylist $machine
                                  set change 1 
                              } else {
                                  send "exit\r" }
                            }
            "changed"       { send "exit\r" }
            "(yes/no)?"       { send "yes\r" }
            "id_rsa):"       { send "\r" }
            "passphrase):"       { send "\r" }
            "passphrase again:"       { send "\r" }
            "Overwrite (y/n)?"       { send "y\r" }
            "Permission denied," { break }
            "refused"        { break }
            "closed"        { break }
        }
        #sleep 1
    }
}
    
foreach machine $run_list { 
    set change 0
    spawn ssh -p 2222 -o StrictHostKeyChecking=no $username@$machine
    while {1} {
        expect  { 
            timeout         break
            "\rlogin:"        { 
                              send "${usernname}\r" }
            "New password"  { send "${newpwd}\r" 
                              lappend completed_dowlist $machine
                              set change 1 }
            "new password"  { send "${newpwd}\r" 
                             set change 1 }
            "Old password:" { send "${oldpwd}\r" }
            "password:"     { send "${oldpwd}\r" }
            "\\\#"            { if {$change == 0} { 
                                  send "scp -P 2222 ${homedir}/id_rsa.pub ${wlpar}:${homedir}/id_rsa.pub.${machine}.${username} \r"
                                  lappend completed_dowlist $machine
                                  set change 1 
                              } else {
                                  send "exit\r" }
                            }
            "changed"       { send "exit\r" }
            "(yes/no)?"       { send "yes\r" }
            "Permission denied," { break }
            "refused"        { break }
            "closed"        { break }
        }
        #sleep 1
    }
}
    
puts "#===============================#"
puts "#  SSH Key 產生完成之主機清單:  #"
puts "#===============================#"
foreach machine $completed_keylist {
    puts $machine
}

puts " "
puts "#===============================#"
puts "#  SSH Key 產生失敗之主機清單:  #"
puts "#===============================#"
foreach machine $machine_list {
    if { [ lsearch $completed_keylist $machine ] < 0 } {
        puts $machine
    }
}
puts " "
puts "#===============================#"
puts "#  SSH Key 下載完成之主機清單:  #"
puts "#===============================#"
foreach machine $completed_dowlist {
    puts $machine
}

puts " "
puts "#===============================#"
puts "#  SSH Key 下載失敗之主機清單:  #"
puts "#===============================#"
foreach machine $machine_list {
    if { [ lsearch $completed_dowlist $machine ] < 0 } {
        puts $machine
    }
}
puts " "
puts "#===============================#"

exit
