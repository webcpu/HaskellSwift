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

class PlaySpec: QuickSpec {
    override func spec() {
           }
}

class PlayTests: XCTestCase {
    func testThat() {
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
        
        let xs : [Any]      = [
            onlyFive, fromOnetoFive, lowerCaseLetters, upperCaseLetters,
            specialCharacters, uppersAndLowers, pairsOfNumbers,
            weightedGen, biasedUppersAndLowers, oneToFiveEven,
            characterArray, oddLengthArray, fromTwoToSix,
            generatorBoundedSizeArrays, fromTwoToSix_, allowedLocalCharacters,
            localEmail, hostname, tld
        ]
        
        map(showAll .. generatorToTransform, xs)
    }
}
