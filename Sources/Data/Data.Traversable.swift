//
//  Data.Traversable.swift
//  HaskellSwift
//
//  Created by Liang on 15/03/2016.
//  Copyright © 2016 Liang. All rights reserved.
//

import Foundation

public func sequenceA<A>(_ fs: [(A)->Any], _ x: A) -> [Any] {
    return fs.map( {$0(x)} )
}

public func sequenceA<A>(_ fs: [(A)->Any]) -> ((A) -> [Any]) {
    return { (x: A) -> [Any] in fs.map( {$0(x) }) }
}

public func sequenceA<A>(_ fs: [(A)->Void], _ x: A) -> [Void] {
    return fs.map( {$0(x)} )
}

public func sequenceA(_ fs: [(Void)->Void]) -> [Void] {
    return fs.map( {$0()} )
}

public func sequenceA<A>(_ fs: [(A)->Void]) -> ((A) -> [Void]) {
    return { (x: A) -> [Void] in fs.map( {$0(x) }) }
}
