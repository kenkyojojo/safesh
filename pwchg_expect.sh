#!/usr/bin/expect

if { $argc != 3 } {
    puts "Usage:"
    puts "$argv0 username oldpwd newpwd"
    exit
}

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
#   dev1
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


proc exclude_list {} {
    set count 0
    global machine_list run_list
    foreach machine $machine_list {
        incr count
        if { [ lsearch $run_list $machine ] < 0 } {
            puts "\t$count)\t$machine"
        }
    }    
    puts ""
}

proc include_list {} {
    puts "Will now try to change password on following machines:"
    set count 0
    global machine_list run_list
    foreach machine $run_list {
        incr count
            puts "\t$count)\t$machine"
    }
    puts ""
}

proc continue_chk {} {
    global run_list
    while {1} {
        include_list
        puts -nonewline "\nDo you want to continue or (m)odify list? (y/n/m): "
        gets stdin ans 
        if { 1 == [regexp {^y|Y$} $ans]  } {
            puts "yes"
            break
        } elseif { 1 == [regexp {^m|M$} $ans]  } {
            puts -nonewline "\n Enter number to remove: "
            gets stdin ans 
            set r_num [expr {$ans - 1}]
            puts $run_list
            set run_list [ lreplace $run_list $r_num $r_num ] 
        } else {
            puts "no"
            exit
        }
    }
}
    
puts "Failed to ping following machines:"
exclude_list

#puts "Will now try to change password on following machines:"
#include_list

#continue_chk

foreach machine $run_list { 
    set change 0
    #spawn telnet $machine
    spawn ssh -p 2222 -o StrictHostKeyChecking=no $username@$machine
    while {1} {
        expect  { 
            timeout         break
            "\rlogin:"        { sleep 1
                              send "${username}\r" }
            "New password"  { send "${newpwd}\r" 
                              set change 1 }
            "new password"  { send "${newpwd}\r" 
                              lappend completed_list $machine
                              set change 1 }
            "Old password:" { send "${oldpwd}\r" }
            "password:"     { send "${oldpwd}\r" }
            "\\\#"            { if {$change == 0} { 
                                  send "passwd\r" 
                                  set change 1 
                              } else {
                                  send "exit\r" }
                            }
            "changed"       { send "exit\r" }
            "Permission denied," { break }
            "reuse." { break }
            "refused"        { break }
            "closed"        { break }
        }
        #sleep 1
    }
}
    
puts "#===========================#"
puts "#  密碼變更完成之主機清單:  #"
puts "#===========================#"
foreach machine $completed_list {
    puts $machine
}

puts " "
puts "#===========================#"
puts "#  密碼變更失敗之主機清單:  #"
puts "#===========================#"
foreach machine $machine_list {
    if { [ lsearch $completed_list $machine ] < 0 } {
        puts $machine
    }
}
puts " "

exit
