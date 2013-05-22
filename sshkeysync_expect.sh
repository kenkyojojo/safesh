#!/usr/bin/expect

if { $argc != 3 } {
    puts "Usage:"
    puts "$argv0 username password sshdir"
    exit
}

set username [lindex $argv 0]
set oldpwd [lindex $argv 1]
set homedir [lindex $argv 2]
set completed_list " "
set localhost [exec hostname]
set machine_list [exec cat /home/se/safechk/cfg/host.lst | grep -v $localhost]

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
    spawn scp -P 2222 ${homedir}/id_rsa.pub ${username}@${machine}:/${homedir}/authorized_keys
    expect {
            timeout         break
            "password:" {send "$oldpwd\r" 
                         lappend completed_list $machine
                         exp_continue }
            "Permission denied" { break }
            "refused"        { break }
            "closed"        { break }
    }
}
    
puts "#===============================#"
puts "#  SSH Key 部署完成之主機清單:  #"
puts "#===============================#"
foreach machine $completed_list {
    puts $machine
}

puts " "
puts "#===============================#"
puts "#  SSH Key 部署失敗之主機清單:  #"
puts "#===============================#"
foreach machine $machine_list {
    if { [ lsearch $completed_list $machine ] < 0 } {
        puts $machine
    }
}
puts " "
puts "#===============================#"

exit
