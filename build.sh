#!/bin/bash
cd /Users/liang/Dropbox/Workspace/HaskellSwift
#while true
#do
if xcodebuild -project HaskellSwift.xcodeproj -scheme HaskellSwift build ; then
  xctool  -project HaskellSwift.xcodeproj -scheme HaskellSwift run-tests -parallelize
fi
#  sleep 10
#done
