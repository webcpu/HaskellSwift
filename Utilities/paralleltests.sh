#!/bin/bash
#xctool  -project HaskellSwift.xcodeproj -scheme HaskellSwift run-tests -parallelize &
#xctool  -project HaskellSwift.xcodeproj -scheme HaskellSwiftTests run-tests -parallelize &
#xctool  -project HaskellSwift.xcodeproj -scheme HaskellSwift -jobs 12 test -only HaskellSwiftTests:DataListSpec &
#xctool  -project HaskellSwift.xcodeproj -scheme HaskellSwift -jobs 12 test -omit HaskellSwiftTests:PlaySpec -parallelize & #-omit HaskellSwiftTests:DataListQuickCheck

#xctool  -project HaskellSwift.xcodeproj -scheme HaskellSwiftSpecTests run-tests -parallelize &
#xctool  -project HaskellSwift.xcodeproj -scheme HaskellSwiftQuickCheckTests test only HaskellSwiftTests:DataListListTransformation0QuickCheck -parallelize &
#xctool  -project HaskellSwift.xcodeproj -scheme HaskellSwiftQuickCheckTests test only HaskellSwiftTests:DataListListTransformation1QuickCheck -parallelize &
#xctool  -project HaskellSwift.xcodeproj -scheme HaskellSwiftQuickCheckTests test only HaskellSwiftTests:DataListBasic0QuickCheck -parallelize &
#xctool  -project HaskellSwift.xcodeproj -scheme HaskellSwiftQuickCheckTests test only HaskellSwiftTests:DataListBasic1QuickCheck -parallelize &

xctool  -project HaskellSwift.xcodeproj -scheme HaskellSwift-OSXTests test -parallelize -logicTestBucketSize 32 &
#xctool  -project HaskellSwift.xcodeproj -scheme HaskellSwift run-tests -parallelize &
#xctool  -project HaskellSwift.xcodeproj -scheme HaskellSwift run-tests -parallelize &
#xctool  -project HaskellSwift.xcodeproj -scheme HaskellSwift run-tests -parallelize &
#xctool  -project HaskellSwift.xcodeproj -scheme HaskellSwift run-tests -parallelize &
#xctool  -project HaskellSwift.xcodeproj -scheme HaskellSwift run-tests -parallelize &
#xctool  -project HaskellSwift.xcodeproj -scheme HaskellSwift run-tests -parallelize &
#xctool  -project HaskellSwift.xcodeproj -scheme HaskellSwift run-tests -parallelize &
#xctool  -project HaskellSwift.xcodeproj -scheme HaskellSwift run-tests -parallelize &
#xctool  -project HaskellSwift.xcodeproj -scheme HaskellSwift run-tests -parallelize &
wait
