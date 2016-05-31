//
//  Data.Either.swift
//  HaskellSwift
//
//  Created by Liang on 29/08/2015.
//  Copyright © 2015 Liang. All rights reserved.
//

import Foundation

public indirect enum Either<A, B> {
    case Left(A)
    case Right(B)
}

//MARK: isLeft :: Either a b -> Bool
public func isLeft<A,B>(a: Either<A,B>) -> Bool {
    switch a {
    case .Left(_):
        return true
    case .Right(_):
        return false
    }
}

//MARK: isRight :: Either a b -> Bool
public func isRight<A,B>(a: Either<A,B>) -> Bool {
    return !isLeft(a)
}

//MARK: fromLeft :: Either a b -> a
public func fromLeft<A,B>(a: Either<A,B>) -> A {
    switch a {
    case .Left(let left):
        return left
    case .Right(_):
        assert(false)
    }
}

//MARK: fromRight :: Either a b -> b
public func fromRight<A,B>(a: Either<A,B>) -> B! {
    switch a {
    case .Left(_):
        assert(false)
    case .Right(let right):
        return right
    }
}

//MARK: either :: (a -> c) -> (b -> c) -> Either a b -> c
func either<A, B, C>(leftHandler: A->C, _ rightHandler: B->C, _ e: Either<A, B>) -> C {
    switch e {
    case .Left(let left):
        return leftHandler(left)
    case .Right(let right):
        return rightHandler(right)
    }
}

//MARK: lefts :: [Either a b] -> [a]
func lefts<A, B>(es: [Either<A, B>]) -> [A] {
    let xs = es.filter( { (e: Either<A, B>) -> Bool in
        return isLeft(e)
    })
    return xs.map(fromLeft)
}

//MARK: rights:: [Either a b] -> [b]
func rights<A, B>(es: [Either<A, B>]) -> [B] {
    let xs = es.filter( { (e: Either<A, B>) -> Bool in
        return isRight(e)
    })
    return xs.map(fromRight)
}

//MARK: partitionEithers :: [Either a b] -> ([a], [b])
func partitionEithers<A, B>(es: [Either<A, B>]) -> ([A], [B]) {
    return (lefts(es), rights(es))
}