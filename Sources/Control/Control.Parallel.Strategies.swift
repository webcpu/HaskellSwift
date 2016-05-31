//
//  Control.Parallel.Strategies.swift
//  HaskellSwift
//
//  Created by Liang on 27/05/2016.
//  Copyright © 2016 Liang. All rights reserved.
//

import Foundation

public func parMap<T,U>(transform: T->U, _ xs: [T]) -> [U] {
    let len     = length(xs)
    var results = [U?](count: len, repeatedValue: nil)
    let process = { (i: Int) -> Void in results[i] = transform(xs[i]) }
    let queue   = dispatch_get_global_queue(0, 0)
    dispatch_apply(len, queue, process)
    return map(fromJust, results)
}
