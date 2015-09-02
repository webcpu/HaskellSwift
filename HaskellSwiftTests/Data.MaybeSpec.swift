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
        describe("Nothing") {
            it("Nothing") {
                expect(Nothing()).to(beNil())
            }
        }
        
        describe("Just") {
            it("Int") {
                expect(Just(1)).to(equal(1 as Int?))
            }
            
            it("String") {
                expect(Just("1")).to(equal("1" as String?))
            }
        }
        
        describe("maybe") {
            it("Function") {
                let _lookup = {x in lookup(x, ["a":1, "b":2])}
                let r0      = maybe(5, negate, _lookup("c"))
                expect(r0).to(equal(5))
                
                let r1      = maybe(5, negate, _lookup("a"))
                expect(r1).to(equal(-1))
            }
        }
        
        describe("isJust") {
            it("Int") {
                var a : Int?
                expect(isJust(a)).to(beFalse())
                a = 3
                expect(isJust(a)).to(beTrue())
            }
        }
        
        describe("isJust") {
            it("Int") {
                var a : Int?
                expect(isJust(a)).to(beFalse())
                a = 3
                expect(isJust(a)).to(beTrue())
            }
        }
        
        describe("fromMaybe") {
            it("Int") {
                var a : Int?
                expect(fromMaybe(3, a)).to(equal(3))
                a = 10
                expect(fromMaybe(3, a)).to(equal(10))
            }
        }
        
        describe("listToMaybe") {
            it("Int") {
                expect(listToMaybe([3])).to(equal(3))
                expect(listToMaybe([1,2,3])).to(equal(1))
                expect(listToMaybe([Int]())).to(beNil())
            }
        }
        
        describe("maybeToList") {
            it("Int") {
                var x : Int? = nil
                expect(maybeToList(x)).to(equal([Int]()))
                x = 3
                expect(maybeToList(x)).to(equal([3]))
            }
        }
        
        describe("catMaybes") {
            it("Int") {
                let xs: [Int?] = [1, nil, 3]
                expect(catMaybes(xs)).to(equal([1,3]))
            }
        }
        
        describe("mapMaybe") {
            it("Int") {
                let xs = [1, 2, 3]
                let f = {(a: Int) -> String? in
                    return lookup(a, [1:"a", 5:"e"])
                }
                expect(mapMaybe(f, xs)).to(equal(["a"]))
            }
        }
    }
}
