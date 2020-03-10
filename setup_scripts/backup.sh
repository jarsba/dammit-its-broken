#!/usr/bin/env bash

# Inspiration https://askubuntu.com/a/1029653/977219

source_dir=/home/jarsba
target_dir=/media/jarsba/my_passport/backups_from_script
mkdir -p $target_dir

# current backup directory, e.g. "2017-04-29T13:04:50";
now=$(date +%FT%H:%M:%S)

# previous backup directory
prev=$(ls $target_dir | grep -e '^....-..-..T..:..:..$' | tail -1);

if [ -z "$prev" ]; then
    # initial backup
    rsync -av --delete $source_dir $target_dir/$now/
else
    # incremental backup
    rsync -av --delete --link-dest=$target_dir/$prev/ $source_dir $target_dir/$now/
fi

exit 0;

