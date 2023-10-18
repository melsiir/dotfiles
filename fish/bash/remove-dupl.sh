#!/bin/bash

files_dir=$1
if [[ -z "$files_dir" ]]; then
    echo "Error: files dir is undefined"
    exit;
fi

find $files_dir -type f -exec openssl sha1 \{\} \; > list.txt


count=-1
total=0
for l in `cat list.txt | sed 's/SHA1(\(.*\))\= \(.*\)$/\2 \1/' | awk '{print $1}' | sort | uniq -c | sort -nr`
do
    if [[ $count == -1 ]]
    then
        count=$l
    else 
        hash=$l
        if [[ $count == 1 ]]
        then
            break
        fi
        for f in `grep $hash list.txt | sed 's/SHA1(\(.*\))\= \(.*\)$/\2 \1/' | awk '{print $2}'`
        do
            if [[ $count > 1 ]]
            then
                # echo "removing: $f"
                rm $f
                count=$((count-1))
            fi
        done
        total=`expr $total + $count`
        count=-1
    fi
done

echo "Deleted $total files"
echo

