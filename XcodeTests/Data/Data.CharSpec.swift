//
//  Data.CharSpec.swift
//  HaskellSwift
//
//  Created by Liang on 28/08/2015.
//  Copyright © 2015 Liang. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import HaskellSwift

//http://www.unicode.org/charts/

class DataCharSpec: QuickSpec {
    override func spec() {
        let lowercaseLetters = "abcdefghijklmnopqrstuvwxyz"
        let uppercaseLetters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let digits           = "0123456789"
        let octDigits        = "01234567"
        let hexDigits        = "0123456789ABCDEFabcdef"
        let controls         = charsetWithScalars([0,1] ++ Array((0x7F)...(0x9F)))

        describe("isControl") {
            it("Char") {
                let r0       = all(isControl, controls)
                expect(r0).to(beTrue())
            }
        }
        
        describe("isSpace") {
            it("Char") {
                expect(isSpace(" ")).to(beTrue())
                expect(isSpace("\t")).to(beTrue())
            }
        }
        
        describe("isLower") {
            it("Char") {
                let r0 = all({ x in isLower(x) }, lowercaseLetters)
                expect(r0).to(beTrue())
                
                let r1 = all({ x in isLower(x) }, uppercaseLetters)
                expect(r1).to(beFalse())
            }
        }
        
        describe("isUpper") {
            it("Char") {
                let r0 = all({ x in isUpper(x) }, uppercaseLetters)
                expect(r0).to(beTrue())

                let r1 = all({ x in isUpper(x) }, lowercaseLetters)
                expect(r1).to(beFalse())
            }
        }
        
        describe("isAlpha") {
            it("Char") {
                let r0 = all({ x in isAlpha(x) }, lowercaseLetters + uppercaseLetters)
                expect(r0).to(beTrue())
                
                let r1 = all({ x in isAlpha(x) }, controls)
                expect(r1).to(beFalse())
            }
        }
        
        describe("isAlphaNum") {
            it("Char") {
                let r0 = all({ x in isAlphaNum(x) }, lowercaseLetters + uppercaseLetters + digits)
                expect(r0).to(beTrue())
            }
        }
        
        describe("isPrint") {
            it("Char") {
                let r0 = all({ x in isPrint(x) }, lowercaseLetters + uppercaseLetters + digits)
                expect(r0).to(beTrue())
            }
        }
        
        describe("isDigit") {
            it("Char") {
                let r0 = all({ x in isDigit(x) }, digits)
                expect(r0).to(beTrue())
            }
        }
        
        describe("isOctDigit") {
            it("Char") {
                let r0 = all({ x in isOctDigit(x) }, octDigits)
                expect(r0).to(beTrue())
                
                let r1 = all({ x in isOctDigit(x) }, "89ABCDEFabcdef")
                expect(r1).to(beFalse())
            }
        }
        
        describe("isHexDigit") {
            it("Char") {
                let r0 = all({ x in isHexDigit(x) }, hexDigits)
                expect(r0).to(beTrue())
            }
        }
        
        describe("isLetter") {
            it("Char") {
                let r0 = all({ x in isLetter(x) }, lowercaseLetters + uppercaseLetters)
                expect(r0).to(beTrue())
                
                let r1 = all({ x in isLetter(x) }, controls)
                expect(r1).to(beFalse())
            }
        }
        
//        describe("isMark") {
//            it("Char") {
//                
//            }
//        }
//        
//        describe("isNumber") {
//            it("Char") {
//            }
//        }
        
        describe("isPunctuation") {
            it("Char") {
                expect(isPunctuation(".")).to(beTrue())
            }
        }
        
        describe("isSymbol") {
            it("Char") {
                expect(isSymbol("$")).to(beTrue())
            }
        }
        
        describe("isSeparator") {
            it("Char") {
                expect(isSeparator(" ")).to(beTrue())
                expect(isSeparator("\t")).to(beTrue())
                expect(isSeparator("\n")).to(beTrue())
                expect(isSeparator("\r")).to(beTrue())
                expect(isSeparator("\u{b}")).to(beTrue())
                expect(isSeparator("\u{c}")).to(beTrue())
                expect(isSeparator("\u{2028}")).to(beTrue())
                expect(isSeparator("\u{2029}")).to(beTrue())
            }
        }
        
        describe("isAscii") {
            it("Char") {
                let r0 = all({ x in isAscii(x) }, charsetWithScalars(Array(0...127)))
                expect(r0).to(beTrue())
                
                let r1 = all({ x in isAscii(x) }, charsetWithScalars([128]))
                expect(r1).to(beFalse())
            }
        }
        
        describe("isLatin1") {
            it("Char") {
                let r0 = all({ x in isLatin1(x) }, charsetWithScalars(Array(0...255)))
                expect(r0).to(beTrue())
                
                let r1 = all({ x in isLatin1(x) }, charsetWithScalars([256]))
                expect(r1).to(beFalse())
            }
        }
        
        describe("isAsciiUpper") {
            it("Char") {
                let r0 = all({ x in isAsciiUpper(x) }, uppercaseLetters)
                expect(r0).to(beTrue())
            }
        }
        
        describe("isAsciiLower") {
            it("Char") {
                let r0 = all({ x in isAsciiLower(x) }, lowercaseLetters)
                expect(r0).to(beTrue())
            }
        }
        
//        describe("generalCategory") {
//            it("Char") {
//                
//            }
//        }
        
        describe("toUpper") {
            it("Char") {
                let r0 = map({ x in toUpper(x) }, lowercaseLetters)
                expect(r0).to(equal(uppercaseLetters))
            }
        }
        
        describe("toLower") {
            it("Char") {
                let r0 = map({ x in toLower(x) }, uppercaseLetters)
                expect(r0).to(equal(lowercaseLetters))
            }
        }
        
        describe("toTitle") {
            it("Char") {
                let r0 = map({ x in toTitle(x) }, lowercaseLetters)
                expect(r0).to(equal(uppercaseLetters))            }
        }
        
        describe("digitToInt") {
            it("Char") {
                let r0 = map({ x in digitToInt(x) }, hexDigits)
                expect(r0).to(equal([0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,10,11,12,13,14,15]))
            }
        }
        
        describe("intToDigit") {
            it("Char") {
                let r0 = map({ x in intToDigit(x) }, Array(0...15))
                expect(r0).to(equal(["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "b", "c", "d", "e", "f"]))
            }
        }
        
        describe("ord") {
            it("Char") {
                let r0 = map({ x in ord(x) }, charactersWithScalars(Array(0...255)))
                expect(r0).to(equal(Array(0...255)))
            }
        }
        
        describe("chr") {
            it("Char") {
                let r0 = map({ x in chr(x) }, Array(0...255))
                expect(r0).to(equal(charactersWithScalars(Array(0...255))))
            }
        }
        
        describe("showLitChar") {
            it("Char") {
                let r0 = map({ x in showLitChar(x, "A") }, ["\0", "\"","\'", "\n", "\\", "\r", "\t", "a"] )
                expect(r0).to(equal(["\\0A", "\\\"A", "\\\'A", "\\nA", "\\\\A", "\\rA", "\\tA", "aA" ]))
            }
        }
        
//        describe("lexLitChar") {
//            it("Char") {
//                
//            }
//        }
//        
//        describe("readLitChar") {
//            it("Char") {
//                
//            }
//        }
    }
}
