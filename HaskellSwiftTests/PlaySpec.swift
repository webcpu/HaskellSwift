//
//  PlaySpec.swift
//  HaskellSwift
//
//  Created by Liang on 02/11/2015.
//  Copyright © 2015 Liang. All rights reserved.
//

import Foundation
import Quick
import Nimble
import HaskellSwift

import SwiftCheck
import XCTest

//func arrayQualifier<A: Equatable>(arbitrary : ArrayOf<A>) -> Property {
//    return  arbitrary.getArray.count >= 0 ==> {
//        return false
//    }
//}
//
//func stringQualifier(xs: String) -> Property {
//    return (xs.characters.count >= 0) ==> {
//        return false
//    }
//}

//public struct Properties <A : Arbitrary> {



//func properties<T: Equatable>(arrayQualifier: [T] -> Property, _ stringQualifier: (String -> Property)) {
////        property("[Int]") <- forAll { (xs : ArrayOf<Int>) in
////            let f = arrayQualifier.self as ([Int] -> Property)
////            return f(xs.getArray)
////        }
//    
////        property("[Character]") <- forAll { (xs : ArrayOf<Character>) in
////            return arrayQualifier<Character>(xs.getArray)
////        }
////        
////        property("[String]") <- forAll { (xs : ArrayOf<String>) in
////            return arrayQualifier(xs.getArray as [String])
////        }
//    
//        property("String") <- forAll { (xs : String) in
//            return stringQualifier(xs)
//        }
//}

class PlaySpec: QuickSpec {
    override func spec() {
        it("QuickCheck") {
            struct LengthProperty: QualifierProtocol {
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
            
            LengthProperty().generate()
        }
    }
}

struct ArbitraryDate : Arbitrary {
    let getDate: NSDate
    
    init(date: NSDate) { self.getDate = date }
    static var arbitrary : Gen<ArbitraryDate> {
        return Gen.oneOf([
            Gen.pure(NSDate()),
            Gen.pure(NSDate.distantFuture()),
            Gen.pure(NSDate.distantPast()),
            NSTimeInterval.arbitrary.fmap(NSDate.init)
            ]).fmap(ArbitraryDate.init)
    }
}

class PlayTests: XCTestCase {
    func ftestGenerator() {
        func show<A>(gen: SwiftCheck.Gen<A>)->Int {
            print(gen.generate)
            return 0
        }
        
        func showAll(transform: (Int->Int)?) {
            guard transform != nil else {
                print("transform is nil")
                return
            }
            
            let xs       = Array(1...5)
            map(transform!, xs)
            print("------------------------")
        }
        
        func showAlls(fs: [(Int->Int)?]) {
            map(showAll, fs)
        }
        
        func transform<A>(gen: SwiftCheck.Gen<A>)->Int->Int {
            return { _ in show(gen) }
        }
        
        func generatorToTransform(x: Any) -> (Int->Int)? {
            switch x {
            case is Gen<Int>:
                let x0 = x as! Gen<Int>
                return transform(x0)
            case is Gen<Character>:
                let x0 = x as! Gen<Character>
                return transform(x0)
            case is Gen<(Int, Int)>:
                let x0 = x as! Gen<(Int,Int)>
                return transform(x0)
            case is Gen<Int?>:
                let x0 = x as! Gen<Int?>
                return transform(x0)
            case is Gen<[Character]>:
                let x0 = x as! Gen<[Character]>
                return transform(x0)
            case is Gen<[Int]>:
                let x0 = x as! Gen<[Int]>
                return transform(x0)
            case is Gen<String>:
                let x0 = x as! Gen<String>
                return transform(x0)
            case is Gen<ArbitraryDate>:
                let x0 = x as! Gen<ArbitraryDate>
                return transform(x0)
            default:
                XCTFail("Not matched")
            }
            return nil
        }
        
        let onlyFive      = Gen.pure(5)
        
        let fromOnetoFive = Gen<Int>.fromElementsIn(1...5)
        
        let lowerCaseLetters : Gen<Character> = Gen<Character>.fromElementsIn("a"..."z")
        
        let upperCaseLetters : Gen<Character> = Gen<Character>.fromElementsIn("A"..."Z")
        
        let specialCharacters = Gen<Character>.fromElementsOf(["!", "@", "#", "$", "%", "^", "&", "*", "(", ")"] as [Character])
        
        let uppersAndLowers = Gen<Character>.oneOf([lowerCaseLetters, upperCaseLetters])
        
        let pairsOfNumbers  = Gen<(Int, Int)>.zip(fromOnetoFive, fromOnetoFive)
        
        let weightedGen     = Gen<Int?>.weighted([(1,nil), (3, .Some(5))])
        
        let biasedUppersAndLowers = Gen<Character>.frequency([(1, uppersAndLowers), (3, lowerCaseLetters)])
        
        let oneToFiveEven   = fromOnetoFive.suchThat { $0 % 2 == 0 }
        
        let characterArray  = uppersAndLowers.proliferate()
        
        let oddLengthArray  = fromOnetoFive.proliferateNonEmpty().suchThat { $0.count % 2 == 1 }
        
        let fromTwoToSix = fromOnetoFive.fmap { $0 + 1 }
        
        let generatorBoundedSizeArrays = fromOnetoFive.bind { len in
            return characterArray.suchThat { xs in xs.count <= len }
        }
        
        let fromTwoToSix_ = fromOnetoFive.fmap { $0 + 1}
        
        let numeric : Gen<Character> = Gen<Character>.fromElementsIn("0"..."9")
        let special : Gen<Character> = Gen<Character>.fromElementsOf(["!", "#", "$", "%", "&", "'", "*", "+", "-", "/", "=", "?", "^", "_", "`", "{", "|", "}", "~", "."])
        let allowedLocalCharacters : Gen<Character> = Gen<Character>.oneOf([upperCaseLetters, lowerCaseLetters, numeric, special])
        
        let localEmail = allowedLocalCharacters.proliferateNonEmpty().fmap(String.init)
        
        let hostname = Gen<Character>.oneOf([lowerCaseLetters, numeric,Gen.pure("-")]).proliferateNonEmpty().fmap(String.init)
        
        let tld = lowerCaseLetters.proliferateNonEmpty().suchThat({ last($0) != "." }).fmap(String.init)
        
        func glue5(l : String)(m: String)(m2 : String)(m3 : String)(r : String) -> String {
            return l + m + m2 + m3 + r
        }
        let emailGen = localEmail.fmap(glue5) <*> Gen.pure("@") <*> hostname <*> Gen.pure(".") <*> tld
        
//        let xs : [Any]      = [
//            onlyFive, fromOnetoFive, lowerCaseLetters, upperCaseLetters,
//            specialCharacters, uppersAndLowers, pairsOfNumbers,
//            weightedGen, biasedUppersAndLowers, oneToFiveEven,
//            characterArray, oddLengthArray, fromTwoToSix,
//            generatorBoundedSizeArrays, fromTwoToSix_, allowedLocalCharacters,
//            localEmail, hostname, tld, emailGen, ArbitraryDate.arbitrary
//        ]
        
       // map(showAll .. generatorToTransform, xs)
    }
    
