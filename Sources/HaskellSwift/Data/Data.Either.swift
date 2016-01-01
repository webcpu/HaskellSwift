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
public func fromRight<A,B>(a: Either<A,B>) -> B {
    switch a {
    case .Left(_):
        assert(false)
    case .Right(let right):
        return right
    }
}

//MARK: either :: (a -> c) -> (b -> c) -> Either a b -> c
func either<A, B, C>(leftHandler: A->C, _ rightHandler: B->C, _ e: Either<A, B>) -> C {
    if isLeft(e) {
        return leftHandler(fromLeft(e))
    } else {
        return rightHandler(fromRight(e))
    }
}
