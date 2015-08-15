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
                let countLengths     = { xs in map(countLength, xs) }
                let lengths         = countLengths(files)
                expect(lengths).to(equal(files.map({ (x: String) in x.characters.count })))
            }
            
            it("String - String") {
                let toUppercase     = { (x: Character) in  String(x).capitalizedString.characters.first! }
                let toUppercases    = { xs in map(toUppercase, xs) }
                let uppercaseString = toUppercases("haskell")
                expect(uppercaseString).to(equal("HASKELL"))
            }
            
            it("String - UInt32 Array") {
                let toUppercase     = { (x: Character) -> UInt32 in
                    let scalars = String(x).capitalizedString.unicodeScalars
                    return scalars[scalars.startIndex].value
                }
                let toUppercases    = { (xs : String) -> [UInt32] in map(toUppercase, xs) }
                let uppercaseString = toUppercases("haskell")
                expect(uppercaseString).to(equal([72,65,83,75,69,76,76]))
            }
            
            it("String - Bool Array") {
                let isUppercase = { (x: Character) -> Bool in return ("A"..."Z").contains(x) }
                let checkUppercases = { (xs: String) -> [Bool] in map(isUppercase, xs) }
                let uppercases = checkUppercases("Haskell")
                expect(uppercases).to(equal([true, false, false, false, false, false, false]))
            }
        }
        
        describe("reduce") {
            it("Int Array") {
                let add             = { (initial: Int, x: Int) -> Int in initial + x }
                let sum             = { xs in reduce(add, 0, xs) }
                let result          = sum([1,2,3,4])
                expect(result).to(equal(10))
            }
            
            it("String Array") {
                let add             = { (initial: String, x: String) -> String in initial + x }
                let concat          = { xs in reduce(add, "", xs) }
                let result          = concat(["Hello", "World", "!"])
                expect(result).to(equal("HelloWorld!"))
            }
            
            it("Character Array") {
                let add             = { (initial: String, x: String) -> String in initial + x }
                let concat          = { xs in reduce(add, "", xs) }
                let result          = concat(["C", "a", "t", "!"] )
                expect(result).to(equal("Cat!"))
            }
        }
        
        describe("filter") {
            it("String Array") {
                let isSwift         = { (x : String) in x.lowercaseString.hasSuffix("swift") }
                let swiftFilter     = { xs in filter(isSwift, xs) }
                let swiftFiles      = swiftFilter(files)
                expect(swiftFiles).to(equal(["Haskell.swift", "HaskellTests.swift", "HaskellSwift.swift"]))
            }
            
            it("String") {
                let isA             = { (x : Character) in x == "a" }
                let isAFilter       = { (xs : String) in filter(isA, xs) }
                let result          = isAFilter("ABCDa")
                expect(result).to(equal("a"))
            }
        }
        
        describe("head") {
            it("Int Array") {
                expect(head([1])).to(equal(1))
                expect(head([1,2,3])).to(equal(1))
            }
            
            it("String Array") {
                let result0 = head(["World"])
                expect(result0).to(equal("World"))
                let result1 = head(files)
                expect(result1).to(equal("README.md"))
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
       
        describe("last") {
            it("Int Array") {
                let result0 = last([1])
                expect(result0).to(equal(1))
                let result1 = last([1,2,3])
                expect(result1).to(equal(3))
            }
            
            it("String Array") {
                let result0 = last(["World"])
                expect(result0).to(equal("World"))
                expect(last(files)).to(equal(files[files.count - 1]))
            }
        }
        
        describe("xinit") {
            it("Int Array") {
                expect(xinit([1])).to(equal([Int]()))
                expect(xinit([1,2])).to(equal([1]))
            }
            
            it("String Array") {
                expect(xinit(["World"])).to(equal([String]()))
                expect(xinit(files)).to(equal(Array(files[0..<(files.count - 1)])))
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
        
        describe("length") {
            it("Int Array") {
                expect(length([1])).to(equal(1))
                expect(length([1,2])).to(equal(2))
            }
            
            it("String Array") {
                expect(length(["World"])).to(equal(1))
                expect(length(files)).to(equal(files.count))
            }
           
            it("String") {
                expect(length("World")).to(equal(5))
                expect(length("")).to(equal(0))
            }
        }
        
        describe("null") {
            it("Int Array") {
                expect(null([1])).to(beFalse())
                expect(null([Int]())).to(beTrue())
            }
            
            it("String Array") {
                expect(null(["World"])).to(beFalse())
                expect(null([String]())).to(beTrue())
                expect(null(files)).to(beFalse())
            }
            
            it("String") {
                expect(null("World")).to(beFalse())
                expect(null("")).to(beTrue())
            }
        }
    }
}
