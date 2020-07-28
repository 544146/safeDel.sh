.\" Process this file with
.\" groff -man -Tascii foo.1
.\"
.TH safeDel 1 "NOVEMBER 2018" Linux "User Manuals"
.SH NAME
safeDel.sh \- Safely delete files for future recoverability
.SH SYNOPSIS
.B safeDel [-option] [arguments] 
or
.B safeDel [files] 
.SH DESCRIPTION
.B safeDel.sh
takes file names as arguments and moves them 
to a new folder created named .trashCan.
There are also command line options you can call
to gain access to further functionality of the
safeDel.sh script. Calling the script with no 
options or arguments will prompt a menu which
you can easily use to interface with the script.
.SH OPTIONS
.IP -l
Lists all files in the .trashCan folder.
.IP -r
Recovers a file from the .trashCan folder
and places it in safeDel.sh's working directory
.IP -d
Lets you interactively delete the contents
of the .trashCan folder permanently.
.IP -t
Displays the total file size of the .trashCan
folder in bytes.
.IP -w
Launches a new terminal running the monitor.sh
script, this will monitor any changes, creation
or deletion of files in safeDel.sh's working
directory.
.IP -k
Kills all terminal windows running monitor.sh
.SH FILES
.I /monitor.sh
.RS
The monitor.sh script, monitors safeDel.sh's 
working directory for any file creation, modification
or deletion.
.RE
.SH ENVIRONMENT
.IP "FILE1 FILE2 FILE3 etc."
Without using any options if you pass 
arguments they will be interpreted as file
names and will be moved to the .trashCan 
folder, if the argument file doesn't exist
an error will be issues.
.RE
.IP FILETORECOVER
When using the -r option an additionl environment
argument will need to be passed containing the name
of a file that exists in the same directory as
safeDel.sh
.SH DIAGNOSTICS
The following diagnostics may be issued on stderr:
 
/.trashCan is empty.
.RS
There are no files in the .trashCan folder
.RE
File not found!
.RS
An incorrect file name was entered, and not
found by a function.
.RE
File monitor.sh is not executable.
.RS
The monitor.sh script is not executable, 
to make executable run chmod +x monitor.sh
.RE
File monitor.sh does not exist.
.RS
The monitor.sh script doesn't exist
.RE
Warning, your /.trashCan exceeds 1Kbytes.
.RS
A formal warning that the .trashCan folder
exceeds 1024 bytes.
.RE
unknown option
.RS
An unknown option was entered
.SH BUGS
No known bugs.
.SH AUTHOR
544146
