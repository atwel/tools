#!/bin/sh
# A script that lets you start up python scripts on the CSCS lab machines with a single entry of your password 
# (because apparently the sshkey security is too high). It takes four arguments, the path to the folder where the script is, the name of the remove script you want
# to run, your lab username, and your password.  Passing the password in as an argument seems safer than storing 
# it here is this file, but you should remember to clear your terminal after you run this script.

# It will run the same script on each computer/node. If you want to distribute different parameters to different machine,
# use os.uname[1] to identify the node calling it and create a stack of if-then statements



# basic run command:  bash cscs_run.sh *location* *test.py* *username* *password*


# -*- tcl -*-
# The next line is executed by /bin/sh, but not tcl \
exec tclsh "$0" ${1+"$@"}
# we're now running in tclsh


package require Expect

# when we started tclsh, we passed the command line arguments through
# now we unpackage them to $1 $2 $3 $4
set i 0; foreach n $argv {set [incr i] $n}

# NOTA BENE: You need to have previously logged into (ssh) each of the machines from the node you run this from.
set computers [list "draga" "lupa" "sciame" "cscs-lab01" "cscs-lab03" "cscs-lab04" "cscs-lab05" "cscs-lab06" "cscs-lab07" "cscs-lab08" "cscs-lab10" "cscs-lab12" "cscs-lab13" "cscs-lab14" "cscs-lab15" "cscs-lab16" "cscs-lab17" "cscs-lab18" "cscs-lab19" ]

foreach node $computers {
	spawn ssh $3@$node.cscs.lsa.umich.edu
	expect "assword:"
	send "$4\r"
	send "cd $1\r"
	send "nohup python $2 &\r"
	send "exit\r"
	expect eof
}
