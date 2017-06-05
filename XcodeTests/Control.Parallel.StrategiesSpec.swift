//
//  Control.MonadSpec.swift
//  HaskellSwift
//
//  Created by Liang on 24/09/2015.
//  Copyright © 2015 Liang. All rights reserved.
//

import Foundation
//import XCTest
import Quick
import Nimble
@testable import HaskellSwift

class ControlParallelStrategiesSpec: QuickSpec {
    override func spec() {
        describe("parMap") {
            it("Array") {
                let links =   ["https://developer.apple.com", "https://www.apple.com", "http://www.bbc.com"]
                let request : (String) -> Response! = getURL >>>= simpleHTTP
                
                let ys = parMap(request,links)
                let rs = map({fromJust($0.data?.count)}, ys)
                expect(length(rs)).to(equal(3))
            }
        }
    }
}
