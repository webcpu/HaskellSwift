#!/bin/bash
universalbuild -p HaskellSwift.xcodeproj -s HaskellSwift-iOS -c Debug
universalbuild -p HaskellSwift.xcodeproj -s HaskellSwift-macOS -c Debug
universalbuild -p HaskellSwift.xcodeproj -s HaskellSwift-tvOS -c Debug
