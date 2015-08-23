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
                let process : [String]->String = last • initx • reverse
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
        
        describe("not") {
            it("Bool") {
                expect(not(true)).to(beFalse())
                expect(not(false)).to(beTrue())
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
       
        describe("initx") {
            it("Int Array") {
                expect(initx([1])).to(equal([Int]()))
                expect(initx([1,2])).to(equal([1]))
            }
            
            it("String Array") {
                expect(initx(["World"])).to(equal([String]()))
                expect(initx(files)).to(equal(Array(files[0..<(files.count - 1)])))
            }
            
            it("String") {
                expect(initx("1")).to(equal(String()))
                expect(initx("WHO")).to(equal("WH"))
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
        
        describe("splitAt") {
            it("Int Array") {
                let ints = [1, 2, 3]
                let (list1, list2) = splitAt(2, ints)
                expect(list1).to(equal([1, 2]))
                expect(list2).to(equal([3]))
            }
            
            it("String Array") {
                let list = ["Is", "it", "OK"]
                let (list1, list2) = splitAt(2, list)
                expect(list1).to(equal(["Is", "it"]))
                expect(list2).to(equal(["OK"]))
            }
            
            it("String") {
                let list = "Hello World"
                let (list1, list2) = splitAt(5, list)
                expect(list1).to(equal("Hello"))
                expect(list2).to(equal(" World"))
            }
        }
        
        describe("takeWhile") {
            it("Int Array") {
                let ints = [1, 2, 3]
                let result = takeWhile( { $0 > 2} , ints)
                expect(result).to(equal([Int]()))
            }
            
            it("String Array") {
                let list = ["Is", "it", "OK"]
                let result = takeWhile({ x in head(x) == "I"}, list)
                expect(result).to(equal(["Is"]))
            }
            
            it("String") {
                let list = "Hello World"
                let result = takeWhile({ x in x < "Z"}, list)
                expect(result).to(equal("H"))
            }
        }
        
        describe("dropWhile") {
            it("Int Array") {
                let ints = [1, 2, 3]
                let result = dropWhile( { $0 < 3} , ints)
                expect(result).to(equal([3]))
            }
            
            it("String Array") {
                let list = ["Is", "it", "OK"]
                let result = dropWhile({ x in head(x) == "I" || head(x) == "i" }, list)
                expect(result).to(equal(["OK"]))
            }
            
            it("String") {
                let list = "Hello World"
                let result = dropWhile({ x in x < "Z"}, list)
                expect(result).to(equal("ello World"))
            }
        }
        
        describe("span") {
            it("Int Array") {
                let ints            = [1, 2, 3]
                let (list1, list2)  = span( { $0 < 2} , ints)
                expect(list1).to(equal([1]))
                expect(list2).to(equal([2, 3]))
            }
            
            it("String Array") {
                let list    = ["Is", "it", "OK"]
                let (list1, list2)  = span({ x in head(x) == "I" || head(x) == "i" }, list)
                expect(list1).to(equal(["Is", "it"]))
                expect(list2).to(equal(["OK"]))
            }
            
            it("String") {
                let list = "Hello World"
                let (list1, list2) = span({ x in x < "Z"}, list)
                expect(list1).to(equal("H"))
                expect(list2).to(equal("ello World"))
            }
        }
        
        describe("breakx") {
            it("Int Array") {
                let ints            = [1, 2, 3]
                let (list1, list2)  = breakx( { $0 > 2} , ints)
                expect(list1).to(equal([1, 2]))
                expect(list2).to(equal([3]))
            }
            
            it("String Array") {
                let list    = ["Is", "it", "OK"]
                let (list1, list2)  = breakx({ x in head(x) == "i" }, list)
                expect(list1).to(equal(["Is"]))
                expect(list2).to(equal(["it", "OK"]))
            }
            
            it("String") {
                let list = "Hello World"
                let (list1, list2) = breakx({ x in x == " " }, list)
                expect(list1).to(equal("Hello"))
                expect(list2).to(equal(" World"))
            }
        }
        
        describe("group") {
            it("Int Array") {
                let ints            = [1, 1, 2, 3, 3, 5, 5]
                let result          = group(ints)
                expect(result).to(equal([[1,1],[2],[3,3],[5,5]]))
            }
            
            it("String Array") {
                let list    = ["Apple", "Pie", "Pie"]
                let result  = group(list)
                expect(result).to(equal([["Apple"], ["Pie", "Pie"]]))
            }
            
            it("String") {
                let list = "Hello World"
                let result = group(list)
                expect(result).to(equal(["H","e","ll","o"," ","W","o","r","l","d"]))
            }
        }
        
        describe("inits") {
            it("Int Array") {
                let ints            = [1, 1, 2, 3, 3, 5, 5]
                let result          = inits(ints)
                expect(result).to(equal([[],[1],[1,1],[1,1,2],[1,1,2,3],[1,1,2,3,3],[1,1,2,3,3,5],[1,1,2,3,3,5,5]]))
            }
            
            it("String Array") {
                let list    = ["Apple", "Pie", "Pie"]
                let result  = inits(list)
                expect(result).to(equal([[],["Apple"],["Apple","Pie"],["Apple","Pie","Pie"]]))
            }
            
            it("String") {
                let list = "Hello World"
                let result = inits(list)
                expect(result).to(equal(["","H","He","Hel","Hell","Hello","Hello ","Hello W","Hello Wo","Hello Wor","Hello Worl","Hello World"]))
            }
        }
        
        describe("tails") {
            it("Int Array") {
                let ints            = [1, 1, 2, 3, 3, 5, 5]
                let result          = tails(ints)
                expect(result).to(equal([[1,1,2,3,3,5,5],[1,2,3,3,5,5],[2,3,3,5,5],[3,3,5,5],[3,5,5],[5,5],[5],[]]))
            }
            
            it("String Array") {
                let list    = ["Apple", "Pie", "Pie"]
                let result  = tails(list)
                expect(result).to(equal([["Apple","Pie","Pie"],["Pie","Pie"],["Pie"],[]]))
            }
            
            it("String") {
                let list = "Hello World"
                let result = tails(list)
                expect(result).to(equal(["Hello World","ello World","llo World","lo World","o World"," World","World","orld","rld","ld","d",""]))
            }
        }
        
        describe("isPrefixOf") {
            it("Int Array") {
                let list1            = [1, 1, 2]
                let list2            = [1, 1, 2, 3, 3, 5, 5]
                let list3            = [1, 5]
                expect(isPrefixOf(list1, list2)).to(beTrue())
                expect(isPrefixOf(list1, list3)).to(beFalse())
            }
            
            it("String Array") {
                let list1            = ["Hello"]
                let list2            = ["Hello", "World"]
                let list3            = ["World", "Hello"]
                expect(isPrefixOf(list1, list2)).to(beTrue())
                expect(isPrefixOf(list1, list3)).to(beFalse())
            }
            
            it("String") {
                let list1            = "Hello"
                let list2            = "Hello World"
                let list3            = "World"
                expect(isPrefixOf(list1, list2)).to(beTrue())
                expect(isPrefixOf(list1, list3)).to(beFalse())
            }
        }
        
        describe("isSuffixOf") {
            it("Int Array") {
                let list1            = [3, 5, 5]
                let list2            = [1, 1, 2, 3, 3, 5, 5]
                let list3            = [1, 5]
                expect(isSuffixOf(list1, list2)).to(beTrue())
                expect(isSuffixOf(list1, list3)).to(beFalse())
            }
            
            it("String Array") {
                let list1            = ["Hello"]
                let list2            = ["World", "Hello"]
                let list3            = ["Hello", "World"]
                expect(isSuffixOf(list1, list2)).to(beTrue())
                expect(isSuffixOf(list1, list3)).to(beFalse())
            }
            
            it("String") {
                let list1            = "World"
                let list2            = "Hello World"
                let list3            = "Hello"
                expect(isSuffixOf(list1, list2)).to(beTrue())
                expect(isSuffixOf(list1, list3)).to(beFalse())
            }
        }
        
        describe("isInfixOf") {
            it("Int Array") {
                let list1            = [2, 3, 3]
                let list2            = [1, 1, 2, 3, 3, 5, 5]
                let list3            = [1, 5]
                expect(isInfixOf(list1, list2)).to(beTrue())
                expect(isInfixOf(list1, list3)).to(beFalse())
            }
            
            it("String Array") {
                let list1            = ["Hello"]
                let list2            = ["World", "Hello"]
                let list3            = ["Hello", "World"]
                let list4            = ["Hello!", "World"]
                expect(isInfixOf(list1, list2)).to(beTrue())
                expect(isInfixOf(list1, list3)).to(beTrue())
                expect(isInfixOf(list1, list4)).to(beFalse())
            }
            
            it("String") {
                let list1            = "World"
                let list2            = "Hello World!"
                let list3            = "Hello"
                expect(isInfixOf(list1, list2)).to(beTrue())
                expect(isInfixOf(list1, list3)).to(beFalse())
            }
        }
        
        describe("isSubsequenceOf") {
            it("Int Array") {
                let list1            = [2, 3, 3]
                let list2            = [1, 1, 2, 3, 3, 5, 5]
                let list3            = [1, 5]
                expect(isSubsequenceOf(list1, list2)).to(beTrue())
                expect(isSubsequenceOf(list1, list3)).to(beFalse())
                expect(isSubsequenceOf(list1, list1)).to(beFalse())
            }
            
            it("String Array") {
                let list1            = ["Hello"]
                let list2            = ["World", "Hello"]
                let list3            = ["Hello", "World"]
                let list4            = ["Hello!", "World"]
                expect(isSubsequenceOf(list1, list2)).to(beTrue())
                expect(isSubsequenceOf(list1, list3)).to(beTrue())
                expect(isSubsequenceOf(list1, list4)).to(beFalse())
                expect(isSubsequenceOf(list1, list1)).to(beFalse())
            }
            
            it("String") {
                let list1            = "World"
                let list2            = "Hello World!"
                let list3            = "Hello"
                expect(isSubsequenceOf(list1, list2)).to(beTrue())
                expect(isSubsequenceOf(list1, list3)).to(beFalse())
                expect(isSubsequenceOf(list1, list1)).to(beFalse())
            }
        }
        
        describe("elem") {
            it("Int Array") {
                let list            = [2, 3, 3]
                expect(elem(list, 3)).to(beTrue())
                expect(elem(list, 5)).to(beFalse())
            }
            
            it("String Array") {
                let list            = ["World", "Hello"]
                expect(elem(list, "Hello")).to(beTrue())
                expect(elem(list, "Good")).to(beFalse())
            }
            
            it("String") {
                let list            = "Hello"
                expect(elem(list, "H")).to(beTrue())
                expect(elem(list, "T")).to(beFalse())
            }
        }
        
        describe("notElem") {
            it("Int Array") {
                let list            = [2, 3, 3]
                expect(notElem(list, 3)).to(beFalse())
                expect(notElem(list, 5)).to(beTrue())
            }
            
            it("String Array") {
                let list            = ["World", "Hello"]
                expect(notElem(list, "Hello")).to(beFalse())
                expect(notElem(list, "Good")).to(beTrue())
            }
            
            it("String") {
                let list            = "Hello"
                expect(notElem(list, "H")).to(beFalse())
                expect(notElem(list, "T")).to(beTrue())
            }
        }
       
        describe("lookup") {
            it("Int Array") {
                let list            = ["a": 0, "b": 1]
                expect(lookup("a", list)).to(equal(0))
                expect(lookup("c", list)).to(beNil())
            }
            
            it("String Array") {
                let list            = ["firstname": "tom", "lastname": "sawyer"]
                expect(lookup("firstname", list)).to(equal("tom"))
                expect(lookup("middlename", list)).to(beNil())
            }
        }
       
        describe("find") {
            it("Int Array") {
                let list             = [1, 2, 3, 4, 5]
                let greaterThanThree = { x in x > 3 }
                let result           = find(greaterThanThree, list)
                expect(result).to(equal(4))
            }
            
            it("String Array") {
                let isSwift         = { (x : String) in x.lowercaseString.hasSuffix("swift") }
                let swiftFilter     = { xs in find(isSwift, xs) }
                let swiftFile       = swiftFilter(files)
                expect(swiftFile).to(equal("Haskell.swift"))
            }
            
            it("String") {
                let isA             = { (x : Character) in x == "a" }
                let isAFilter       = { (xs : String) in filter(isA, xs) }
                let result          = isAFilter("ABCDa")
                expect(result).to(equal("a"))
            }
        }
        
        describe("filter") {
            it("Int Array") {
                let list             = [1, 2, 3, 4, 5]
                let greaterThanThree = { x in x > 3 }
                let result           = filter(greaterThanThree, list)
                expect(result).to(equal([4, 5]))
            }
            
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
        
        describe("partition") {
            it("Int Array") {
                let list             = [1, 2, 3, 4, 5]
                let greaterThanThree = { x in x > 3 }
                let (r0, r1)         = partition(greaterThanThree, list)
                expect(r0).to(equal([4, 5]))
                expect(r1).to(equal([1, 2, 3]))
            }
            
            it("String Array") {
                let isSwift             = { (x : String) in x.lowercaseString.hasSuffix("swift") }
                let (r0, r1)            = partition(isSwift, files)
                expect(r0).to(equal(["Haskell.swift", "HaskellTests.swift", "HaskellSwift.swift"]))
                expect(r1).to(equal(["README.md"]))
            }
            
            it("String") {
                let isA                 = { (x : Character) in x == "a" }
                let (r0, r1)            = partition(isA, "ABCDa")
                expect(r0).to(equal("a"))
                expect(r1).to(equal("ABCD"))
            }
        }
        
        describe("elemIndex") {
            it("Int Array") {
                let list             = [1, 2, 3, 4, 5]
                expect(elemIndex(1, list)).to(equal(0))
                expect(elemIndex(2, list)).to(equal(1))
                expect(elemIndex(10, list)).to(beNil())
            }
            
            it("String Array") {
                let words  = ["Window", "Help", "Window"]
                expect(elemIndex("Window", words)).to(equal(0))
                expect(elemIndex("Help", words)).to(equal(1))
                expect(elemIndex("Debug", words)).to(beNil())
            }
            
            it("String") {
                let word = "Window"
                expect(elemIndex("W", word)).to(equal(0))
                expect(elemIndex("i", word)).to(equal(1))
                expect(elemIndex("T", word)).to(beNil())
            }
        }
        
        describe("elemIndices") {
            it("Int Array") {
                let list             = [1, 2, 3, 4, 3]
                expect(elemIndices(1, list)).to(equal([0]))
                expect(elemIndices(3, list)).to(equal([2,4]))
                expect(elemIndices(10, list)).to(equal([Int]()))
            }
            
            it("String Array") {
                let words  = ["Window", "Help", "Window"]
                expect(elemIndices("Help", words)).to(equal([1]))
                expect(elemIndices("Window", words)).to(equal([0, 2]))
                expect(elemIndices("D", words)).to(equal([Int]()))
            }
            
            it("String") {
                let word = "WINDOW"
                expect(elemIndices("W", word)).to(equal([0, 5]))
                expect(elemIndices("I", word)).to(equal([1]))
                expect(elemIndices("T", word)).to(equal([Int]()))            }
        }
        
        describe("findIndex") {
            it("Int Array") {
                let list             = [1, 2, 3, 4, 5]
                let greaterThanThree = { x in x > 3 }
                let result           = findIndex(greaterThanThree, list)
                expect(result).to(equal(3))
            }
            
            it("String Array") {
                let isSwift         = { (x : String) in x.lowercaseString.hasSuffix("swift") }
                let swiftFile       = findIndex(isSwift, files)
                expect(swiftFile).to(equal(1))
            }
            
            it("String") {
                let isA             = { (x : Character) in x == "a" }
                let result          =  findIndex(isA, "ABCDa")
                expect(result).to(equal(4))
            }
        }
        
        describe("findIndices") {
            it("Int Array") {
                let list             = [1, 2, 3, 4, 5]
                let greaterThanThree = { x in x > 3 }
                let result           = findIndices(greaterThanThree, list)
                expect(result).to(equal([3, 4]))
            }
            
            it("String Array") {
                let isSwift         = { (x : String) in x.lowercaseString.hasSuffix("swift") }
                let swiftFile       = findIndices(isSwift, files)
                expect(swiftFile).to(equal([1, 2, 3]))
            }
            
            it("String") {
                let isA             = { (x : Character) in x == "a" }
                let result          =  findIndices(isA, "ABCDa")
                expect(result).to(equal([4]))
            }
        }
        
        describe("zip") {
            it("Int Array") {
                let tuples          = zip([1, 2, 3], [1, 4, 9])
                let expectedTuples  = [(1, 1), (2, 4), (3, 9)]
                let result          = compareTupleArray(tuples, expectedTuples)
                expect(result).to(beTrue())
            }
            
            it("String Array") {
                let tuples          = zip(["1", "2", "3"], [".swift", ".o", ".cpp"])
                let expectedTuples  = [("1", ".swift"), ("2", ".o"), ("3",".cpp")]
                let result          = compareTupleArray(tuples, expectedTuples)
                expect(result).to(beTrue())
            }
            
            it("String Array - Int") {
                let tuples          = zip([1, 2, 3], [".swift", ".o", ".cpp"])
                let expectedTuples  = [(1, ".swift"), (2, ".o"), (3, ".cpp")]
                let result          = compareTupleArray(tuples, expectedTuples)
                expect(result).to(beTrue())
            }
        }
        
        describe("zip3") {
            it("Int Array") {
                let tuples          = zip3([1, 2, 3], [1, 4, 9], [1, 8, 27])
                let expectedTuples  = [(1, 1, 1), (2, 4, 8), (3, 9, 27)]
                let result          = compareTupleArray(tuples, expectedTuples)
                expect(result).to(beTrue())
            }
            
            it("String Array") {
                let tuples          = zip3(["1", "2", "3"], [".", ".", ".", "." ], ["swift", "o", "cpp"])
                let expectedTuples  = [("1", ".", "swift"), ("2", ".", "o"), ("3", ".", "cpp")]
                let result          = compareTupleArray(tuples, expectedTuples)
                expect(result).to(beTrue())
            }
            
            it("String Array - Int") {
                let tuples          = zip3([1, 2, 3], [".", ".", ".", "." ], ["swift", "o", "cpp"])
                let expectedTuples  = [(1, ".", "swift"), (2, ".", "o"), (3, ".", "cpp")]
                let result          = compareTupleArray(tuples, expectedTuples)
                expect(result).to(beTrue())
            }
        }
        
        describe("zip4") {
            it("Int Array") {
                let tuples          = zip4([1, 2, 3], [1, 4, 9], [1, 8, 27], [1, 2, 3])
                let expectedTuples  = [(1,1,1,1),(2,4,8,2),(3,9,27,3)]
                let result          = compareTupleArray(tuples, expectedTuples)
                expect(result).to(beTrue())
            }
            
            it("String Array") {
                let tuples          = zip4(["1", "2", "3"], [".", ".", ".", "." ], ["swift", "o", "cpp"], ["1", "2", "3"])
                let expectedTuples  = [("1",".","swift","1"),("2",".","o","2"),("3",".","cpp","3")]
                let result          = compareTupleArray(tuples, expectedTuples)
                expect(result).to(beTrue())
            }
            
            it("String Array - Int") {
                let tuples          = zip4([1, 2, 3], [".", ".", ".", "." ], ["swift", "o", "cpp"], [1, 2, 3])
                let expectedTuples  = [(1,".","swift",1),(2,".","o",2),(3,".","cpp",3)]
                let result          = compareTupleArray(tuples, expectedTuples)
                expect(result).to(beTrue())
            }
        }
        
        describe("zip5") {
            it("Int Array") {
                let tuples          = zip5([1, 2, 3], [1, 4, 9], [1, 8, 27], [1, 2, 3], [1, 4, 9])
                let expectedTuples  = [(1,1,1,1,1),(2,4,8,2,4),(3,9,27,3,9)]
                let result          = compareTupleArray(tuples, expectedTuples)
                expect(result).to(beTrue())
            }
            
            it("String Array") {
                let tuples          = zip5(["1", "2", "3"], [".", ".", ".", "." ], ["swift", "o", "cpp"], ["1", "2", "3"], [".", ".", ".", "." ])
                let expectedTuples  = [("1",".","swift","1","."),("2",".","o","2","."),("3",".","cpp","3",".")]
                let result          = compareTupleArray(tuples, expectedTuples)
                expect(result).to(beTrue())
            }
            
            it("String Array - Int") {
                let tuples          = zip5([1, 2, 3], [".", ".", ".", "." ], ["swift", "o", "cpp"], [1, 2, 3], [1, 4, 9])
                let expectedTuples  = [(1,".","swift",1,1),(2,".","o",2,4),(3,".","cpp",3,9)]
                let result          = compareTupleArray(tuples, expectedTuples)
                expect(result).to(beTrue())
            }
        }
        
        describe("zip6") {
            it("Int Array") {
                let tuples          = zip6([1, 2, 3], [1, 4, 9], [1, 8, 27], [1, 2, 3], [1, 4, 9], [1, 8, 27])
                let expectedTuples  = [(1,1,1,1,1,1),(2,4,8,2,4,8),(3,9,27,3,9,27)]
                let result          = compareTupleArray(tuples, expectedTuples)
                expect(result).to(beTrue())
            }
            
            it("String Array") {
                let tuples          = zip6(["1", "2", "3"], [".", ".", ".", "." ], ["swift", "o", "cpp"], ["1", "2", "3"], [".", ".", ".", "." ], ["swift", "o", "cpp"])
                let expectedTuples  = [("1",".","swift","1",".","swift"),("2",".","o","2",".","o"),("3",".","cpp","3",".","cpp")]
                let result          = compareTupleArray(tuples, expectedTuples)
                expect(result).to(beTrue())
            }
            
            it("String Array - Int") {
                let tuples          = zip6([1, 2, 3], [".", ".", ".", "." ], ["swift", "o", "cpp"], [1, 2, 3], [1, 4, 9], [1, 8, 27])
                let expectedTuples  = [(1,".","swift",1,1,1),(2,".","o",2,4,8),(3,".","cpp",3,9,27)]
                let result          = compareTupleArray(tuples, expectedTuples)
                expect(result).to(beTrue())
            }
        }
        
        describe("zip7") {
            it("Int Array") {
                let tuples          = zip7([1, 2, 3], [1, 4, 9], [1, 8, 27], [1, 2, 3], [1, 4, 9], [1, 8, 27], [1, 2, 3])
                let expectedTuples  = [(1,1,1,1,1,1,1),(2,4,8,2,4,8,2),(3,9,27,3,9,27,3)]
                let result          = compareTupleArray(tuples, expectedTuples)
                expect(result).to(beTrue())
            }
            
            it("String Array") {
                let tuples          = zip7(["1", "2", "3"], [".", ".", ".", "." ], ["swift", "o", "cpp"], ["1", "2", "3"], [".", ".", ".", "." ], ["swift", "o", "cpp"], ["1", "2", "3"])
                let expectedTuples  = [("1",".","swift","1",".","swift","1"),("2",".","o","2",".","o","2"),("3",".","cpp","3",".","cpp","3")]
                let result          = compareTupleArray(tuples, expectedTuples)
                expect(result).to(beTrue())
            }
            
            it("String Array - Int") {
                let tuples          = zip7([1, 2, 3], [".", ".", ".", "." ], ["swift", "o", "cpp"], [1, 2, 3], [1, 4, 9], [1, 8, 27], [1, 2, 3])
                let expectedTuples  = [(1,".","swift",1,1,1,1),(2,".","o",2,4,8,2),(3,".","cpp",3,9,27,3)]
                let result          = compareTupleArray(tuples, expectedTuples)
                expect(result).to(beTrue())
            }
        }
        
        describe("zipWith") {
            it("Int Array") {
                let result          = zipWith((+), [1, 2, 3], [1, 4, 9])
                expect(result).to(equal([2,6,12]))
            }
            
            it("String Array") {
                let result          = zipWith( (+), ["1", "2", "3"], [".swift", ".o", ".cpp"])
                expect(result).to(equal(["1.swift","2.o","3.cpp"]))
            }
            
            it("String Array - Int") {
                let result          = zipWith( { x, y in String(x) + y }, [1, 2, 3], [".swift", ".o", ".cpp"])
                expect(result).to(equal(["1.swift","2.o","3.cpp"]))
            }
        }
        
        describe("zipWith3") {
            it("Int Array") {
                let result          = zipWith3({(x, y, z) in x+y+z}, [1, 2, 3], [1, 4, 9], [1, 8, 27])
                expect(result).to(equal([3,14,39]))
            }
            
            it("String Array") {
                let result          = zipWith3({x, y, z in x+y+z }, ["1", "2", "3"], [".swift", ".o", ".cpp"],[".1", ".2", ".3"])
                expect(result).to(equal(["1.swift.1","2.o.2","3.cpp.3"]))
            }
            
            it("String Array - Int") {
                let result          = zipWith3( { x, y, z in String(x)+y+z }, [1, 2, 3], [".swift", ".o", ".cpp"], [".1", ".2", ".3"])
                expect(result).to(equal(["1.swift.1","2.o.2","3.cpp.3"]))
            }
        }
        
        describe("zipWith4") {
            it("Int Array") {
                let process         = {(a: Int, b: Int, c: Int, d: Int) -> Int in a+b+c+d}
                let result          = zipWith4(process, [1, 2, 3], [1, 4, 9], [1, 8, 27], [1, 2, 3])
                expect(result).to(equal([4,16,42]))
            }
            
            it("String Array") {
                let process         = {a,b,c,d-> String in a+b+c+d}
                let result          = zipWith4(process, ["1", "2", "3"], [".", ".", ".", "." ], ["swift", "o", "cpp"], ["1", "2", "3"])
                expect(result).to(equal(["1.swift1","2.o2","3.cpp3"]))
            }
            
            it("String Array - Int") {
                let process         = {(a: Int,b: String,c: String,d: String) -> String in String(a)+b+c+d}
                let result          = zipWith4(process, [1, 2, 3], [".", ".", ".", "." ], ["swift", "o", "cpp"], ["1", "2", "3"])
                expect(result).to(equal(["1.swift1","2.o2","3.cpp3"]))
            }
        }
        
        describe("zipWith5") {
            it("Int Array") {
                let process         = {(a: Int, b: Int, c: Int, d: Int, e: Int) -> Int in a+b+c+d+e}
                let result          = zipWith5(process, [1, 2, 3], [1, 4, 9], [1, 8, 27], [1, 2, 3], [1, 4, 9])
                expect(result).to(equal([5,20,51]))
            }
            
            it("String Array") {
                let process         = {a,b,c,d,e-> String in a+b+c+d+e}
                let result          = zipWith5(process, ["1", "2", "3"], [".", ".", ".", "." ], ["swift", "o", "cpp"], ["1", "2", "3"], [".", ".", ".", "." ])
                expect(result).to(equal(["1.swift1.","2.o2.","3.cpp3."]))
            }
            
            it("String Array - Int") {
                let process         = {(a: Int,b: String,c: String,d: String,e: String) -> String in String(a)+b+c+d+e}
                let result          = zipWith5(process, [1, 2, 3], [".", ".", ".", "." ], ["swift", "o", "cpp"], ["1", "2", "3"], [".", ".", ".", "." ])
                expect(result).to(equal(["1.swift1.","2.o2.","3.cpp3."]))
            }
        }
        
        describe("zipWith6") {
            it("Int Array") {
                let process         = {(a: Int, b: Int, c: Int, d: Int, e: Int, f: Int) -> Int in a+b+c+d+e+f}
                let result          = zipWith6(process, [1, 2, 3], [1, 4, 9], [1, 8, 27], [1, 2, 3], [1, 4, 9], [1, 8, 27])
                expect(result).to(equal([6,28,78]))
            }
            
            it("String Array") {
                let process         = {a,b,c,d,e,f-> String in a+b+c+d+e+f}
                let result          = zipWith6(process, ["1", "2", "3"], [".", ".", ".", "." ], ["swift", "o", "cpp"], ["1", "2", "3"], [".", ".", ".", "." ], ["swift", "o", "cpp"])
                expect(result).to(equal(["1.swift1.swift","2.o2.o","3.cpp3.cpp"]))
            }
            
            it("String Array - Int") {
                let process         = {(a: Int,b: String,c: String,d: String,e: String,f: String) -> String in String(a)+b+c+d+e+f}
                let result          = zipWith6(process, [1, 2, 3], [".", ".", ".", "." ], ["swift", "o", "cpp"], ["1", "2", "3"], [".", ".", ".", "." ], ["swift", "o", "cpp"])
                expect(result).to(equal(["1.swift1.swift","2.o2.o","3.cpp3.cpp"]))
            }
        }
        
        describe("zipWith7") {
            it("Int Array") {
                let process         = {(a: Int, b: Int, c: Int, d: Int, e: Int, f: Int, g: Int) -> Int in a+b+c+d+e+f+g}
                let result          = zipWith7(process, [1, 2, 3], [1, 4, 9], [1, 8, 27], [1, 2, 3], [1, 4, 9], [1, 8, 27], [2, 4, 6])
                expect(result).to(equal([8,32,84]))
            }
            
            it("String Array") {
                let process         = {a,b,c,d,e,f,g -> String in a+b+c+d+e+f+g}
                let result          = zipWith7(process, ["1", "2", "3"], [".", ".", ".", "." ], ["swift", "o", "cpp"], ["1", "2", "3"], [".", ".", ".", "." ], ["swift", "o", "cpp"], ["1", "2", "3"])
                expect(result).to(equal(["1.swift1.swift1","2.o2.o2","3.cpp3.cpp3"]))
            }

            it("String Array - Int") {
                let process         = {(a: Int,b: String,c: String,d: String,e: String,f: String,g: String) -> String in String(a)+b+c+d+e+f+g}
                let result          = zipWith7(process, [1, 2, 3], [".", ".", ".", "." ], ["swift", "o", "cpp"], ["1", "2", "3"], [".", ".", ".", "." ], ["swift", "o", "cpp"], ["1", "2", "3"])
                expect(result).to(equal(["1.swift1.swift1","2.o2.o2","3.cpp3.cpp3"]))
            }
        }
        
        describe("unzip") {
            it("Int Array") {
                let (r0, r1)        = unzip([(1, 1), (2, 4), (3, 9)])
                expect(r0).to(equal([1, 2, 3]))
                expect(r1).to(equal([1, 4, 9]))
            }
            
            it("String Array") {
                let (r0, r1)        = unzip([("1", ".swift"), ("2", ".o"), ("3",".cpp")])
                expect(r0).to(equal(["1", "2", "3"]))
                expect(r1).to(equal([".swift", ".o", ".cpp"]))
            }
            
            it("String Array - Int") {
                let (r0, r1)        = unzip([(1, ".swift"), (2, ".o"), (3, ".cpp")])
                expect(r0).to(equal([1, 2, 3]))
                expect(r1).to(equal([".swift", ".o", ".cpp"]))
            }
        }

        describe("unzip3") {
            it("Int Array") {
                let (r0, r1, r2)        = unzip3([(1,1,1),(2,4,8),(3,9,27)])
                expect(r0).to(equal([1, 2, 3]))
                expect(r1).to(equal([1, 4, 9]))
                expect(r2).to(equal([1, 8, 27]))
            }
            
            it("String Array") {
                let (r0, r1, r2)        = unzip3([("1",".","swift"),("2",".","o"),("3",".","cpp")])
                expect(r0).to(equal(["1", "2", "3"]))
                expect(r1).to(equal([".", ".", "." ]))
                expect(r2).to(equal(["swift", "o", "cpp"]))
            }
            
            it("String Array - Int") {
                let (r0, r1, r2)        = unzip3([(1,".","swift"),(2,".","o"),(3,".","cpp")])
                expect(r0).to(equal([1, 2, 3]))
                expect(r1).to(equal([".", ".", "." ]))
                expect(r2).to(equal(["swift", "o", "cpp"]))
            }
        }
        
        describe("unzip4") {
            it("Int Array") {
                let (r0, r1, r2, r3)        = unzip4([(1,1,1,1),(2,4,8,2),(3,9,27,3)])
                expect(r0).to(equal([1, 2, 3]))
                expect(r1).to(equal([1, 4, 9]))
                expect(r2).to(equal([1, 8, 27]))
                expect(r3).to(equal([1, 2, 3]))
            }
            
            it("String Array") {
                let (r0, r1, r2, r3)        = unzip4([("1",".","swift","1"),("2",".","o","2"),("3",".","cpp","3")])
                expect(r0).to(equal(["1", "2", "3"]))
                expect(r1).to(equal([".", ".", "." ]))
                expect(r2).to(equal(["swift", "o", "cpp"]))
                expect(r3).to(equal(["1", "2", "3"]))
            }
            
            it("String Array - Int") {
                let (r0, r1, r2, r3)        = unzip4([(1,".","swift",1),(2,".","o",2),(3,".","cpp",3)])
                expect(r0).to(equal([1, 2, 3]))
                expect(r1).to(equal([".", ".", "." ]))
                expect(r2).to(equal(["swift", "o", "cpp"]))
                expect(r3).to(equal([1, 2, 3]))
            }
        }
        
        describe("unzip5") {
            it("Int Array") {
                let (r0, r1, r2, r3, r4)        = unzip5([(1,1,1,1,1),(2,4,8,2,4),(3,9,27,3,9)])
                expect(r0).to(equal([1, 2, 3]))
                expect(r1).to(equal([1, 4, 9]))
                expect(r2).to(equal([1, 8, 27]))
                expect(r3).to(equal([1, 2, 3]))
                expect(r4).to(equal([1, 4, 9]))
            }
            
            it("String Array") {
                let (r0, r1, r2, r3, r4)        = unzip5([("1",".","swift","1","."),("2",".","o","2","."),("3",".","cpp","3",".")])
                expect(r0).to(equal(["1", "2", "3"]))
                expect(r1).to(equal([".", ".", "." ]))
                expect(r2).to(equal(["swift", "o", "cpp"]))
                expect(r3).to(equal(["1", "2", "3"]))
                expect(r4).to(equal( [".", ".", "." ]))
            }
            
            it("String Array - Int") {
                let (r0, r1, r2, r3, r4)        = unzip5([(1,".","swift",1,1),(2,".","o",2,4),(3,".","cpp",3,9)])
                expect(r0).to(equal([1, 2, 3]))
                expect(r1).to(equal([".", ".", "." ]))
                expect(r2).to(equal(["swift", "o", "cpp"]))
                expect(r3).to(equal([1, 2, 3]))
                expect(r4).to(equal([1, 4, 9]))
            }
        }
       
        describe("unzip6") {
            it("Int Array") {
                let (r0, r1, r2, r3, r4, r5)        = unzip6([(1,1,1,1,1,1),(2,4,8,2,4,8),(3,9,27,3,9,27)])
                expect(r0).to(equal([1, 2, 3]))
                expect(r1).to(equal([1, 4, 9]))
                expect(r2).to(equal([1, 8, 27]))
                expect(r3).to(equal([1, 2, 3]))
                expect(r4).to(equal([1, 4, 9]))
                expect(r5).to(equal([1, 8, 27]))
            }
            
            it("String Array") {
                let (r0, r1, r2, r3, r4, r5)        = unzip6([("1",".","swift","1",".","swift"),("2",".","o","2",".","o"),("3",".","cpp","3",".","cpp")])
                expect(r0).to(equal(["1", "2", "3"]))
                expect(r1).to(equal([".", ".", "." ]))
                expect(r2).to(equal(["swift", "o", "cpp"]))
                expect(r3).to(equal(["1", "2", "3"]))
                expect(r4).to(equal( [".", ".", "." ]))
                expect(r5).to(equal(["swift", "o", "cpp"]))
            }
            
            it("String Array - Int") {
                let (r0, r1, r2, r3, r4, r5)        = unzip6([(1,".","swift",1,1,1),(2,".","o",2,4,8),(3,".","cpp",3,9,27)])
                expect(r0).to(equal([1, 2, 3]))
                expect(r1).to(equal([".", ".", "." ]))
                expect(r2).to(equal(["swift", "o", "cpp"]))
                expect(r3).to(equal([1, 2, 3]))
                expect(r4).to(equal([1, 4, 9]))
                expect(r5).to(equal([1, 8, 27]))
            }
        }
        
        describe("unzip7") {
            it("Int Array") {
                let (r0, r1, r2, r3, r4, r5, r6)        = unzip7([(1,1,1,1,1,1,1),(2,4,8,2,4,8,2),(3,9,27,3,9,27,3)])
                expect(r0).to(equal([1, 2, 3]))
                expect(r1).to(equal([1, 4, 9]))
                expect(r2).to(equal([1, 8, 27]))
                expect(r3).to(equal([1, 2, 3]))
                expect(r4).to(equal([1, 4, 9]))
                expect(r5).to(equal([1, 8, 27]))
                expect(r6).to(equal([1, 2, 3]))
            }
            
            it("String Array") {
                let (r0, r1, r2, r3, r4, r5, r6)        = unzip7([("1",".","swift","1",".","swift","1"),("2",".","o","2",".","o","2"),("3",".","cpp","3",".","cpp","3")])
                expect(r0).to(equal(["1", "2", "3"]))
                expect(r1).to(equal([".", ".", "." ]))
                expect(r2).to(equal(["swift", "o", "cpp"]))
                expect(r3).to(equal(["1", "2", "3"]))
                expect(r4).to(equal( [".", ".", "." ]))
                expect(r5).to(equal(["swift", "o", "cpp"]))
                expect(r6).to(equal(["1", "2", "3"]))
            }
            
            it("String Array - Int") {
                let (r0, r1, r2, r3, r4, r5, r6)        = unzip7([(1,".","swift",1,1,1,1),(2,".","o",2,4,8,2),(3,".","cpp",3,9,27,3)])
                expect(r0).to(equal([1, 2, 3]))
                expect(r1).to(equal([".", ".", "." ]))
                expect(r2).to(equal(["swift", "o", "cpp"]))
                expect(r3).to(equal([1, 2, 3]))
                expect(r4).to(equal([1, 4, 9]))
                expect(r5).to(equal([1, 8, 27]))
                expect(r6).to(equal([1, 2, 3]))
            }
        }
        
        describe("lines") {
            it("String") {
                let result = lines("Functions\n\n\n don't evaluate their arguments.")
                expect(result).to(equal(["Functions","",""," don't evaluate their arguments."]))
            }
        }
        
        describe("words") {
            it("String") {
                let result = words("Functions\n\n\n don't evaluate their arguments.")
                expect(result).to(equal(["Functions","don't","evaluate","their","arguments."]))
            }
        }
        
        describe("unlines") {
            it("String") {
                let result = unlines(["Functions","",""," don't evaluate their arguments."]) //()
                expect(result).to(equal("Functions\n\n\n don't evaluate their arguments."))
            }
        }
        
        describe("unwords") {
            it("String") {
                let result = unwords(["Functions","don't","evaluate","their","arguments."])
                expect(result).to(equal("Functions don't evaluate their arguments."))
            }
        }
        
        describe("nub") {
            it("Int Array") {
                let result  = nub([1, 1, 2, 4, 1, 3, 9])
                expect(result).to(equal([1,2,4,3,9]))
            }
            
            it("String Array") {
                let result  = nub(["Create", "Set", "Any", "Set", "Any"])
                expect(result).to(equal(["Create","Set","Any"]))
            }
        }
        
        describe("delete") {
            it("Int Array") {
                let list    = [1, 1, 2, 4, 1, 3, 9]
                expect(delete(2, list)).to(equal([1,1,4,1,3,9]))
                expect(delete(1, list)).to(equal([1,2,4,1,3,9]))
            }
            
            it("String Array") {
                let list    = ["Create", "Set", "Any", "Set", "Any"]
                expect(delete("Set", list)).to(equal(["Create","Any","Set","Any"]))
                expect(delete("Any", list)).to(equal(["Create","Set","Set","Any"]))
            }
        }
        
        describe("union") {
            it("Int Array") {
                let list1   = [1, 1, 2]
                let list2   = [4, 1, 3, 9]
                expect(union(list1, list2)).to(equal([1, 2, 4, 3, 9]))
            }
            
            it("String Array") {
                let list1   = ["Create", "Set"]
                let list2   = ["Any", "Set", "Any"]
                expect(union(list1, list2)).to(equal(["Create","Set", "Any"]))
            }
        }
        
        describe("intersect") {
            it("Int Array") {
                let list1   = [1, 1, 2]
                let list2   = [4, 1, 3, 9]
                expect(intersect(list1, list2)).to(equal([1, 1]))
            }
            
            it("String Array") {
                let list1   = ["Create", "Set", "Set"]
                let list2   = ["Any", "Set", "Any"]
                expect(intersect(list1, list2)).to(equal(["Set", "Set"]))
            }
        }
       
        describe("sortOn") {
            it("Int Array") {
                let list    = [1, 1, 2, 4, 1, 3, 9]
                expect(sort(list)).to(equal([1, 1, 1, 2, 3, 4, 9]))
            }
            
            it("String Array") {
                let list    = ["Create", "Set", "Any", "Set", "Any"]
                expect(sort(list)).to(equal(["Any", "Any", "Create", "Set", "Set"]))
            }
        }
        
        describe("sortOn") {
            it("Int Array") {
                let list    = [1, 1, 2, 4, 1, 3, 9]
                expect(sortOn({x, y in x < y}, list)).to(equal([1, 1, 1, 2, 3, 4, 9]))
                expect(sortOn({x, y in x < y}, list)).to(equal([9,4,3,2,1,1,1]))
            }
            
            it("String Array") {
                let list    = ["Create", "Set", "Any", "Set", "Any"]
                expect(sortOn({x, y in x < y}, list)).to(equal(["Any", "Any", "Create", "Set", "Set"]))
                expect(sortOn({x, y in x < y}, list)).to(equal(["Set","Set","Create","Any","Any"]))
            }
        }
    }
}
