#!/bin/bash
cd /Users/liang/Dropbox/Workspace/HaskellSwift
#while true
#do
  xcodebuild -project HaskellSwift.xcodeproj -scheme HaskellSwift build
  xctool  -project HaskellSwift.xcodeproj -scheme HaskellSwift run-tests -parallelize
#  sleep 10
#done
