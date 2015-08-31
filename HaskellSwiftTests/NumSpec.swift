//
//  NumSpec.swift
//  HaskellSwift
//
//  Created by Liang on 31/08/2015.
//  Copyright © 2015 Liang. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import HaskellSwift

class NumSpec: QuickSpec {
    override func spec() {
        describe("negate") {
            it("CGFloat") {
                expect(negate(CGFloat(1))).to(beCloseTo(CGFloat(-1)))
                expect(negate(CGFloat(-1))).to(beCloseTo(CGFloat(1)))
            }
            
            it("Double") {
                expect(negate(Double(1))).to(beCloseTo(Double(-1)))
                expect(negate(Double(-1))).to(beCloseTo(Double(1)))
            }
            
            it("Float") {
                expect(negate(Float(1))).to(beCloseTo(Float(-1)))
                expect(negate(Float(-1))).to(beCloseTo(Float(1)))
            }
            
            it("Int") {
                expect(negate(Int(1))).to(equal(-1))
                expect(negate(Int(-1))).to(equal(1))
            }
            
            it("Int16") {
                expect(negate(Int16(1))).to(equal(-1))
                expect(negate(Int16(-1))).to(equal(1))
            }
            
            it("Int32") {
                expect(negate(Int32(1))).to(equal(-1))
                expect(negate(Int32(-1))).to(equal(1))
            }
            
            it("Int64") {
                expect(negate(Int64(1))).to(equal(-1))
                expect(negate(Int64(-1))).to(equal(1))
            }
            
            it("Int8") {
                expect(negate(Int8(1))).to(equal(-1))
                expect(negate(Int8(-1))).to(equal(1))
            }
        }
    }
}
