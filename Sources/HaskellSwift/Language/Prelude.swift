//
//  Prelude.swift
//  HaskellSwift
//
//  Created by Liang on 02/03/2016.
//  Copyright © 2016 Liang. All rights reserved.
//

import Foundation

//MARK: succ
public func succ<A: IntegerType>(x: A) -> A {
    return x + 1
}

public func succ(x: Character) -> Character {
    let value = String(x).utf16.first
    assert(value != nil, "Unexpected Character: \(x)")
    return Character(UnicodeScalar(value! + 1))
}

//MARK: pred
public func pred<A: IntegerType>(x: A) -> A {
    return x - 1
}

public func pred(x: Character) -> Character {
    let value = String(x).utf16.first
    assert(value != nil, "Unexpected Character: \(x)")
    let newValue = value! == 0 ?  0 : value! - 1
    return Character(UnicodeScalar(newValue))
}

//MARK: enumFromTo
public func enumFromTo<A: IntegerType>(from: A, _ to: A) -> Array<A> {
    return Array<A>(from...to)
}

public func enumFromTo(from: Character, _ to: Character) -> String {
    guard
        let from    = String(from).utf16.first,
        let to      = String(to).utf16.first where to >= from else {
            return ""
    }
    let us = Array<UInt16>(from...to).map { Character(UnicodeScalar($0)) }
    return String(us)
}

//MARK: until
public func until<B>(@noescape condition: B -> Bool, @noescape _ process: B -> B,  _ initialValue: B) -> B {
    var value = initialValue
    repeat {
        value = process(value)
    } while (!condition(value))
    return value
}