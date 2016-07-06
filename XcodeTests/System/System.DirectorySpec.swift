//
//  System.DirectorySpec.swift
//  HaskellSwift
//
//  Created by Liang on 28/06/2016.
//  Copyright © 2016 Liang. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import HaskellSwift

class SystemDirectorySpec: QuickSpec {
    override func spec() {
        //"Actions on directories"
        describe("createDirectory") {
            let create = { (dir: String) in
                expect(fileExists(dir)) == false
                let success   = createDirectory(dir)
                expect(success) == true
                expect(fileExists(dir)) == true
                _ = removeFile(dir)
            }

            it("withoutIntermediateDirectories") {
                let dir = NSTemporaryDirectory() + "/strange"
                create(dir)
            }
            
            it("withIntermediateDirectories") {
                let dir = NSTemporaryDirectory() + "/not/exist"
                create(dir)
            }
        }
    }
}
