//
//  Control.MonadSpec.swift
//  HaskellSwift
//
//  Created by Liang on 24/09/2015.
//  Copyright © 2015 Liang. All rights reserved.
//

import Foundation
//import XCTest
import Quick.QuickSpec
import Nimble
@testable import HaskellSwift

class ControlMonadSpec: QuickSpec {
    override func spec() {
        let square: Int -> [Int]           = { (x: Int) -> [Int] in
            return [x*x]
        }
        
        let isEven: Int -> [Bool]           = { (x: Int) -> [Bool] in
            let r = x % 2 == 0
            return [r]
        }
        
        let name = { (x: Int) -> String? in
            return x % 2 == 0 ? "even" : nil
        }
        
        let len = { (x: String) -> Int? in
            return x.characters.count
        }
        
        describe(">>>= and >=>") {
            it("Array") {
                let xs : [Int]  = [1, 2, 3]
                let ys          = [false, true, false]
                
                let bs          = xs >>>= square
                let r0          = bs >>>= isEven
                expect(r0).to(equal(ys))
                
                let f           = square >=> isEven
                let r1          = xs >>>= f
                expect(r1).to(equal(ys))
                
                let r           = xs >>>= square >=> isEven
                expect(r).to(equal(ys))
            }
            
            it("Maybe") {
                let a           = 2
                let c           = 4
                
                let b           = a >>>= name
                let r0          = b >>>= len
                expect(r0).to(equal(c))
                
                let f           = name >=> len
                let r1          = f(a)
                expect(r1).to(equal(c))
                
                let r           = a >>>= name >=> len
                expect(r).to(equal(c))
            }
        }
        
        describe("=<<< and <=<") {
            it("Array") {
                let xs : [Int]  = [1, 2, 3]
                let ys          = [false, true, false]
                
                let bs          = square =<<< xs
                let r0          = isEven =<<< bs
                expect(r0).to(equal(ys))
                
                let f           = isEven <=< square
                let r1          = f =<<< xs
                expect(r1).to(equal(ys))
                
                let r           = isEven <=< square =<<< xs
                expect(r).to(equal(ys))
            }
            
            it("Maybe") {
                let a           = 2
                let c           = 4
                
                let b           = name =<<< a
                let r0          = len =<<< b
                expect(r0).to(equal(c))
                
                let f           = len <=< name
                let r1          = f =<<< a
                expect(r1).to(equal(c))
                
                let r           = len <=< name =<<< a
                expect(r).to(equal(c))
            }
        }

    }
}
