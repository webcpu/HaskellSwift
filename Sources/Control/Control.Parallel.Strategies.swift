//
//  Control.Parallel.Strategies.swift
//  HaskellSwift
//
//  Created by Liang on 27/05/2016.
//  Copyright © 2016 Liang. All rights reserved.
//

import Foundation

public func parMap<T,U>(_ transform: (T)->U, _ xs: [T]) -> [U] {
    let len     = length(xs)
    var results = [U?](repeating: nil, count: len)
    let process = { (i: Int) -> Void in results[i] = transform(xs[i]) }
    _   = DispatchQueue.global(attributes: DispatchQueue.GlobalAttributes(rawValue: UInt64(0)))
    DispatchQueue.concurrentPerform(iterations: len, execute: process)
    return map(fromJust, results)
}
