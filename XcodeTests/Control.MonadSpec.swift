//
//  Control.MonadSpec.swift
//  HaskellSwift
//
//  Created by Liang on 24/09/2015.
//  Copyright © 2015 Liang. All rights reserved.
//

import Foundation
//import XCTest
import Quick.QuickSpec
import Nimble
@testable import HaskellSwift

class ControlMonadSpec: QuickSpec {
    override func spec() {
        describe(">>>=") {
            it("Left Law") {
                let xs : [Int] = [1, 2, 3]
                let f: Int -> [Int]           = { (x: Int) -> [Int] in
                    return [x*x]
                }
                let result      = xs >>>= f
                expect(result).to(equal([1, 4, 9]))
            }
        }
    }
}
