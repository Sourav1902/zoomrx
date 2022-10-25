#!/bin/bash
log_directory=$1
rotate_by_size=$2
rotate_by_time=$3

if [ -d "$1" ]; then
if [ "$rotate_by_size" = "size" ];then
  find $log_directory -type f ! \( -name "*.gz" -o -name ".*" \) -size +5M  -exec bash -c 'gzip --suffix $(date +".%m-%d-%Y-%H:%M:%S.gz") {}' \;
else
  echo "No files are zipped as second argument passed to script is not "size""
fi
if [ "$rotate_by_time" = "time" ];then
  find $log_directory -type f ! \( -name "*.gz" -o -name ".*" \) -mtime +1  -exec bash -c 'gzip --suffix $(date +".%m-%d-%Y-%H:%M:%S.gz") {}' \;
else
  echo "No files are zipped as third argument passed to script is not "time""
fi
else
  echo "Please provide correct directory path"
fi
