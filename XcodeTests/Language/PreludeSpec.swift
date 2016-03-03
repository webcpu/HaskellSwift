//
//  PreludeSpec.swift
//  HaskellSwift
//
//  Created by Liang on 02/03/2016.
import Foundation
import Quick
import Nimble
@testable import HaskellSwift

class PreludeSpec: QuickSpec {
    override func spec() {
        //MARK: succ
        describe("succ") {
            it("Int") {
                let x = Int(1)
                let y = succ(x)
                expect(y).to(equal(x+1))
            }
            
            it("Int8") {
                let x = Int8(1)
                let y = succ(Int8(1))
                expect(y).to(equal(x+1))
            }
            
            it("Int16") {
                let x = Int16(1)
                let y = succ(Int16(1))
                expect(y).to(equal(x+1))
            }
            
            it("Int32") {
                let x = Int32(1)
                let y = succ(Int32(1))
                expect(y).to(equal(x+1))
            }
            
            it("Int64") {
                let x = Int64(1)
                let y = succ(Int64(1))
                expect(y).to(equal(x+1))
            }
            
            it("UInt") {
                let x = UInt16(1)
                let y = succ(UInt16(1))
                expect(y).to(equal(x+1))
            }
            
            it("UInt8") {
                let x = UInt8(1)
                let y = succ(UInt8(1))
                expect(y).to(equal(x+1))
            }

            it("UInt16") {
                let x = UInt16(1)
                let y = succ(UInt16(1))
                expect(y).to(equal(x+1))
            }

            it("UInt32") {
                let x = UInt32(1)
                let y = succ(UInt32(1))
                expect(y).to(equal(x+1))
            }

            it("UInt64") {
                let x = UInt64(1)
                let y = succ(UInt64(1))
                expect(y).to(equal(x+1))
            }

            it("Character") {
                let x = Character("a")
                let y = succ(x)
                expect(y).to(equal("b"))
            }
        }

        //MARK: pred
        describe("pred") {
            it("Int") {
                let x = Int(1)
                let y = pred(x)
                expect(y).to(equal(x-1))
            }

            it("Int8") {
                let x = Int8(1)
                let y = pred(Int8(1))
                expect(y).to(equal(x-1))
            }

            it("Int16") {
                let x = Int16(1)
                let y = pred(Int16(1))
                expect(y).to(equal(x-1))
            }

            it("Int32") {
                let x = Int32(1)
                let y = pred(Int32(1))
                expect(y).to(equal(x-1))
            }

            it("Int64") {
                let x = Int64(1)
                let y = pred(Int64(1))
                expect(y).to(equal(x-1))
            }

            it("UInt") {
                let x = UInt16(1)
                let y = pred(UInt16(1))
                expect(y).to(equal(x-1))
            }

            it("UInt8") {
                let x = UInt8(1)
                let y = pred(UInt8(1))
                expect(y).to(equal(x-1))
            }

            it("UInt16") {
                let x = UInt16(1)
                let y = pred(UInt16(1))
                expect(y).to(equal(x-1))
            }

            it("UInt32") {
                let x = UInt32(1)
                let y = pred(UInt32(1))
                expect(y).to(equal(x-1))
            }

            it("UInt64") {
                let x = UInt64(1)
                let y = pred(UInt64(1))
                expect(y).to(equal(x-1))
            }

            it("Character") {
                let x = Character("b")
                let y = pred(x)
                expect(y).to(equal("a"))
            }

            //special case
            it("Character-UnicodeScalar(0)") {
                let x = Character(UnicodeScalar(0))
                let y = pred(x)
                expect(y).to(equal(x))
            }
        }

        //MARK: enumFromTo
        describe("enumFromTo") {
            it("Int") {
                let xs = enumFromTo(1, 3)
                expect(xs).to(equal([1, 2, 3]))
            }
            
            it("Int8") {
                let xs = enumFromTo(Int8(1), Int8(3))
                let ys: [Int8] = [1, 2, 3]
                expect(xs).to(equal(ys))
            }
            
            it("Int16") {
                let xs = enumFromTo(Int16(1), Int16(3))
                let ys: [Int16] = [1, 2, 3]
                expect(xs).to(equal(ys))
            }
            
            it("Int32") {
                let xs = enumFromTo(Int32(1), Int32(3))
                let ys: [Int32] = [1, 2, 3]
                expect(xs).to(equal(ys))
            }
            
            it("Int64") {
                let xs = enumFromTo(Int64(1), Int64(3))
                let ys: [Int64] = [1, 2, 3]
                expect(xs).to(equal(ys))
            }
            
            it("UInt") {
                let xs = enumFromTo(UInt(1), UInt(3))
                expect(xs).to(equal([1, 2, 3]))
            }
            
            it("UInt8") {
                let xs = enumFromTo(UInt8(1), UInt8(3))
                let ys: [UInt8] = [1, 2, 3]
                expect(xs).to(equal(ys))
            }
            
            it("UInt16") {
                let xs = enumFromTo(UInt16(1), UInt16(3))
                let ys: [UInt16] = [1, 2, 3]
                expect(xs).to(equal(ys))
            }
            
            it("UInt32") {
                let xs = enumFromTo(UInt32(1), UInt32(3))
                let ys: [UInt32] = [1, 2, 3]
                expect(xs).to(equal(ys))
            }
            
            it("UInt64") {
                let xs = enumFromTo(UInt64(1), UInt64(3))
                let ys: [UInt64] = [1, 2, 3]
                expect(xs).to(equal(ys))
            }
            
            it("Character a -> z") {
                let xs = enumFromTo(Character("a"), Character("c"))
                let ys = "abc"
                expect(xs).to(equal(ys))
            }
            
            it("Character a -> a") {
                let xs = enumFromTo(Character("a"), Character("a"))
                let ys = "a"
                expect(xs).to(equal(ys))
            }

            it("Character z -> a") {
                let xs = enumFromTo(Character("z"), Character("a"))
                let ys = ""
                expect(xs).to(equal(ys))
            }
        }

        //MARK: until
        describe("until") {
            it("Int") {
                let condition = { x in
                    return x > 10
                }

                let process  = { x in
                    return x + 1
                }

                let x = until(condition, process, 0)
                expect(x).to(equal(11))
            }

            it("tuple") {
                let condition = { (t: (name: String, age: Int))  in
                    return t.age > 10
                }

                let process  = { (t: (String, Int)) in
                    return (t.0, t.1 + 1)
                }

                let t = until(condition, process, ("Jack", 0))
                expect(t.0).to(equal("Jack"))
                expect(t.1).to(equal(11))
            }
        }

        //MARK: - Integer
        //MARK: div
        describe("div") {
            it("Int") {
                let x = div(7, 3)
                expect(x).to(equal(2))
            }
        }

        //MARK: mod
        describe("mod") {
            it("Int") {
                let x = mod(7, 3)
                expect(x).to(equal(1))
            }
        }

        //MARK: divMod
        describe("divMod") {
            it("Int") {
                let t = divMod(7, 3)
                expect(t.0).to(equal(2))
                expect(t.1).to(equal(1))
            }
        }

        //MARK: - Numberic
        //MARK: even
        describe("even") {
            it("Int") {
                expect(even(1)).to(equal(false))
                expect(even(2)).to(equal(true))
            }
        }

        //MARK: odd
        describe("odd") {
            it("Int") {
                expect(odd(2)).to(equal(false))
                expect(odd(1)).to(equal(true))
            }
        }
    }
}