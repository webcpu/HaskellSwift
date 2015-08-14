//
//  HaskellSwiftTests.swift
//  HaskellSwiftTests
//
//  Created by Liang on 14/08/2015.
//  Copyright © 2015 Liang. All rights reserved.
//

import Quick
import Nimble
@testable import HaskellSwift

class HaskellSwiftSpec: QuickSpec {
    override func spec() {
        let files           = ["README.md", "Haskell.swift", "HaskellTests.swift", "HaskellSwift.swift"]
        
        describe("map") {
            it("String Array") {
                let uppercaseFiles  = ["README.MD", "HASKELL.SWIFT", "HASKELLTESTS.SWIFT", "HASKELLSWIFT.SWIFT"]
                
                let toUppercase     = { (x: String) in x.uppercaseString }
                let toUppercases    = { xs in map(toUppercase, xs) }
                let uppercases      = toUppercases(files)
                expect(uppercases).to(equal(uppercaseFiles))
            }
            
            it("Int Array") {
                let countLength     = { (x: String) in x.characters.count }
                let countLenghs     = { xs in map(countLength, xs) }
                let lengths         = countLenghs(files)
                expect(lengths).to(equal(files.map({ (x: String) in x.characters.count })))
            }
        }
        
        describe("reduce") {
            it("Int Array") {
                let add             = { (initial: Int, x: Int) -> Int in initial + x }
                let sum             = { xs in reduce(add, 0, xs) }
                let result          = sum([1,2,3,4])
                expect(result).to(equal(10))
            }
        }
        
        describe("filter") {
            it("String Array") {
                let isSwift         = { (x : String) in x.lowercaseString.hasSuffix("swift") }
                let swiftFilter     = { xs in filter(isSwift, xs) }
                let swiftFiles      = swiftFilter(files)
                expect(swiftFiles).to(equal(["Haskell.swift", "HaskellTests.swift", "HaskellSwift.swift"]))
            }
        }
        
        describe("head") {
            it("Int Array") {
                expect(head([1])).to(equal(1))
                expect(head([1,2,3])).to(equal(1))
            }
            
            it("String Array") {
                expect(head(["World"])).to(equal("World"))
                expect(head(files)).to(equal("README.md"))
            }
        }
        
        describe("tail") {
            it("Int Array") {
                expect(tail([1])).to(equal([Int]()))
                expect(tail([1,2,3])).to(equal([2,3]))
            }
            
            it("String Array") {
                expect(tail(["World"])).to(equal([String]()))
                let expectedFiles = Array(files[1..<(files.count)])
                expect(tail(files)).to(equal(expectedFiles))
            }
            
        }
        
        describe("take") {
            it("Int Array") {
                let ints = [1, 2, 3]
                expect(take(0, ints)).to(equal([Int]()))
                expect(take(0, [Int]())).to(equal([Int]()))
                expect(take(1, ints)).to(equal([1]))
            }
            
            it("String Array") {
                expect(take(0, files)).to(equal([String]()))
                expect(take(0, [String]())).to(equal([String]()))
                expect(take(1, files)).to(equal([files[0]]))
            }
        }
    }
}
