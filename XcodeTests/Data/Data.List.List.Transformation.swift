//
//  Data.List.List.Transformation.swift
//  HaskellSwift
//
//  Created by Liang on 09/11/2015.
//  Copyright © 2015 Liang. All rights reserved.
//

import Quick
import Nimble
//import SwiftCheck
@testable import HaskellSwift

class DataListListTransformation0QuickCheck: QuickSpec {
    override func spec() {
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
                    forAll { (_ : Int) in
                        return qualifier(transform, xs)
                        }.once
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
                    forAll { (_ : Int) in
                        return qualifier(separator, xs)
                        }.once
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
                    forAll { (_ : Int) in
                        return qualifier(xs, xss)
                        }.once
                }
                
                property("String") <- forAll { (xs: String, xss : ArrayOf<String>) in
                    forAll { (_ : Int) in
                        return intercalate(xs, xss.getArray) == intercalate(xs)(xss.getArray)
                        }.once
                }
            }
        }
        
        describe("concat") {
            it("QuickCheck") {
                func qualifier<A : Equatable>(xss: ArrayOf<ArrayOf<A>>) -> Property {
                    return xss.getArray.count > 0 ==> {
                        let _xss = xss.getArray.map( { $0.getArray })
                        return concat(_xss) == foldl1((+) , _xss)
                    }
                }
                
                property("[[Int]]") <- forAll { (xss : ArrayOf<ArrayOf<Int>>) in
                    return qualifier(xss)
                }
                
                property("[[Character]]") <- forAll { (xss : ArrayOf<ArrayOf<Character>>) in
                    return qualifier(xss)
                }
                
                property("[[String]]") <- forAll { (xss : ArrayOf<ArrayOf<String>>) in
                    return qualifier(xss)
                    }.once
                
                property("[String]") <- forAll { (xss : ArrayOf<String>) in
                    return xss.getArray.count > 0 ==> {
                        forAll { (_ : Int) in
                            return concat(xss.getArray) == foldl1((+) , xss.getArray)
                            }.once
                    }
                }
            }
        }
    }
}

