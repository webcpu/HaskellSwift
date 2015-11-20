//
//  Control.MonadSpec.swift
//  HaskellSwift
//
//  Created by Liang on 24/09/2015.
//  Copyright © 2015 Liang. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import HaskellSwift

class ControlMonadSpec: QuickSpec {
    override func spec() {
        describe(">>=") {
            it("Left Law") {
                var xs : [Int] = [Int]()
                xs.append(1)
                /*let f           = { (x: Int) -> [Int] in
                    var ys = [Int]()
                    ys.append(x + 1)
                    return ys
                }
//                let result      = xs >>= f
//                expect(result).to(equal(f(1)))
*/
            }
        }
    }
}
