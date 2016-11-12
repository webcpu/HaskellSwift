//
//  Data.Functor.swift
//  HaskellSwift
//
//  Created by Liang on 30/08/2015.
//  Copyright © 2015 Liang. All rights reserved.
//

import Foundation

//MARK: fmap
//fmap :: (a -> b) -> f a -> f b
public func fmap<A,B,C>(_ f1: @escaping (B)->C, _ f2: @escaping (A)->B)->((A)->C) {
    return {(a: A) in f1(f2(a))}
}

//MARK: <^> or <$>
//infix of symnonym for fmap, <$> is illeagal in swift, that's why I have to use <^> instead of <$>
precedencegroup FunctionPrecedence {
    associativity: right
}
infix operator <^> : FunctionPrecedence
public func <^> <A,B,C>(f1: @escaping (B)->C, f2: @escaping (A)->B)->((A)->C) {
    return {(a: A) in f1(f2(a))}
}

//MARK: <| or <$
//Replace all locations in the input with the same value.
//<$ is illeagal in swift, that's why I have to use <| instead of <$
infix operator <| : FunctionPrecedence
func <| <A,B>(a: A, f: @escaping ((A)->B)) -> ((A)->B) {
    return { _ in f(a) }
}

func <| <A,B>(a: A, xs: [B]) -> [A] {
    return map({_ in a}, xs)
}

func <| <A,B,C>(a: A, t: (B, C)) -> (B,A) {
    return (t.0, a)
}

//MARK: |> or $>
//Flipped version <|
//$> is illeagal in swift, that's why I have to use |> instead of $>
infix operator |> { associativity right precedence 100}
func |> <A,B>(f: @escaping ((A)->B), a: A) -> ((A)->B) {
    return { _ in f(a) }
}

func |> <A,B>(xs: [B], a: A) -> [A] {
    return map({_ in a}, xs)
}

func |> <A,B,C>(t: (B, C), a: A) -> (B,A) {
    return (t.0, a)
}
