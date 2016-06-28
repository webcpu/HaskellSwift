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

class DataListBasic0QuickCheck: QuickSpec {
    override func spec() {
        describe("not") {
            it("QuickCheck") {
                property("DeMorgan's Law 1") <- forAll { (a: Bool, b:Bool) in
                    let l = not(a && b) == (not(a) || not(b))
                    let r = not(a || b) == (not(a) && not(b))
                    return l && r
                }
            }
        }
        
        describe("++") {
            it("QuickCheck") {
                func isEqual<A : Equatable>(_ xs0 : ArrayOf<A>, _ xs1: ArrayOf<A>) -> Bool {
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
                    func arrayQualifier<A : Equatable>(_ xs : [A]) -> Property {
                        return xs.count > 0 ==> {
                            return head(xs) == (reverse(xs).last)!
                        }
                    }
                    
                    func stringQualifier(_ xs: String) -> Property {
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
                    func arrayQualifier<A : Equatable>(_ xs : [A]) -> Property {
                        return xs.count > 0 ==> {
                            return last(xs) == head(reverse(xs))
                        }
                    }
                    
                    func stringQualifier(_ xs: String) -> Property {
                        return xs.characters.count > 0 ==> {
                            return last(xs) == xs[xs.characters.index(before: xs.endIndex)]
                        }
                    }
                }
                
                PropertyGenerator().generate()
            }
        }
        
        describe("tail") {
            it("QuickCheck") {
                struct PropertyGenerator: QualifierProtocol {
                    func arrayQualifier<A : Equatable>(_ xs : [A]) -> Property {
                        return xs.count > 0 ==> {
                            return tail(xs) == drop(1, xs)
                        }
                    }
                    
                    func stringQualifier(_ xs: String) -> Property {
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
                    func arrayQualifier<A : Equatable>(_ xs : [A]) -> Property {
                        return xs.count > 0 ==> {
                            return initx(xs) == take(xs.count - 1, xs)
                        }
                    }
                    
                    func stringQualifier(_ xs: String) -> Property {
                        return xs.characters.count > 0 ==> {
                            return initx(xs) == take(length(xs)-1, xs)
                        }
                    }
                }
                
                PropertyGenerator().generate()
            }
        }
    }
}

class DataListBasic1QuickCheck: QuickSpec {
    override func spec() {
        describe("uncons") {
            it("QuickCheck") {
                struct PropertyGenerator: QualifierProtocol {
                    func arrayQualifier<A : Equatable>(_ xs : [A]) -> Property {
                        return xs.count > 0 ==> {
                            let t = uncons(xs)
                            return ([t!.0] + t!.1) == xs
                        }
                    }
                    
                    func stringQualifier(_ xs: String) -> Property {
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
                    func arrayQualifier<A : Equatable>(_ xs : [A]) -> Property {
                        return xs.count >= 0 ==> {
                            return null(xs) == (length(xs) == 0)
                        }
                    }
                    
                    func stringQualifier(_ xs: String) -> Property {
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
                    func arrayQualifier<A : Equatable>(_ xs : [A]) -> Property {
                        return xs.count >= 0 ==> {
                            return length(xs) == xs.count
                        }
                    }
                    
                    func stringQualifier(_ xs: String) -> Property {
                        return xs.characters.count >= 0 ==> {
                            return length(xs) == xs.characters.count
                        }
                    }
                }
                
                PropertyGenerator().generate()
            }
        }
    }
}
