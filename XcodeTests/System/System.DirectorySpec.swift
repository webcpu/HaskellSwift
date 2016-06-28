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
        describe("Actions on directories") {
            it("createDirectory") {
                XCTAssertEqual(splitSearchPath("File1:File2:File3") , ["File1","File2","File3"])
                XCTAssertEqual(splitSearchPath("File1::File2:File3") , ["File1", ".", "File2","File3"])
            }
        }
    }
}