class DataListListTransformation1QuickCheck: QuickSpec {
    override func spec() {
        describe("foldl") {
            it("QuickCheck") {
                func qualifier<A, B : Equatable>(transform : ArrowOf<A , ArrowOf<B , A>>, _ initialValue : A, _ xs: ArrayOf<B>) -> Property {
                    return xs.getArray.count > 0 ==> {
                        let _transform = { (a : A, b : B) -> A in ((transform.getArrow)(a).getArrow)(b) }
                        return foldl(_transform, initialValue, xs.getArray) == foldl(_transform)(initialValue)(xs.getArray)
                    }
                }
                
                property("[Int]") <- forAll { (transform : ArrowOf<Bool , ArrowOf<Int , Bool>>, initialValue : Bool, xs : ArrayOf<Int>) in
                    return qualifier(transform, initialValue, xs)
                }
                
                property("[Character]") <- forAll { (transform : ArrowOf<Bool , ArrowOf<Character , Bool>>, initialValue : Bool, xs : ArrayOf<Character>) in
                    return qualifier(transform, initialValue, xs)
                }
                
                property("[String]") <- forAll { (transform : ArrowOf<Bool , ArrowOf<String , Bool>>, initialValue : Bool, xs : ArrayOf<String>) in
                    forAll { (_ : Int) in
                        return qualifier(transform, initialValue, xs)
                        }.once
                }
                
                property("String") <- forAll { (transform : ArrowOf<String, ArrowOf<Character, String>>, initialValue : String, xs : String) in
                    return xs.characters.count > 0 ==> {
                        let _transform = { (a : String, b : Character) -> String in ((transform.getArrow)(a).getArrow)(b) }
                        return foldl(_transform, initialValue, xs) == foldl(_transform)(initialValue)(xs)
                    }
                }
            }
        }
        
        describe("foldl1") {
            it("QuickCheck") {
                func qualifier<A : Equatable>(transform : ArrowOf<A , ArrowOf<A , A>>, _ xs: ArrayOf<A>) -> Property {
                    return xs.getArray.count > 0 ==> {
                        let _transform = { (a : A, b : A) -> A in ((transform.getArrow)(a).getArrow)(b) }
                        return foldl1(_transform, xs.getArray) == foldl1(_transform)(xs.getArray)
                    }
                }
                
                property("Int") <- forAll { (transform : ArrowOf<Int , ArrowOf<Int , Int>>,  xs : ArrayOf<Int>) in
                    return qualifier(transform, xs)
                }
                
                property("Character") <- forAll { (transform : ArrowOf<Character , ArrowOf<Character , Character>>,  xs : ArrayOf<Character>) in
                    return qualifier(transform, xs)
                }
                
                property("String") <- forAll { (transform : ArrowOf<String , ArrowOf<String , String>>, xs : ArrayOf<String>) in
                    forAll { (_ : Int) in
                        return qualifier(transform, xs)
                        }.once
                }
            }
        }
        
        describe("reduce") {
            it("QuickCheck") {
                func qualifier<A, B : Equatable>(transform : ArrowOf<A , ArrowOf<B , A>>, _ initialValue : A, _ xs: ArrayOf<B>) -> Property {
                    return xs.getArray.count > 0 ==> {
                        let _transform = { (a : A, b : B) -> A in ((transform.getArrow)(a).getArrow)(b) }
                        return reduce(_transform, initialValue, xs.getArray) == reduce(_transform)(initialValue)(xs.getArray)
                    }
                }
                
                property("[Int]") <- forAll { (transform : ArrowOf<Bool , ArrowOf<Int , Bool>>, initialValue : Bool, xs : ArrayOf<Int>) in
                    return qualifier(transform, initialValue, xs)
                }
                
                property("[Character]") <- forAll { (transform : ArrowOf<Bool , ArrowOf<Character , Bool>>, initialValue : Bool, xs : ArrayOf<Character>) in
                    return qualifier(transform, initialValue, xs)
                }
                
                property("[String]") <- forAll { (transform : ArrowOf<Bool , ArrowOf<String , Bool>>, initialValue : Bool, xs : ArrayOf<String>) in
                    forAll { (_ : Int) in
                        return qualifier(transform, initialValue, xs)
                        }.once
                }
                
                property("String") <- forAll { (transform : ArrowOf<String, ArrowOf<Character, String>>, initialValue : String, xs : String) in
                    return xs.characters.count > 0 ==> {
                        let _transform = { (a : String, b : Character) -> String in ((transform.getArrow)(a).getArrow)(b) }
                        return reduce(_transform, initialValue, xs) == reduce(_transform)(initialValue)(xs)
                    }
                }
            }
        }
        
        describe("foldr") {
            it("QuickCheck") {
                func qualifier<A, B : Equatable>(transform : ArrowOf<A , ArrowOf<B , B>>, _ initialValue : B, _ xs: ArrayOf<A>) -> Property {
                    return xs.getArray.count > 0 ==> {
                        let _transform = { (a : A, b : B) -> B in ((transform.getArrow)(a).getArrow)(b) }
                        return foldr(_transform, initialValue, xs.getArray) == foldr(_transform)(initialValue)(xs.getArray)
                    }
                }
                
                property("[Int]") <- forAll { (transform : ArrowOf<Int , ArrowOf<Bool , Bool>>, initialValue : Bool, xs : ArrayOf<Int>) in
                    return qualifier(transform, initialValue, xs)
                }
                
                property("[Character]") <- forAll { (transform : ArrowOf<Character , ArrowOf<Bool , Bool>>, initialValue : Bool, xs : ArrayOf<Character>) in
                    return qualifier(transform, initialValue, xs)
                }
                
                property("[String]") <- forAll { (transform : ArrowOf<String , ArrowOf<Bool , Bool>>, initialValue : Bool, xs : ArrayOf<String>) in
                    forAll { (_ : Int) in
                        return qualifier(transform, initialValue, xs)
                        }.once
                }
                
                property("String") <- forAll { (transform : ArrowOf<Character, ArrowOf<String, String>>, initialValue : String, xs : String) in
                    return xs.characters.count > 0 ==> {
                        let _transform = { (a : Character, b : String) -> String in ((transform.getArrow)(a).getArrow)(b) }
                        return foldr(_transform, initialValue, xs) == foldr(_transform)(initialValue)(xs)
                    }
                }
            }
        }
        
        describe("foldr1") {
            it("QuickCheck") {
                func qualifier<A : Equatable>(transform : ArrowOf<A , ArrowOf<A , A>>, _ xs: ArrayOf<A>) -> Property {
                    return xs.getArray.count > 0 ==> {
                        let _transform = { (a : A, b : A) -> A in ((transform.getArrow)(a).getArrow)(b) }
                        return foldr1(_transform, xs.getArray) == foldr1(_transform)(xs.getArray)
                    }
                }
                
                property("Int") <- forAll { (transform : ArrowOf<Int , ArrowOf<Int , Int>>,  xs : ArrayOf<Int>) in
                    return qualifier(transform, xs)
                }
                
                property("Character") <- forAll { (transform : ArrowOf<Character , ArrowOf<Character , Character>>,  xs : ArrayOf<Character>) in
                    return qualifier(transform, xs)
                }
                
                property("String") <- forAll { (transform : ArrowOf<String , ArrowOf<String , String>>, xs : ArrayOf<String>) in
                    forAll { (_ : Int) in
                        return qualifier(transform, xs)
                        }.once
                } 
            }
        }
    }
}

