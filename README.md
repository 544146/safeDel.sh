### safeDel(1) - User Manual

NAME

       safeDel.sh - Safely delete files for future recoverability

SYNOPSIS

       safeDel [-option] [arguments]

       safeDel [files]

DESCRIPTION

       safeDel.sh  takes file names as arguments and moves them to a new folder created named
       .trashCan.  There are also command line options you can call to gain access to further
       functionality  of  the  safeDel.sh script. Calling the script with no options or argu‐
       ments will prompt a menu which you can easily use to interface with the script.

OPTIONS

       -l     Lists all files in the .trashCan folder.

       -r     Recovers a file from the .trashCan folder and places it in safeDel.sh's working
              directory

       -d     Lets you interactively delete the contents of the .trashCan folder permanently.

       -t     Displays the total file size of the .trashCan folder in bytes.

       -w     Launches  a  new  terminal running the monitor.sh script, this will monitor any
              changes, creation or deletion of files in safeDel.sh's working directory.

       -k     Kills all terminal windows running monitor.sh

FILES

       /monitor.sh
              The monitor.sh script, monitors safeDel.sh's working  directory  for  any  file
              creation, modification or deletion.

ENVIRONMENT

       FILE1 FILE2 FILE3 etc.
              Without  using  any  options  if you pass arguments they will be interpreted as
              file names and will be moved to the .trashCan  folder,  if  the  argument  file
              doesn't exist an error will be issues.

       FILETORECOVER
              When  using  the  -r  option  an additionl environment argument will need to be
              passed containing the name of a file that  exists  in  the  same  directory  as
              safeDel.sh

DIAGNOSTICS

       The following diagnostics may be issued on stderr:

       /.trashCan is empty.
              There are no files in the .trashCan folder
       File not found!
              An incorrect file name was entered, and not found by a function.
       File monitor.sh is not executable.
              The  monitor.sh script is not executable, to make executable run chmod +x moni‐
              tor.sh
       File monitor.sh does not exist.
              The monitor.sh script doesn't exist
       Warning, your /.trashCan exceeds 1Kbytes.
              A formal warning that the .trashCan folder exceeds 1024 bytes.
       unknown option
              An unknown option was entered

BUGS

       No known bugs.

AUTHOR

       544146

##### Linux - NOVEMBER 2018

---

### monitor(1) - User Manual

NAME

       monitor.sh - Monitor working directory of safeDel.sh

SYNOPSIS

       monitor.sh

DESCRIPTION

       monitor.sh  Monitors  deletion  and  creation of files in the directory of safeDel.sh,
       also monitors and modification of existing files, will notify of any  creation,  dele‐
       tion or changing.

OPTIONS

       monitor.sh has no options

FILES

       /safeDel.sh
              The  safeDel.sh  script,  monitor.sh  is ran from this script and it created to
              work with it.

ENVIRONMENT

       No environment variables should be passed to monitor.sh

DIAGNOSTICS

       monitor.sh does not print any error messages, only messages  regarding  files  in  the
       working directory of safeDel.sh

BUGS

       No known bugs.

AUTHOR

       544146
    
##### Linux - NOVEMBER 2018
