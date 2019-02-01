//
//  Data.Monad.swift
//  HaskellSwift
//
//  Created by Liang on 24/09/2015.
//  Copyright © 2015 Liang. All rights reserved.
//

import Foundation

//MARK: - (>>=) :: Monad m => a -> (a -> m b) -> m b
precedencegroup LeftFunctionPrecedence {
    associativity: left
}

precedencegroup FunctionPrecedence {
    associativity: right
}

infix operator >>>= : LeftFunctionPrecedence
//Array
public func >>>=<A, B>(xs: [A], f: (A) -> [B]) -> [B] {
    return xs.map(f).reduce([], +)
}

//It's a sort of workaround
public func >>>=<A, B, C>(f: @escaping (A)->[B], g: @escaping (B)->[C]) -> ((A)->[C]) {
    return { (a : A) -> [C] in
        return concat(map(g, f(a)))
    }
}

//Maybe
public func >>>=<A, B>(x: A?, f: (A) -> B?) -> B? {
    return x == nil ? nil : f(x!)
}

public func >>>=<A, B, C>(f: @escaping (A)->B?, g: @escaping (B)->C?) -> ((A)->C?) {
    return { (a : A) -> C? in
        return f(a) >>>= g
    }
}

//Either
public func >>>=<A, B, E>(_ x: Either<E, A>, _ f: (A) -> Either<E, B>) -> Either<E, B> {
    return isLeft(x) ? try! Left(fromLeft(x)) : f(try! fromRight(x))
}

public func >>>= <A, B, C, E>( f: @escaping (A) -> Either<E, B>,
                  g: @escaping (B) -> Either<E, C>)
    -> (Either<E, A>) -> Either<E, C> {
        return { x in (x >>>= f) >>>= g }
}

//MARK: - (>=>) :: Monad m => (a -> m b) -> (b -> m c) -> a -> m c
infix operator >=> : LeftFunctionPrecedence
//Array
public func >=><A, B, C>(f: @escaping (A)->[B], g: @escaping (B)->[C]) -> ((A)->[C]) {
    return { (a : A) -> [C] in
        return concat(map(g, f(a)))
    }
}

//Maybe
public func >=><A, B, C>(f: @escaping (A)->B?, g: @escaping (B)->C?) -> ((A)->C?) {
    return { (a : A) -> C? in
        return f(a) >>>= g
    }
}

//MARK: - (>>>):: Monad m => m a -> m a -> m a
infix operator >>> : LeftFunctionPrecedence
public func >>><A, B>(xs: [A], ys: [B]) -> [B] {
    return xs.isEmpty ? [] : ys
}

public func >>><A, B>(x: A?, y: B?) -> B? {
    return x == nil ? nil : y
}

//MARK: - (=<<) :: Monad m => (a -> m b) -> m a -> m b
infix operator =<<< : LeftFunctionPrecedence
//Array
public func =<<<<A, B>(f: (A) -> [B], xs: [A]) -> [B] {
    return xs.map(f).reduce([], +)
}

public func =<<<<A, B, C>(f: @escaping (B)->[C], g: @escaping (A) -> [B]) -> ((A)->[C]) {
    return { (a: A) -> [C] in
        return concat(map(f, g(a)))
    }
}

//Maybe
public func =<<<<A, B>(f: (A) -> B?, a: A?) -> B? {
    return a == nil ? nil : f(a!)
}

public func =<<<<A, B, C>(f: @escaping (B)->C?, g: @escaping (A)->B?) -> ((A)->C?) {
    return { (a : A) -> C? in
        return g(a) >>>= f
    }
}

//MARK: - (<=<) :: Monad m => (b -> m c) -> (a -> m b) -> a -> m c
infix operator <=< : FunctionPrecedence
//Array
public func <=<<A, B, C>(f: @escaping (B)->[C], g: @escaping (A) -> [B]) -> ((A)->[C]) {
    return { (a: A) -> [C] in
        return concat(map(f, g(a)))
    }
}

//Maybe
public func <=<<A, B, C>(f: @escaping (B)->C?, g: @escaping (A)->B?) -> ((A)->C?) {
    return { (a : A) -> C? in
        return g(a) >>>= f
    }
}

//MARK: - (<<<)Monad m => m a -> m a -> m a
infix operator <<< : FunctionPrecedence
public func <<<<A>(ys: [A], xs: [A]) -> [A] {
    return xs.count > 0 ? xs : ys
}

//MARK: - return :: Monad m => a -> m a
public func pure<A>(_ x: A) -> [A] {
    return [x]
}

public func pure<A>(_ x: A) -> A? {
    return Optional<A>.some(x)
}

public func <<<<A, B>(ys: [B], f: @escaping (A) -> [B]) -> ((A)->[B]) {
    return { (x: A) in
        let xs = f(x)
        return xs.isEmpty ? [] : ys
    }
}

public func <<< <A, B>(y: B?, x: A?) -> B? {
    return x == nil ? nil : y
}

//Maybe Monad
public func fmap<A, B>(_ x: A?, _ f: (A) -> B?) -> B? {
    return x == nil ? nil : f(x!)
}
