#!/bin/zsh
dir=/Users/liang/Dropbox/Workspace/HaskellSwift # | while read -d "" event \
fswatch -0 $dir | while read -d "" event
do
  echo "$event"
  if [[ $event == *.swift ]]
  then
    echo "Building"
    cd ${dir}; ./Utilities/build.sh
  fi
done
