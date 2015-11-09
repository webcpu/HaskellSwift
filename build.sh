#!/bin/bash
cd /Users/liang/Dropbox/Workspace/HaskellSwift
if xcodebuild -project HaskellSwift.xcodeproj -scheme HaskellSwift build ; then
  #xctool  -project HaskellSwift.xcodeproj -scheme HaskellSwift run-tests -parallelize -logicTestBucketSize 32
  ./paralleltests.sh
fi
