//
//  Data.List.QuickCheck.swift
//  HaskellSwift
//
//  Created by Liang on 08/11/2015.
//  Copyright © 2015 Liang. All rights reserved.
//

import Quick
import Nimble
import SwiftCheck
@testable import HaskellSwift

class DataListQuickCheck: QuickSpec {
    override func spec() {
        describe("++") {
            it("QuickCheck") {
                func isEqual<A : Equatable>(xs0 : ArrayOf<A>, _ xs1: ArrayOf<A>) -> Bool {
                    return (xs0.getArray + xs1.getArray) == (xs0.getArray ++ xs1.getArray)
                }
                
                property("[Int]") <- forAll { (xs0 : ArrayOf<Int>, xs1 : ArrayOf<Int>) in
                    return isEqual(xs0, xs1)
                }
                
                property("[Character]") <- forAll { (xs0 : ArrayOf<Character>, xs1 : ArrayOf<Character>) in
                    return isEqual(xs0, xs1)
                }
                
                property("[String]") <- forAll { (xs0 : ArrayOf<String>, xs1 : ArrayOf<String>) in
                    return isEqual(xs0, xs1)
                }
                
                property("String") <- forAll { (s0 : String, s1 : String) in
                    return (s0 + s1) == (s0 ++ s1)
                }
            }
        }
        
        describe("head") {
            it("QuickCheck") {
                struct PropertyGenerator: QualifierProtocol {
                    func arrayQualifier<A : Equatable>(xs : [A]) -> Property {
                        return xs.count > 0 ==> {
                            return head(xs) == (reverse(xs).last)!
                        }
                    }
                    
                    func stringQualifier(xs: String) -> Property {
                        return xs.characters.count > 0 ==> {
                            return head(xs) == xs[xs.startIndex]
                        }
                    }
                }
                
                PropertyGenerator().generate()
            }
        }
        
        describe("last") {
            it("QuickCheck") {
                struct PropertyGenerator: QualifierProtocol {
                    func arrayQualifier<A : Equatable>(xs : [A]) -> Property {
                        return xs.count > 0 ==> {
                            return last(xs) == head(reverse(xs))
                        }
                    }
                    
                    func stringQualifier(xs: String) -> Property {
                        return xs.characters.count > 0 ==> {
                            return last(xs) == xs[xs.endIndex.predecessor()]
                        }
                    }
                }
                
                PropertyGenerator().generate()
            }
        }
        
        describe("tail") {
            it("QuickCheck") {
                struct PropertyGenerator: QualifierProtocol {
                    func arrayQualifier<A : Equatable>(xs : [A]) -> Property {
                        return xs.count > 0 ==> {
                            return tail(xs) == drop(1, xs)
                        }
                    }
                    
                    func stringQualifier(xs: String) -> Property {
                        return xs.characters.count > 0 ==> {
                            return tail(xs) == drop(1, xs)
                        }
                    }
                }
                
                PropertyGenerator().generate()
            }
        }
        
        describe("initx") {
            it("QuickCheck") {
                struct PropertyGenerator: QualifierProtocol {
                    func arrayQualifier<A : Equatable>(xs : [A]) -> Property {
                        return xs.count > 0 ==> {
                            return initx(xs) == take(xs.count - 1, xs)
                        }
                    }
                    
                    func stringQualifier(xs: String) -> Property {
                        return xs.characters.count > 0 ==> {
                            return initx(xs) == take(length(xs)-1, xs)
                        }
                    }
                }
                
                PropertyGenerator().generate()
            }
        }
        
        describe("uncons") {
            it("QuickCheck") {
                struct PropertyGenerator: QualifierProtocol {
                    func arrayQualifier<A : Equatable>(xs : [A]) -> Property {
                        return xs.count > 0 ==> {
                            let t = uncons(xs)
                            return ([t!.0] + t!.1) == xs
                        }
                    }
                    
                    func stringQualifier(xs: String) -> Property {
                        return xs.characters.count > 0 ==> {
                            let t = uncons(xs)
                            return (String(t!.0) + t!.1) == xs
                        }
                    }
                }
                
                PropertyGenerator().generate()
            }
        }
        
        describe("null") {
            it("QuickCheck") {
                struct PropertyGenerator: QualifierProtocol {
                    func arrayQualifier<A : Equatable>(xs : [A]) -> Property {
                        return xs.count >= 0 ==> {
                            return null(xs) == (length(xs) == 0)
                        }
                    }
                    
                    func stringQualifier(xs: String) -> Property {
                        return xs.characters.count >= 0 ==> {
                            return null(xs) == (length(xs) == 0)
                        }
                    }
                }
                
                PropertyGenerator().generate()
            }
        }
        
        describe("length") {
            it("QuickCheck") {
                struct PropertyGenerator: QualifierProtocol {
                    func arrayQualifier<A : Equatable>(xs : [A]) -> Property {
                        return xs.count >= 0 ==> {
                            return length(xs) == xs.count
                        }
                    }
                    
                    func stringQualifier(xs: String) -> Property {
                        return xs.characters.count >= 0 ==> {
                            return length(xs) == xs.characters.count
                        }
                    }
                }
                
                PropertyGenerator().generate()
            }
        }
        
        describe("map") {
            it("QuickCheck") {
                func qualifier<A, B : Equatable>(transform: ArrowOf<A, B>, _ xs: ArrayOf<A>) -> Bool {
                    return map(transform.getArrow, xs.getArray) == map(transform.getArrow)(xs.getArray)
                }
                
                property("[Int]") <- forAll { (transform : ArrowOf<Int, Bool>, xs : ArrayOf<Int>) in
                    return qualifier(transform, xs)
                }
                
                property("[Character]") <- forAll { (transform : ArrowOf<Character, Bool>, xs : ArrayOf<Character>) in
                    return qualifier(transform, xs)
                }
                
                property("[String]") <- forAll { (transform : ArrowOf<String, Bool>, xs : ArrayOf<String>) in
                    return qualifier(transform, xs)
                }
                
                property("String") <- forAll { (transform : ArrowOf<Character, Bool>, xs : String) in
                    return map(transform.getArrow, xs) == map(transform.getArrow)(xs)
                }
            }
        }
        
        describe("reverse") {
            it("QuickCheck") {
                struct PropertyGenerator: QualifierProtocol {
                    func arrayQualifier<A : Equatable>(xs : [A]) -> Property {
                        return xs.count >= 0 ==> {
                            return reverse(reverse(xs)) == xs
                        }
                    }
                    
                    func stringQualifier(xs: String) -> Property {
                        return xs.characters.count >= 0 ==> {
                            return reverse(reverse(xs)) == xs
                        }
                    }
                }
                
                PropertyGenerator().generate()
            }
        }
        describe("intersperse") {
            it("QuickCheck") {
                func qualifier<A : Equatable>(separator: A, _ xs: ArrayOf<A>) -> Bool {
                    return intersperse(separator, xs.getArray) == intersperse(separator)(xs.getArray)
                }
                
                property("[Int]") <- forAll { (separator : Int, xs : ArrayOf<Int>) in
                    return qualifier(separator, xs)
                }
                
                property("[Character]") <- forAll { (separator : Character, xs : ArrayOf<Character>) in
                    return qualifier(separator, xs)
                }
                
                property("[String]") <- forAll { (separator : String, xs : ArrayOf<String>) in
                    return qualifier(separator, xs)
                }
                
                property("String") <- forAll { (separator : Character, xs : String) in
                    return intersperse(separator, xs) == intersperse(separator)(xs)
                }
            }
        }
        
        describe("intercalate") {
            it("QuickCheck") {
                func qualifier<A : Equatable>(xs: ArrayOf<A>, _ xss: ArrayOf<ArrayOf<A>>) -> Bool {
                    let _xss = xss.getArray.map( { $0.getArray })
                    return intercalate(xs.getArray, _xss) == intercalate(xs.getArray)(_xss)
                }
                
                property("[Int]") <- forAll { (xs : ArrayOf<Int>, xss : ArrayOf<ArrayOf<Int>>) in
                    return qualifier(xs, xss)
                }
                
                property("[Character]") <- forAll { (xs : ArrayOf<Character>, xss : ArrayOf<ArrayOf<Character>>) in
                    return qualifier(xs, xss)
                }
                
                property("[String]") <- forAll { (xs: ArrayOf<String>, xss : ArrayOf<ArrayOf<String>>) in
                    return qualifier(xs, xss)
                }
                
                property("String") <- forAll { (xs: String, xss : ArrayOf<String>) in
                    return intercalate(xs, xss.getArray) == intercalate(xs)(xss.getArray)
                }
            }
        }

    }
}
