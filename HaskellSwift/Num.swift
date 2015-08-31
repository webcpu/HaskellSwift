//
//  Num.swift
//  HaskellSwift
//
//  Created by Liang on 31/08/2015.
//  Copyright © 2015 Liang. All rights reserved.
//

import Foundation

//MARK: negate :: a -> a
public func negate<A: SignedNumberType>(x: A) -> A {
    return -x
}