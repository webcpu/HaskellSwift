#!/bin/bash
cd /Users/liang/Projects/HaskellSwift
while true
do
  xcodebuild  -project HaskellSwift.xcodeproj -scheme HaskellSwiftTests test 
  sleep 10
done
