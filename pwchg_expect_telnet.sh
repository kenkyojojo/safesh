#!/usr/bin/expect

if { $argc != 3 } {
    puts "Usage:"
    puts "$argv0 username oldpwd newpwd"
    exit
}

#set machine  [lindex $argv 0]
set username [lindex $argv 0]
set oldpwd   [lindex $argv 1]
set newpwd   [lindex $argv 2]
set completed_list " "
set machine_list [exec cat /home/se/safechk/cfg/host.lst]
#-----------------------------------------
# All machines where set password on
#-----------------------------------------
#set machine_list {
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
    spawn telnet $machine
    while {1} {
        expect  { 
            timeout         break
            "\rlogin:"        { 
                              send "${username}\r" }
            "New password"  { send "${newpwd}\r" 
                              lappend completed_list $machine
                              set change 1 }
            "new password"  { send "${newpwd}\r" 
                             set change 1 }
            "Old password:" { send "${oldpwd}\r" }
            "Password:"     { send "${oldpwd}\r" }
            "\\\#"            { if {$change == 0} { 
                                  send "passwd\r" 
                                  set change 1 
                              } else {
                                  send "exit\r" }
                            }
            "changed"       { send "exit\r" }
            "Permission denied," { break }
            "closed"        { break }
        }
        #sleep 1
    }
}
    
puts " "
puts "Password changed on following machines:"
foreach machine $completed_list {
    puts $machine
}

puts " "
puts "Password NOT changed on following machines:"
foreach machine $machine_list {
    if { [ lsearch $completed_list $machine ] < 0 } {
        puts $machine
    }
}
puts " "
exit
