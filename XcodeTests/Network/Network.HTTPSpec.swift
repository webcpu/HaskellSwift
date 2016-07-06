//
//  Network.HTTPSpec.swift
//  HaskellSwift
//
//  Created by Liang on 30/06/2016.
//  Copyright © 2016 Liang. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import HaskellSwift

class NetworkHTTPSpec: QuickSpec {
    override func spec() {
        describe("simpleHTTP") {
            it("http or https") {
                let links  = ["http://www.google.com", "https://www.google.com"]
                let verify = { (urlString: String) in
                    let url = getURL(urlString)
                    let response = url >>>= simpleHTTP
                    expect(response).notTo(beNil())
                }
                _ = map(verify, links)
            }
        }

        describe("getURL") {
            it("http") {
                let urlString = "http://www.google.com"
                expect(getURL(urlString)) == NSURL(string: urlString)
            }

            it("https") {
                let urlString = "http://www.google.com"
                expect(getURL(urlString)) == NSURL(string: urlString)
            }

            it("illegal protocol") {
                let urlString = "\\www.google.com"
                let url = getURL(urlString)
                expect(url).to(beNil())
                print(url?.absoluteString)
            }
        }
    }
}
