#! /bin/bash
USAGE="usage: $0 <fill in correct usage>" 
echo "544146"

compare() {
    if [[ ! $1 == $(echo "$info" | grep "fn-$2:::" | awk -vplace="$3" '{split($0,a,":::"); print a[place]}') ]]; then
        echo "$2 $4 has changed from $(echo "$info" | grep "fn-$2:::" | awk -vplace="$3" '{split($0,a,":::"); print a[place]}') to $1"
    fi
}

checkfordeletion() {
    while read -r line; do
        if [[ ! -f $(echo "$line" | awk '{split($0,a,":::"); print a[1]}' | cut -d "-" -f2) ]]; then
            echo "File $(echo "$line" | awk '{split($0,a,":::"); print a[1]}' | cut -d "-" -f2) no longer exists in directory."
        fi
    done <<< "$info"
}

processnew() {
    for file in *; do
        if [ -f "$file" ] && [ "$file" != ".*" ]; then
            extension=${file##*.}
            filename=`basename $file $ext`
            if [[ $info == *"fn-$filename:::"* ]]; then
                filesize=$(stat -c '%s' $file)
                compare "$filesize" "$filename" 2 "file size"
                filetype=$(file -b $file)
                compare "$filetype" "$filename" 3 "file type"
                filemd5="error"
                filerd="false"
                if [ -r $file ]; then
                    filemd5=$(md5sum $file | cut -d " " -f1)
                    compare "$filemd5" "$filename" 4 "md5"
                    filerd="true"
                fi
                compare "$filerd" "$filename" 5 "readability"
                filewr="false"
                if [ -w $file ]; then
                    filewr="true"
                fi
                compare "$filewr" "$filename" 6 "writeability"
                fileex="false"
                if [ -x $file ]; then
                    fileex="true"
                fi
                compare "$fileex" "$filename" 7 "executability"
            else
                echo "New file named $filename"
            fi
        fi
    done;
}

setinfo() {
    infostring=
    for file in *; do
        if [ -f "$file" ] && [ "$file" != ".*" ]; then
            extension=${file##*.}
            filename=`basename $file $ext`
            filesize=$(stat -c '%s' $file)
            filetype=$(file -b $file)
            filemd5="error"
            filerd="false"
            if [ -r $file ]; then
                filemd5=$(md5sum $file | cut -d " " -f1)
                filerd="true"
            fi
            filewr="false"
            if [ -w $file ]; then
                filewr="true"
            fi
            fileex="false"
            if [[ -x $file ]]; then
                fileex="true"
            fi
	    infostring+="fn-$filename:::$filesize:::$filetype:::$filemd5:::$filerd:::$filewr:::$fileex"
            infostring+=$'\n'
        fi
    done;
    echo "$infostring"
}

info=$(setinfo)
while true
do 
    processnew
    checkfordeletion
    info=$(setinfo)
    sleep 15;
done

