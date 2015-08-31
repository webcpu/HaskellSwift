//
//  Data.MaybeSpec.swift
//  HaskellSwift
//
//  Created by Liang on 31/08/2015.
//  Copyright © 2015 Liang. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import HaskellSwift

class DataMaybeSpec: QuickSpec {
    override func spec() {
        describe("maybe") {
            it("Function") {
                let _lookup = {x in lookup(x, ["a":1, "b":2])}
                let r0      = maybe(5, negate, _lookup("c"))
                expect(r0).to(equal(5))
                
                let r1      = maybe(5, negate, _lookup("a"))
                expect(r1).to(equal(-1))
            }
        }
    }
}
