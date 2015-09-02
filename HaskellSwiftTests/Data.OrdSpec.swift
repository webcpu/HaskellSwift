//
//  Data.OrdSpec.swift
//  HaskellSwift
//
//  Created by Liang on 01/09/2015.
//  Copyright © 2015 Liang. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import HaskellSwift

class DataOrdSpec: QuickSpec {
    override func spec() {
        describe("negate") {
            it("CGFloat") {
                expect(negate(CGFloat(1))).to(beCloseTo(CGFloat(-1)))
                expect(negate(CGFloat(-1))).to(beCloseTo(CGFloat(1)))
            }
        }
    }
}
