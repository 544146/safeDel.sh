#! /bin/bash
USAGE="usage: $0 <fill in correct usage>" 

trap 'echo ""; echo There are currently $(ls -1p "$HOME/.trashCan" | grep -v / | wc -l) files in .trashCan; exit 0' SIGINT

echo "544146"

optpassed=false

mkdir -p "$HOME/.trashCan"

checkempty() {
    [ -z "$(ls -A "$HOME/.trashCan")" ]
}

totalsize() {
    ls -lsp "$HOME/.trashCan" | grep -v / | awk '{ total += $6 }; END { print total }'
}

listfiles() {
    if checkempty; then 
        echo "/.trashCan is empty." 1>&2
    else 
        for file in $HOME/.trashCan/*; do
            extension=${file##*.}
            filename=`basename $file $ext`
            filesize=$(stat -c '%s' $file)
            filetype=$(file -b $file)
	    echo "$filename, $filesize, $filetype"
        done;
    fi
}

recoverfile() {
    if [ ! -f "$HOME/.trashCan/$OPTARG" ]; then
        echo "File not found!" 1>&2
    else 
        mv "$HOME/.trashCan/$OPTARG" .
        echo "File $OPTARG recovered."
    fi
}

recoverfile_menu() {
    if checkempty; then 
        echo "/.trashCan is empty." 1>&2
    else 
        for file in $HOME/.trashCan/*; do
            extension=${file##*.}
            filename=`basename $file $ext`
	    read -p "Recover file "$filename" (y/*)?: " choice
            case "$choice" in 
                y|Y ) mv "$file" .
                    echo "Recovered file "$filename"";;
                * ) continue;;
          esac
        done
    fi
}

deletefile() {
    if checkempty; then 
        echo "/.trashCan is empty." 1>&2
    else 
        for file in $HOME/.trashCan/*; do
            extension=${file##*.}
            filename=`basename $file $ext`
	    read -p "Delete file "$filename" (y/*)?: " choice
            case "$choice" in 
                y|Y ) rm "$file"
                    echo "Deleted file "$filename"";;
                * ) continue;;
            esac
        done
    fi
}

launch_monitor() {
    if [ -f monitor.sh ]; then
        if [ -x monitor.sh ]; then
            x-terminal-emulator -e ./monitor.sh&
        else
            echo "File monitor.sh is not executable." 1>&2
        fi
    else
        echo "File monitor.sh does not exist." 1>&2
    fi
}

kill_monitor() {
    kill $(ps -aux | grep "/bin/bash ./monitor.sh" | awk '{print $2}') &>/dev/null
}

if [ $(totalsize) -ge 1025 ]; then
    echo "Warning, your /.trashCan exceeds 1Kbytes." 1>&2
fi

while getopts :lr:dtwk args #options
do
  case $args in
     l) listfiles
        optpassed=true;;
     r) recoverfile
        optpassed=true;;
     d) deletefile
        optpassed=true;;
     t) totalsize
        optpassed=true;;
     w) launch_monitor
        optpassed=true;; 
     k) kill_monitor
        optpassed=true;;   
     :) echo "data missing, option -$OPTARG";;
    \?) echo "$USAGE";;
  esac
done

((pos = OPTIND - 1))
shift $pos

PS3='option> '

if (( $# == 0 ))
then if (( $OPTIND == 1 )) 
 then select menu_list in list recover delete total watch kill exit
      do case $menu_list in
         "list") listfiles;;
         "recover") recoverfile_menu;;
         "delete") deletefile;;
         "total") totalsize;;
         "watch") launch_monitor;;
         "kill") kill_monitor;;
         "exit") exit 0;;
         *) echo "unknown option" 1>&2;;
         esac
      done
 fi
else
    if ! "$optpassed"; then
        for i in "$@"; do
            if [ -f "$i" ]; then
                mv "$i" "$HOME/.trashCan/$OPTARG"
                echo "$i has been moved to .trashCan"
            else
                echo "$i is not a file." 1>&2
            fi
        done
    else
        echo "extra args??: $@"
    fi
fi



