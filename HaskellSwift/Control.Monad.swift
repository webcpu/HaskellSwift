//
//  Control.Monad.swift
//  HaskellSwift
//
//  Created by Liang on 24/09/2015.
//  Copyright © 2015 Liang. All rights reserved.
//

import Foundation

infix operator >>= {associativity right precedence 100}

public func >>=<A, B>(xs: [A], f: A -> [B]) -> [B] {
    return xs.map(f).reduce([], combine: +)
}

public func >>=<A, B, C>(f: A->[B], g: B->[C]) -> (A->[C]) {
    return { (x : A) -> [C] in
        return concat(map(g, f(x)))
    }
}