    func testProperties() {
        property("The reverse of the reverse of an array is that array") <- forAll { (xs: [Int]) in
            return reverse(reverse(xs)) == xs
        }
        
        property("The reverse of the reverse of an array is that array") <- forAll { (xs: String) in
            return reverse(reverse(xs)) == xs
        }
        
        //        property("The reverse of the reverse of an array is that array") <- forAll { (xs: [String]) in
        //            return reverse(reverse(xs)) == xs
        //        }
        
        property("filter behaves") <- forAll { (xs : ArrayOf<Int>, pred: ArrowOf<Int, Bool>) in
            let f       = pred.getArrow
            let reduce2 = { xs in reduce({ (x: (Bool, Int)) -> Bool in x.0 && f(x.1) }, true, xs) }
            let filter1 = curry(filter)(f)
            let verify  = reduce2 .. filter1
            return verify(xs.getArray)
        }
        
        property("DeMorgan's Law 1") <- forAll { (a: Bool, b:Bool) in
            let l = not(a && b) == (not(a) || not(b))
            let r = not(a || b) == (not(a) && not(b))
            return l && r
        }
        
        property("DeMorgan's Law 2") <- forAll { (x : Bool, y : Bool) in
            let l = !(x && y) == (!x || !y)
            let r = !(x || y) == (!x && !y)
            return l && r
        }
        
        reportProperty("Obviously wrong") <- forAll({ (x : Int) in
            return x == x
        }).whenFail {
            print("Oh No");
        }
        
        Array<Int>.shrink([1, 2, 3])
        //        
        //        struct ArbitraryEmail : Arbitrary {
        //            let getEmail : String
        //            
        //            init(email: String) { self.getEmail = email }
        //            
        //            static var arbitrary : Gen<ArbitraryEmail> { return emailGen.fmap(ArbitraryEmail.init) }
        //            
        //            static func shrink(tt : ArbitraryEmail) -> [ArbitraryEmail] {
        //                return emailGen.suchThat( { $0.unicodeScalars.count <= (tt.getEmail.unicodeScalars.count / 2) })
        //                    .proliferateNonEmpty()
        //                    .generate
        //                    .map(ArbitraryEmail.init)
        //            }
        //        }
        //        
        //        property("email addresses don't come with a TLD") <- forAll { (email : ArbitraryEmail) in
        //            return !email.getEmail.containsString(".")
        //            }.expectFailure
        
        func sieve(n : Int) -> [Int] {
            if n <= 1 {
                return []
            }
            
            var marked : [Bool] = map ( { _ in false }, Array(0...n))
            marked[0] = true
            marked[1] = true
            
            for p in 2..<n {
                for i in (2 * p).stride(through: n, by: p) {
                    marked[i] = true
                }
            }
            
            typealias T = (Int, Bool)
            
            let primes  = map({ (t:T) -> Int in t.0 }) .. filter( {(t:T) in t.1 == false} ) .. zip(Array(0...n))
            return primes(marked)
        }
        
        func isPrime(n : Int) -> Bool {
            switch n {
            case 0...1:
                return false
            case 2:
                return true
            default:
                return _isPrime(n)
            }
        }
        
        func _isPrime(n : Int) -> Bool {
            let array2ToN : Int->[Int]   = { x in Array(2...x) }
            let divisors  : Int->[Int]   = array2ToN .. Int.init .. ceil .. sqrt .. Double.init
            let isDivisible              = or .. map({ x in n % x == 0})
            let isNotPrime               = isDivisible .. divisors
            return !isNotPrime(n)
        }
        
        reportProperty("All Prime") <- forAll { (n : Positive<Int>) in
            let primes = sieve(n.getPositive)
            return primes.count > 1 ==> {
                let primeNumberGen = Gen<Int>.fromElementsOf(primes)
                return forAll(primeNumberGen) { (p : Int) in
                    return isPrime(p)
                }
            }
        }
        
        property("All Prime") <- forAll { (n : Positive<Int>) in
            let primes = filter(isPrime) .. sieve
            let verify = { x in primes(x) == sieve(x) }
            return verify(n.getPositive)
        }
    }
}
