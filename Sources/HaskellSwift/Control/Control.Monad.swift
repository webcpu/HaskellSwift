//
//  Data.Monad.swift
//  HaskellSwift
//
//  Created by Liang on 24/09/2015.
//  Copyright © 2015 Liang. All rights reserved.
//

import Foundation

//MARK: - (>>=) :: Monad m => a -> (a -> m b) -> m b
infix operator >>>= {associativity right precedence 100}
//Array
public func >>>=<A, B>(xs: [A], f: A -> [B]) -> [B] {
    return xs.map(f).reduce([], combine: +)
}

//Maybe
public func >>>=<A, B>(x: A?, f: A -> B?) -> B? {
    return x == nil ? nil : f(x!)
}

//MARK: - (=<<) :: Monad m => (a -> m b) -> m a -> m b
infix operator =<<< {associativity left precedence 100}
//Array
public func =<<<<A, B>(f: A -> [B], xs: [A]) -> [B] {
    return xs.map(f).reduce([], combine: +)
}

//Maybe
public func =<<<<A, B>(f: A -> B?, a: A?) -> B? {
    return a == nil ? nil : f(a!)
}

//MARK: - (>=>) :: Monad m => (a -> m b) -> (b -> m c) -> a -> m c
infix operator >=> {associativity right precedence 100}
//Array
public func >=><A, B, C>(f: A->[B], g: B->[C]) -> (A->[C]) {
    return { (a : A) -> [C] in
        return concat(map(g, f(a)))
    }
}

//Maybe
public func >=><A, B, C>(f: A->B?, g: B->C?) -> (A->C?) {
    return { (a : A) -> C? in
        return f(a) >>>= g
    }
}

//MARK: - (<=<) :: Monad m => (b -> m c) -> (a -> m b) -> a -> m c
infix operator <=< {associativity left precedence 100}
//Array
public func <=<<A, B, C>(f: B->[C], g: A -> [B]) -> (A->[C]) {
    return { (a: A) -> [C] in
        return concat(map(f, g(a)))
    }
}

//Maybe
public func <=<<A, B, C>(f: B->C?, g: A->B?) -> (A->C?) {
    return { (a : A) -> C? in
        return g(a) >>>= f
    }
}

//Maybe Monad
public func fmap<A, B>(x: A?, _ f: A -> B?) -> B? {
    return x == nil ? nil : f(x!)
}
