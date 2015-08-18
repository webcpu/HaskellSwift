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

class DataListSpec: QuickSpec {
    override func spec() {
        let files           = ["README.md", "Haskell.swift", "HaskellTests.swift", "HaskellSwift.swift"]
       
        describe("•") {
            it ("Int Array") {
                let process : [Int] -> Int = last • reverse
                let ints            = [1,2,3,4,5]
                expect(process(ints)).to(equal(1))
            }
            
            it("String Array") {
                let process : [String]->String = last • xinit • reverse
                let words           = ["Very", "Good", "Person"]
                let result          = process(words)
                expect(result).to(equal("Good"))
            }
            
            it("String") {
                let fs              = head  • reverse  • reverse
                let result          = fs("ABC")
                expect(result).to(equal("A"))
            }
        }
        
        describe("++") {
            it("Int Array") {
                let list1           = [1, 2, 3]
                let list2           = [4, 5, 6]
                let result          = list1 ++ list2
                expect(result).to(equal([1, 2, 3, 4, 5, 6]))
            }
            
            it("String Array") {
                let list1           = ["Hello"]
                let list2           = ["world", "Haskell!"]
                let result          = list1 ++ list2
                expect(result).to(equal(["Hello", "world", "Haskell!"]))
            }
            
            it("String") {
                let list1           = "Hello"
                let list2           = "world"
                let result          = list1 ++ list2
                expect(result).to(equal("Helloworld"))
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
            
            it("String") {
                let result = head("World")
                expect(result).to(equal("W"))
                expect(head("W")).to(equal("W"))
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
            
            it("String") {
                let result = last("World")
                expect(result).to(equal("d"))
                expect(last("W")).to(equal("W"))
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
            
            it("String") {
                let result = tail("World")
                expect(result).to(equal("orld"))
                expect(tail("W")).to(equal(""))
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
            
            it("String") {
                expect(xinit("1")).to(equal(String()))
                expect(xinit("WHO")).to(equal("WH"))
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
        
        describe("reverse") {
            it("Int Array") {
                expect(reverse([3])).to(equal([3]))
                expect(reverse([1,2])).to(equal([2,1]))
            }
            
            it("String Array") {
                let reversedFiles = ["HaskellSwift.swift","HaskellTests.swift","Haskell.swift","README.md"]
                expect(reverse(["Hello"])).to(equal(["Hello"]))
                expect(reverse(files)).to(equal(reversedFiles))
            }
            
            it("String") {
                expect(reverse("World")).to(equal("dlroW"))
                expect(reverse("")).to(equal(""))
            }
        }
       
        describe("foldl") {
            it("Int Array") {
                let adds     = { (x: Int,y: Int) in x+y }
                expect(foldl(adds, 0, [1, 2, 3])).to(equal(6))
                
                let product = {(x: Int, y: Int) in x*y}
                expect(foldl(product, 1, [1,2,3,4,5])).to(equal(120))
            }
            
            it("String Array") {
                let letters : [String] = ["W", "o", "r", "l", "d"]
                let adds = { (x: String, y: String) in x + y }
                let result = foldl(adds, "", letters)
                expect(result).to(equal("World"))
            }
            
            it("String") {
                let insert = { (x: String, y: Character) in String(y) + x }
                expect(foldl(insert, "", "World")).to(equal("dlroW"))
            }
        }
        
        describe("foldr") {
            it("Int Array") {
                let adds     = { (a: Int,b: Int) in a+b }
                expect(foldr(adds, 0, [1, 2, 3])).to(equal(6))
                
                let multiply = {(a: Int, b: Int) in a*b}
                expect(foldr(multiply, 1, [1,2,3,4,5])).to(equal(120))
            }
            
            it("String Array") {
                let letters : [String] = ["W", "o", "r", "l", "d"]
                let adds = { (a: String, b: String) in b + a }
                let result = foldr(adds, "", letters)
                expect(result).to(equal("dlroW"))
            }
            
            it("String") {
                let insert = { (a: Character, b: String) in String(a) + b }
                expect(foldr(insert, "", "World")).to(equal("World"))
            }
        }
        
        describe("reduce") {
            it("Int Array") {
                let adds             = { (initial: Int, x: Int) -> Int in initial + x }
                let result          = reduce(adds, 0, [1,2,3,4])
                expect(result).to(equal(10))
            }
            
            it("String Array 1") {
                let adds             = { (initial: String, x: String) -> String in initial + x }
                let concat          = { xs in reduce(adds, "", xs) }
                let result          = concat(["Hello", "World", "!"])
                expect(result).to(equal("HelloWorld!"))
            }
            
            it("String Array 2") {
                let adds             = { (initial: String, x: String) -> String in initial + x }
                let concat          = { xs in reduce(adds, "", xs) }
                let result          = concat(["C", "a", "t", "!"] )
                expect(result).to(equal("Cat!"))
            }
            
            it("String") {
                let adds             = { (initial: String, x: Character) -> String in initial + String(x) }
                let result          = reduce(adds, "", ["C", "a", "t", "!"])
                expect(result).to(equal("Cat!"))
            }
        }
        
        describe("concat") {
            it("Int Arrays Array") {
                var ints = [[1, 2, 3], [4, 5, 6]]
                expect(concat(ints)).to(equal([1, 2, 3, 4, 5, 6]))
                ints = [[Int]]()
                expect(concat(ints)).to(equal([[Int]]()))
            }
            
            it("String Arrays Array") {
                let strings = [["a", "b", "c"], ["d", "e", "f"]]
                expect(concat(strings)).to(equal(["a", "b", "c", "d", "e", "f"]))
            }
            
            it("String Arrays") {
                let strings = ["Hello", "World"]
                expect(concat(strings)).to(equal("HelloWorld"))
                let emptyString = [String]()
                expect(concat(emptyString)).to(equal(String()))
            }
        }
        
        describe("concatMap") {
            it("Int Arrays Array") {
                let ints = [1, 2]
                expect(concatMap({x in [x, x*x]}, ints)).to(equal([1, 1, 2, 4]))
            }
            
            it("String Arrays Array") {
                let strings = ["a", "b"]
                expect(concatMap( {x in [x + "0", x + "1", x + "2"]}, strings)).to(equal(["a0", "a1", "a2", "b0", "b1", "b2"]))
            }
            
            it("String Arrays") {
                let strings = ["Hello", "World"]
                expect(concat(strings)).to(equal("HelloWorld"))
                let emptyString = [String]()
                expect(concat(emptyString)).to(equal(String()))
            }
        }
        
        describe("and") {
            it("Bool Array") {
                expect(and([false, false])).to(beFalse())
                expect(and([true, false])).to(beFalse())
                expect(and([true, true])).to(beTrue())
                expect(and([false, true])).to(beFalse())
            }
        }
       
        describe("or") {
            it("Bool Array") {
                expect(or([true,true])).to(beTrue())
                expect(or([false,true])).to(beTrue())
                expect(or([false,false])).to(beFalse())
                expect(or([true, false])).to(beTrue())
            }
        }
        
        describe("any") {
            it("Int Array") {
                let ints = [1,3,7]
                expect(any({ x in x < 10}, ints)).to(beTrue())
                expect(any({ x in x > 10}, ints)).to(beFalse())
            }
            
            it("String Array") {
                let words = ["Hello", "World"]
                expect(any({ x in head(x) == "H"}, words)).to(beTrue())
                expect(any({ x in last(x) == "t"}, words)).to(beFalse())
            }
            
            it("String") {
                let word = "Hello"
                expect(any({ x in x == "H"}, word)).to(beTrue())
                expect(any({ x in x == "t"}, word)).to(beFalse())
            }
        }
        
        describe("all") {
            it("Int Array") {
                let ints = [1,3,7]
                expect(all({ x in x < 10}, ints)).to(beTrue())
                expect(all({ x in x > 10}, ints)).to(beFalse())
                expect(all({ x in x > 10}, [Int]())).to(beTrue())
            }
            
            it("String Array") {
                let words = ["Hello", "World"]
                expect(all({ x in head(x) < "z"}, words)).to(beTrue())
                expect(all({ x in last(x) < "a"}, words)).to(beFalse())
                expect(all({ x in last(x) < "a"}, [String]())).to(beTrue())
            }
            
            it("String") {
                let word = "Hello"
                expect(all({ x in x < "z"}, word)).to(beTrue())
                expect(all({ x in x == "t"}, word)).to(beFalse())
                expect(all({ x in x == "t"}, "")).to(beTrue())
            }
        }
        
        describe("sum") {
            it("CGFloat Array") {
                let list : [CGFloat] = [1.0, 2.0, 3.0]
                let result = sum(list)
                expect(result).to(beCloseTo(6.0))
                expect(sum([CGFloat]())).to(equal(0.0))
            }
            
            it("Double Array") {
                let list : [Double] = [1.1, 2.2, 3.3]
                let result          = sum(list)
                expect(result).to(beCloseTo(6.6))
                expect(sum([Double]())).to(equal(0.0))
            }
            
            it("Float Array") {
                let list : [Float]  = [1.1, 2.2, 3.3]
                let result          = sum(list)
                expect(result).to(beCloseTo(Float(6.6)))
                expect(sum([Float]())).to(equal(0.0))
            }
            
            it("Int Array") {
                let list : [Int]    = [1, 2, 3]
                let result          = sum(list)
                expect(result).to(equal(Int(6)))
                expect(sum([Int]())).to(equal(0))
            }
            
            it("Int16 Array") {
                let list : [Int16]  = [1, 2, 3]
                let result          = sum(list)
                expect(result).to(equal(Int16(6)))
                expect(sum([Int16]())).to(equal(0))
            }
            
            it("Int32 Array") {
                let list : [Int32]  = [1, 2, 3]
                let result          = sum(list)
                expect(result).to(equal(Int32(6)))
                expect(sum([Int32]())).to(equal(0))
            }
            
            it("Int64 Array") {
                let list : [Int64]  = [1, 2, 3]
                let result          = sum(list)
                expect(result).to(equal(Int64(6)))
                expect(sum([Int64]())).to(equal(0))
            }
            
            it("Int8 Array") {
                let list : [Int8]   = [1, 2, 3]
                let result          = sum(list)
                expect(result).to(equal(Int8(6)))
                expect(sum([Int8]())).to(equal(0))
            }
            
            it("UInt Array") {
                let list : [UInt]   = [1, 2, 3]
                let result          = sum(list)
                expect(result).to(equal(UInt(6)))
                expect(sum([UInt]())).to(equal(0))
            }
            
            it("UInt16 Array") {
                let list : [UInt16] = [1, 2, 3]
                let result          = sum(list)
                expect(result).to(equal(UInt16(6)))
                expect(sum([UInt16]())).to(equal(0))
            }
            
            it("UInt32 Array") {
                let list : [UInt32] = [1, 2, 3]
                let result          = sum(list)
                expect(result).to(equal(UInt32(6)))
                expect(sum([UInt32]())).to(equal(0))
            }
            
            it("UInt64 Array") {
                let list : [UInt64] = [1, 2, 3]
                let result          = sum(list)
                expect(result).to(equal(UInt64(6)))
                expect(sum([UInt64]())).to(equal(0))
            }
            
            it("UInt8 Array") {
                let list : [UInt8]  = [1, 2, 3]
                let result          = sum(list)
                expect(result).to(equal(UInt8(6)))
                expect(sum([UInt8]())).to(equal(0))
            }
        }
        
        describe("product") {
            it("CGFloat Array") {
                let list : [CGFloat] = [1.0, 2.0, 3.0]
                let result = product(list)
                expect(result).to(beCloseTo(6.0))
                expect(product([CGFloat]())).to(equal(1.0))
            }
            
            it("Double Array") {
                let list : [Double] = [1.1, 2.2, 3.3]
                let result          = product(list)
                expect(result).to(beCloseTo(7.986000000000001))
                expect(product([Double]())).to(equal(1.0))
            }
            
            it("Float Array") {
                let list : [Float]  = [1.1, 2.2, 3.3]
                let result          = product(list)
                expect(result).to(beCloseTo(Float(7.986000000000001)))
                expect(product([Float]())).to(equal(1.0))
            }
            
            it("Int Array") {
                let list : [Int]    = [1, 2, 3, 4]
                let result          = product(list)
                expect(result).to(equal(Int(24)))
                expect(product([Int]())).to(equal(1))
            }
            
            it("Int16 Array") {
                let list : [Int16]  = [1, 2, 3, 4]
                let result          = product(list)
                expect(result).to(equal(Int16(24)))
                expect(product([Int16]())).to(equal(1))
            }
            
            it("Int32 Array") {
                let list : [Int32]  = [1, 2, 3, 4]
                let result          = product(list)
                expect(result).to(equal(Int32(24)))
                expect(product([Int32]())).to(equal(1))
            }
            
            it("Int64 Array") {
                let list : [Int64]  = [1, 2, 3, 4]
                let result          = product(list)
                expect(result).to(equal(Int64(24)))
                expect(product([Int64]())).to(equal(1))
            }
            
            it("Int8 Array") {
                let list : [Int8]   = [1, 2, 3, 4]
                let result          = product(list)
                expect(result).to(equal(Int8(24)))
                expect(product([Int8]())).to(equal(1))
            }
            
            it("UInt Array") {
                let list : [UInt]   = [1, 2, 3, 4]
                let result          = product(list)
                expect(result).to(equal(UInt(24)))
                expect(product([UInt]())).to(equal(1))
            }
            
            it("UInt16 Array") {
                let list : [UInt16] = [1, 2, 3, 4]
                let result          = product(list)
                expect(result).to(equal(UInt16(24)))
                expect(product([UInt16]())).to(equal(1))
            }
            
            it("UInt32 Array") {
                let list : [UInt32] = [1, 2, 3, 4]
                let result          = product(list)
                expect(result).to(equal(UInt32(24)))
                expect(product([UInt32]())).to(equal(1))
            }
            
            it("UInt64 Array") {
                let list : [UInt64] = [1, 2, 3, 4]
                let result          = product(list)
                expect(result).to(equal(UInt64(24)))
                expect(product([UInt64]())).to(equal(1))
            }
            
            it("UInt8 Array") {
                let list : [UInt8]  = [1, 2, 3, 4]
                let result          = product(list)
                expect(result).to(equal(UInt8(24)))
                expect(product([UInt8]())).to(equal(1))
            }
        }
        
        describe("maximum") {
            it("CGFloat Array") {
                let list : [CGFloat] = [1.0, 2.0, 3.0]
                let result           = maximum(list)
                expect(result).to(beCloseTo(3.0))
            }
            
            it("Double Array") {
                let list : [Double] = [1.1, 2.2, 3.3]
                let result          = maximum(list)
                expect(result).to(beCloseTo(3.3))
            }
            
            it("Float Array") {
                let list : [Float]  = [1.1, 2.2, 3.3]
                let result          = maximum(list)
                expect(result).to(beCloseTo(3.3))
            }
            
            it("Int Array") {
                let list : [Int]    = [1, 2, 3]
                let result          = maximum(list)
                expect(result).to(equal(3))
            }
            
            it("Int16 Array") {
                let list : [Int16]    = [1, 2, 3]
                let result          = maximum(list)
                expect(result).to(equal(3))
            }
            
            it("Int32 Array") {
                let list : [Int32]    = [1, 2, 3]
                let result          = maximum(list)
                expect(result).to(equal(3))
            }
            
            it("Int64 Array") {
                let list : [Int64]    = [1, 2, 3]
                let result          = maximum(list)
                expect(result).to(equal(3))
            }
            
            it("Int8 Array") {
                let list : [Int8]    = [1, 2, 3]
                let result          = maximum(list)
                expect(result).to(equal(3))
            }
            
            it("UInt Array") {
                let list : [UInt]    = [1, 2, 3]
                let result          = maximum(list)
                expect(result).to(equal(3))
            }
            
            it("UInt16 Array") {
                let list : [UInt16]    = [1, 2, 3]
                let result          = maximum(list)
                expect(result).to(equal(3))
            }
            
            it("UInt32 Array") {
                let list : [UInt32]    = [1, 2, 3]
                let result          = maximum(list)
                expect(result).to(equal(3))
            }
            
            it("UInt64 Array") {
                let list : [UInt64]    = [1, 2, 3]
                let result          = maximum(list)
                expect(result).to(equal(3))
            }
            
            it("UInt8 Array") {
                let list : [UInt8]    = [1, 2, 3]
                let result          = maximum(list)
                expect(result).to(equal(3))
            }
        }
       
        describe("minimum") {
            it("CGFloat Array") {
                let list : [CGFloat] = [4.4, 2.2, 3.3]
                let result           = minimum(list)
                expect(result).to(beCloseTo(2.2))
            }
            
            it("Double Array") {
                let list : [Double] = [4.4, 2.2, 3.3]
                let result          = minimum(list)
                expect(result).to(beCloseTo(2.2))
            }
            
            it("Float Array") {
                let list : [Float]  = [4.4, 2.2, 3.3]
                let result          = minimum(list)
                expect(result).to(beCloseTo(2.2))
            }
            
            it("Int Array") {
                let list : [Int]    = [5, 2, 3]
                let result          = minimum(list)
                expect(result).to(equal(2))
            }
            
            it("Int16 Array") {
                let list : [Int16]    = [5, 2, 3]
                let result          = minimum(list)
                expect(result).to(equal(2))
            }
            
            it("Int32 Array") {
                let list : [Int32]    = [5, 2, 3]
                let result          = minimum(list)
                expect(result).to(equal(2))
            }
            
            it("Int64 Array") {
                let list : [Int64]    = [5, 2, 3]
                let result          = minimum(list)
                expect(result).to(equal(2))
            }
            
            it("Int8 Array") {
                let list : [Int8]    = [5, 2, 3]
                let result          = minimum(list)
                expect(result).to(equal(2))
            }
            
            it("UInt Array") {
                let list : [UInt]    = [5, 2, 3]
                let result          = minimum(list)
                expect(result).to(equal(2))
            }
            
            it("UInt16 Array") {
                let list : [UInt16]    = [5, 2, 3]
                let result          = minimum(list)
                expect(result).to(equal(2))
            }
            
            it("UInt32 Array") {
                let list : [UInt32]    = [5, 2, 3]
                let result          = minimum(list)
                expect(result).to(equal(2))
            }
            
            it("UInt64 Array") {
                let list : [UInt64]    = [5, 2, 3]
                let result          = minimum(list)
                expect(result).to(equal(2))
            }
            
            it("UInt8 Array") {
                let list : [UInt8]    = [5, 2, 3]
                let result          = minimum(list)
                expect(result).to(equal(2))
            }
        }
        
        describe("take") {
            it("Int Array") {
                let ints = [1, 2, 3]
                expect(take(0, ints)).to(equal([Int]()))
                expect(take(0, [Int]())).to(equal([Int]()))
                expect(take(1, ints)).to(equal([1]))
                expect(take(5, ints)).to(equal(ints))
            }
            
            it("String Array") {
                expect(take(0, files)).to(equal([String]()))
                expect(take(0, [String]())).to(equal([String]()))
                expect(take(1, files)).to(equal([files[0]]))
                expect(take(10, files)).to(equal(files))
            }
            
            it("String") {
                let str = "World"
                expect(take(0, files)).to(equal([String]()))
                expect(take(0, [String]())).to(equal([String]()))
                expect(take(1, str)).to(equal("W"))
                expect(take(3, str)).to(equal("Wor"))
                expect(take(10, str)).to(equal(str))
            }
        }
        
        describe("drop") {
            it("Int Array") {
                let ints = [1, 2, 3]
                expect(drop(0, ints)).to(equal(ints))
                expect(drop(0, [Int]())).to(equal([Int]()))
                expect(drop(1, ints)).to(equal([2, 3]))
                expect(drop(10, ints)).to(equal([Int]()))
            }
            
            it("String Array") {
                expect(drop(0, files)).to(equal(files))
                expect(drop(0, [String]())).to(equal([String]()))
                let expectedResult = Array(files[1..<(files.count)])
                expect(drop(1, files)).to(equal(expectedResult))
                expect(drop(files.count + 1, files)).to(equal([String]()))
            }
            
            it("String") {
                expect(drop(0, "Hello World")).to(equal("Hello World"))
                expect(drop(0, [String]())).to(equal([String]()))
                expect(drop(1, "World")).to(equal("orld"))
                expect(drop(10, "World")).to(equal(""))
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
    }
}
