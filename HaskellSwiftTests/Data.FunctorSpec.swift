//
//  Data.FunctorSpec.swift
//  HaskellSwift
//
//  Created by Liang on 30/08/2015.
//  Copyright © 2015 Liang. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import HaskellSwift

class DataFunctorSpec: QuickSpec {
    override func spec() {
        describe("fmap") {
            it("Function") {
                //true <- "d" <- "D" <- "D321" <- "123D"
                let f = fmap(fmap(isLower, toLower), fmap(head, reverse))
                expect(f("123D")).to(beTrue())
            }
        }
        
        describe("<^>") {
            it("Function") {
                //true <- "d" <- "D" <- "D321" <- "123D"
                let f = isLower <^> toLower <^> head <^> reverse
                expect(f("123D")).to(beTrue())
            }
        }
        
        describe("<|") {
            it("Function") {
                let f = 5 <| {x in x*2 }
                expect(f(3)).to(equal(10))
            }
            
            it("Int Int") {
                expect(10 <| [1,2,3]).to(equal([10,10,10]))
            }
            
            it("Int String") {
                expect("AA" <| [1,2,3]).to(equal(["AA","AA","AA"]))
            }
            
            it("Tuple") {
                let (r0, r1) = "AA" <| (1, 3)
                expect(r0).to(equal(1))
                expect(r1).to(equal("AA"))
            }
        }
    }
}