//
//  Control.Applicative.swift
//  HaskellSwift
//
//  Created by Liang on 02/09/2015.
//  Copyright © 2015 Liang. All rights reserved.
//

import Foundation

//MARK: - Applicative []
//MARK: <*>
infix operator <*> { associativity right precedence 100}
public func <*> <A,B>(fs: [A->B], xs: [A])->[B] {
    let transform   = {(f: A->B)->[B] in
        return map(f, xs)
    }
    let xss         = map(transform, fs)
    return xss.flatMap { $0 }
}

infix operator *> { associativity right precedence 100}
public func *><A, B>(xs: [A], ys: [B]) -> [B]{
    return ys
}

infix operator <* { associativity right precedence 100}
public func <*<A, B>(xs: [A], ys: [B]) -> [A]{
    return xs
}

//MARK: - Applicative Maybe
public func <*> <A,B>(f: (A->B)?, a: A?)->B? {
    let b: B? = f!(fromJust(a))
    return b
}

public func *><A, B>(x: A?, y: B?) -> B?{
    return y
}

public func <*<A, B>(x: A?, y: B?) -> A?{
    return x
}

//MARK: - Applicative Either
public func <*> <A, B, E>(f: Either<E, A->B>, a: Either<E, A>)->Either<E, B> {
    let b = fromRight(f)(fromRight(a))
    return Either<E, B>.Right(b)
}

public func *><A, B, E>(x: Either<E, A>, y: Either<E, B>) -> Either<E, B> {
    return y
}

public func <*<A, B, E>(x: Either<E, A>, y: Either<E, B>) -> Either<E, A> {
    return x
}

//MARK: liftA []
func liftA<A, B>(f: A->B, _ xs: [A]) -> [B] {
    return map(f, xs)
}

func liftA2<A, B, C>(f: (A, B)->C, _ xs: [A], _ ys: [B]) -> [C] {
    typealias T = (A, B)
    let xys = zip(xs, ys)
    let transform = { (t: T) -> C in
        return f(fst(t), snd(t))
    }
    return map(transform, xys)
}