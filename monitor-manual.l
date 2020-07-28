.\" Process this file with
.\" groff -man -Tascii foo.1
.\"
.TH monitor 1 "NOVEMBER 2018" Linux "User Manuals"
.SH NAME
monitor.sh \- Monitor working directory of safeDel.sh
.SH SYNOPSIS
.B monitor.sh
.SH DESCRIPTION
.B monitor.sh
Monitors deletion and creation of files
in the directory of safeDel.sh, also
monitors and modification of 
existing files, will notify of any
creation, deletion or changing.
.SH OPTIONS
monitor.sh has no options
.SH FILES
.I /safeDel.sh
.RS
The safeDel.sh script, monitor.sh is ran from
this script and it created to work with it.
.RE
.SH ENVIRONMENT
No environment variables should be passed to monitor.sh
.SH DIAGNOSTICS
monitor.sh does not print any error messages, only 
messages regarding files in the working directory
of safeDel.sh
 
.SH BUGS
No known bugs.
.SH AUTHOR
544146

