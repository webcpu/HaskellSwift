//
//  Data.TupleSpec.swift
//  HaskellSwift
//
//  Created by Liang on 29/08/2015.
//  Copyright © 2015 Liang. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import HaskellSwift

class DataTupleSpec: QuickSpec {
    override func spec() {
        describe("fst") {
            it("Int") {
                let r0 = fst((1, "a"))
                expect(r0).to(equal(1))
            }
            
            it("Character") {
                let r0 = fst(("a", 1))
                expect(r0).to(equal("a"))
            }
           
            it("String") {
                let r0 = fst(("ab", 1))
                expect(r0).to(equal("ab"))
            }
           
            it("String Array") {
                let r0 = fst((["ab"], 1))
                expect(r0).to(equal(["ab"]))
            }
        }
        
        describe("snd") {
            it("Int") {
                let r0 = snd(("a", 1))
                expect(r0).to(equal(1))
            }
            
            it("Character") {
                let r0 = snd((1, "a"))
                expect(r0).to(equal("a"))
            }
            
            it("String") {
                let r0 = snd((1, "ab"))
                expect(r0).to(equal("ab"))
            }
            
            it("String Array") {
                let r0 = snd((1, ["ab"]))
                expect(r0).to(equal(["ab"]))
            }
        }
        
        describe("curry") {
            it("half") {
                let fa = curry(elem, 1)
                expect(fa([2,1])).to(beTrue())
            }
            
            it("all") {
                expect(curry(elem)(1)([2,1])).to(beTrue())
            }
        }
        
        describe("uncurry") {
            it("half") {
                let f  = uncurry(curry(elem as (Int,[Int])->Bool))
                expect(f(1, [1,2])).to(beTrue())
            }
            
           it("all") {
                let f = uncurry(curry(elem as (Int, [Int])->Bool))
                expect(f(1, [2,1])).to(beTrue())
            }
        }
       
        describe("swap") {
            it("Int") {
                let (r0, r1) = swap(("a", 1))
                expect(r0).to(equal(1))
                expect(r1).to(equal("a"))
            }
            
            it("Character") {
                let (r0, r1) = swap((1, "a"))
                expect(r0).to(equal("a"))
                expect(r1).to(equal(1))
            }
            
            it("String") {
                let (r0, r1) = swap((1, "ab"))
                expect(r0).to(equal("ab"))
                expect(r1).to(equal(1))
            }
            
            it("String Array") {
                let (r0, r1) = swap((1, ["ab"]))
                expect(r0).to(equal(["ab"]))
                expect(r1).to(equal(1))
            }
        }
    }
}