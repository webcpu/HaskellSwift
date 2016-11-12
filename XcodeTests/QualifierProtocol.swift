//
//  QualifierProtocol.swift
//  HaskellSwift
//
//  Created by Liang on 07/11/2015.
//  Copyright © 2015 Liang. All rights reserved.
//

import Foundation
//import SwiftCheck

protocol QualifierProtocol {
    func arrayQualifier<A : Equatable>(_ xs : [A]) -> Property
    func stringQualifier(_ xs : String) -> Property
    func generate()
}

extension QualifierProtocol {
    func arrayQualifier<A : Equatable>(_ xs : [A]) -> Property {
        print("Protocol extension call")
        return xs.count >= 0 ==> {
            return false
        }
    }
    
    func stringQualifier(_ xs : String) -> Property {
        return xs.characters.count >= 0 ==> {
            return false
        }
    }
    
    func generate() {
        property("[Int]") <- forAll { (xs : ArrayOf<Int>) in
            return self.arrayQualifier(xs.getArray)
        }
        
        property("[Character]") <- forAll { (xs : ArrayOf<Character>) in
            return self.arrayQualifier(xs.getArray)
        }
        
        property("[String]") <- forAll { (xs : ArrayOf<String>) in
            return self.arrayQualifier(xs.getArray as [String])
        }
        
        property("String") <- forAll { (xs : String) in
            return self.stringQualifier(xs)
        }
    }
}
