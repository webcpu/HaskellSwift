//
//  DataList.swift
//  HaskellSwift
//
//  Created by Liang on 14/08/2015.
//  Copyright © 2015 Liang. All rights reserved.
//

import Foundation

infix operator • { associativity right precedence 100}
func •<A,B,C>(f2: B->C, f1: A->B) -> (A->C) {
    return { (x: A) in f2(f1(x)) }
}

//MARK: - Basic functions
//MARK: (++) :: [a] -> [a] -> [a]
infix operator ++ {}
func ++<A>(left: [A], right: [A]) -> [A] {
    return left + right
}

func ++(left: String, right: String) -> String {
    return left + right
}

//MARK: head :: [a] -> a
public func head<T>(xs: [T]) ->T {
    assert(xs.isEmpty != true, "Empty List")
    return xs[0]
}

public func head(xs: String) -> Character {
    assert(xs.isEmpty != true, "Empty List")
    let c =  xs[advance(xs.startIndex, 0)]
    return c
}

//MARK: last :: [a] -> a
public func last<T>(xs: [T]) ->T {
    assert(xs.isEmpty != true, "Empty List")
    return xs[xs.count - 1]
}

public func last(xs: String) -> Character {
    assert(xs.isEmpty != true, "Empty List")
    let c =  xs[advance(xs.endIndex, -1)]
    return c
}

//MARK: tail :: [a] -> [a]
public func tail<T>(xs: [T])->[T] {
    var list = [T]()
    assert(xs.count > 0, "Empty List")
    if xs.count == 1 {
        return list
    }
    
    for i in 1..<(xs.count) {
        list.append(xs[i])
    }
    
    return list
}

public func tail(xs: String)->String {
    var list = String()
    assert(xs.characters.count > 0, "Empty List")
    if xs.characters.count == 1 {
        return list
    }
    
    for i in 1..<(xs.characters.count) {
        let c = xs[advance(xs.startIndex, i)]
        list.append(c)
    }
    
    return list
}

//MARK: init :: [a] -> [a]
public func xinit<T>(xs: [T])->[T] {
    var list = [T]()
    assert(xs.count > 0, "Empty List")
    if xs.count == 1 {
        return list
    }
    
    for i in 0..<(xs.count - 1) {
        list.append(xs[i])
    }
    
    return list
}

public func xinit(xs: String)->String {
    var list = String()
    assert(xs.characters.count > 0, "Empty List")
    if xs.characters.count == 1 {
        return list
    }
    
    for i in 0..<(xs.characters.count - 1) {
        let c = xs[advance(xs.startIndex, i)]
        list.append(c)
    }
    
    return list
}

//MARK: null :: Foldable t => t a -> Bool
public func null<T>(xs: [T]) -> Bool {
    return xs.isEmpty
}

public func null(xs: String) -> Bool {
    return xs.characters.count == 0
}

//MARK: length :: Foldable t => t a -> Int
public func length<T>(xs: [T]) -> Int {
    return xs.count
}

public func length(xs: String) -> Int {
    return xs.characters.count
}

//MARK: - List transformations
//MARK: map :: (a -> b) -> [a] -> [b]
public func map(transform: Character->Character, _ xs: String) -> String {
    var results = String()
    for i in 0..<xs.characters.count {
        let c = xs[advance(xs.startIndex, i)]
        results.append(transform(c))
    }
    
    return results
}

public func map<U>(transform: Character-> U, _ xs: String) -> [U] {
    var results = [U]()
    for i in 0..<xs.characters.count {
        let c = xs[advance(xs.startIndex, i)]
        results.append(transform(c))
    }
    
    return results
}

public func map<T, U>(transform: T->U, _ xs: [T]) -> [U] {
    var results = [U]()
    for x in xs {
        results.append(transform(x))
    }
    
    return results
}

//MARK: reverse :: [a] -> [a]
public func reverse<T>(xs: [T]) -> [T] {
    return [T](xs.reverse())
}

public func reverse(xs: String) -> String {
    return String(xs.characters.reverse())
}

//MARK: - Reducing lists (folds)
//MARK: foldl :: Foldable t => (b -> a -> b) -> b -> t a -> b
public func foldl<A,B>(process: (A, B)->A, _ initialValue: A, _ xs: [B]) -> A {
    return reduce(process, initialValue, xs)
}

public func foldl(process: (String, Character)->String, _ initialValue: String, _ xs: String) -> String {
    return reduce(process, initialValue, xs)
}

public func reduce<S, T> (combine: (T, S)->T, _ initial: T, _ xs: [S]) -> T {
    var result = initial
    for x in xs {
        result = combine(result, x)
    }
    
    return result
}

public func reduce(combine: (String, Character)->String, _ initial: String, _ xs: String) -> String {
    var result = initial
    for x in xs.characters {
        result = combine(result, x)
    }
    
    return result
}

//MARK: foldr :: Foldable t => (a -> b -> b) -> b -> t a -> b
public func foldr<A,B>(process: (A, B)->B, _ initialValue: B, _ xs: [A]) -> B {
    var result = initialValue
    for x in xs.reverse() {
        result = process(x, result)
    }
    
    return result
}

public func foldr(process: (Character, String)->String, _ initialValue: String, _ xs: String) -> String {
    var result = initialValue
    for x in xs.characters.reverse() {
        result = process(x, result)
    }
    
    return result
}

//MARK: - Building lists
//MARK: Scans

//MARK: - Sublists
//MARK: Extracting sublists
//MARK: take :: Int -> [a] -> [a]
public func take<T>(len: Int, _ xs: [T]) -> [T] {
    assert(len >= 0 , "Illegal Length")
    var list = [T]()
    if len == 0 {
        return list
    }
    
    if len >= xs.count {
        return xs
    }
    
    for i in 0..<len {
        list.append(xs[i])
    }
    
    return list
}

//MARK: - Special folds
//MARK: concat :: Foldable t => t [a] -> [a]
public func concat<A> (xss: [[A]]) -> [A] {
   // assert(xs.count >= 0 , "Illegal Length")
    var xs = [A]()
   
    let process = { (a : [A], b: [A]) in a + b }
    xs          = foldl(process, xs, xss)
    
    return xs
}

public func concat (xss: [String]) -> String {
    var xs = String()
    
    let process = { (a : String, b: String) in a + b }
    xs          = foldl(process, xs, xss)
    
    return xs
}

//MARK: concatMap :: Foldable t => (a -> [b]) -> t a -> [b]
public func concatMap<A, B> (process: A->[B], _ xs: [A]) -> [B] {
    // assert(xs.count >= 0 , "Illegal Length")
    
    var xss          = [[B]]()
    for x in xs {
        xss.append(process(x))
    }
    
    let results      = concat(xss)
    
    return results
}

//MARK: and :: Foldable t => t Bool -> Bool
public func and(xs: [Bool]) -> Bool {
    for x in xs {
        if x == false {
            return false
        }
    }
    return true
}

//MARK: or :: Foldable t => t Bool -> Bool
public func or(xs: [Bool]) -> Bool {
    for x in xs {
        if x {
            return true
        }
    }
    return false
}

//MARK: any :: Foldable t => (a -> Bool) -> t a -> Bool
public func any<A>(process: A->Bool, _ xs: [A]) -> Bool {
    for x in xs {
        let isMatched = process(x)
        if isMatched {
            return true
        }
    }
    return false
}

public func any(process: Character->Bool, _ xs: String) -> Bool {
    for x in xs.characters {
        let isMatched = process(x)
        if isMatched {
            return true
        }
    }
    return false
}

//MARK: all :: Foldable t => (a -> Bool) -> t a -> Bool
public func all<A>(process: A->Bool, _ xs: [A]) -> Bool {
    for x in xs {
        let isMatched = process(x)
        if !isMatched {
            return false
        }
    }
    return true
}

public func all(process: Character->Bool, _ xs: String) -> Bool {
    for x in xs.characters {
        let isMatched = process(x)
        if !isMatched {
            return false
        }
    }
    return true
}

//MARK: sum :: (Foldable t, Num a) => t a -> a
public func sum(xs: [CGFloat])-> CGFloat {
     return reduce(+, 0, xs)
}

public func sum(xs: [Double])-> Double {
    return reduce(+, 0, xs)
}

public func sum(xs: [Float])-> Float {
    return reduce(+, 0, xs)
}

public func sum(xs: [Int])-> Int {
    return reduce(+, 0, xs)
}

public func sum(xs: [Int16])-> Int16 {
    return reduce(+, 0, xs)
}

public func sum(xs: [Int32])-> Int32 {
    return reduce(+, 0, xs)
}

public func sum(xs: [Int64])-> Int64 {
    return reduce(+, 0, xs)
}

public func sum(xs: [Int8])-> Int8 {
    return reduce(+, 0, xs)
}

public func sum(xs: [UInt])-> UInt {
    return reduce(+, 0, xs)
}

public func sum(xs: [UInt16])-> UInt16 {
    return reduce(+, 0, xs)
}

public func sum(xs: [UInt32])-> UInt32 {
    return reduce(+, 0, xs)
}

public func sum(xs: [UInt64])-> UInt64 {
    return reduce(+, 0, xs)
}

public func sum(xs: [UInt8])-> UInt8 {
    return reduce(+, 0, xs)
}

public protocol Arithmetic {
    func +(lhs: Self, rhs: Self) -> Self
    func *(lhs: Self, rhs: Self) -> Self
}

extension CGFloat: Arithmetic {}
extension Double: Arithmetic {}
extension Float: Arithmetic {}
extension Int: Arithmetic {}
extension Int16: Arithmetic {}
extension Int32: Arithmetic {}
extension Int64: Arithmetic {}
extension Int8: Arithmetic {}
extension UInt: Arithmetic {}
extension UInt16: Arithmetic {}
extension UInt32: Arithmetic {}
extension UInt64: Arithmetic {}
extension UInt8: Arithmetic {}

//MARK: product :: (Foldable t, Num a) => t a -> a
public func product(xs: [CGFloat])-> CGFloat {
    return reduce(*, 1, xs)
}

public func product(xs: [Double])-> Double {
    return reduce(*, 1, xs)
}

public func product(xs: [Float])-> Float {
    return reduce(*, 1, xs)
}

public func product(xs: [Int])-> Int {
    return reduce(*, 1, xs)
}

public func product(xs: [Int16])-> Int16 {
    return reduce(*, 1, xs)
}

public func product(xs: [Int32])-> Int32 {
    return reduce(*, 1, xs)
}

public func product(xs: [Int64])-> Int64 {
    return reduce(*, 1, xs)
}

public func product(xs: [Int8])-> Int8 {
    return reduce(*, 1, xs)
}

public func product(xs: [UInt])-> UInt {
    return reduce(*, 1, xs)
}

public func product(xs: [UInt16])-> UInt16 {
    return reduce(*, 1, xs)
}

public func product(xs: [UInt32])-> UInt32 {
    return reduce(*, 1, xs)
}

public func product(xs: [UInt64])-> UInt64 {
    return reduce(*, 1, xs)
}

public func product(xs: [UInt8])-> UInt8 {
    return reduce(*, 1, xs)
}

//MARK: maximum :: forall a. (Foldable t, Ord a) => t a -> a
public func maximum<T: Comparable>(xs: [T])-> T {
    assert(xs.count > 0, "Empty List")
    var m = xs[0]
    
    for x in xs {
        if x > m {
            m = x
        }
    }
    return m
}

//MARK: minimum :: forall a. (Foldable t, Ord a) => t a -> a
public func minimum<T: Comparable>(xs: [T])-> T {
    assert(xs.count > 0, "Empty List")
    var m = xs[0]
    
    for x in xs {
        if x < m {
            m = x
        }
    }
    return m
}

//MARK: - Sublists
//MARK: Extracting sublists
//MARK: take :: Int -> [a] -> [a]
public func take(len: Int, _ xs: String)->String {
    var list = String()
    assert(len >= 0, "Illegal Length")
    if len == 0 {
        return list
    }
    
    if len >= xs.characters.count {
        return xs
    }
    
    for i in 0..<len {
        let c = xs[advance(xs.startIndex, i)]
        list.append(c)
    }
    
    return list
}

//MARK: drop :: Int -> [a] -> [a]
public func drop<T>(len: Int, _ xs: [T]) -> [T] {
    assert(len >= 0, "Illegal Length")
    var list = [T]()
    if len == 0 {
        return xs
    }
    
    if len >= xs.count {
        return list
    }
    
    for i in len..<xs.count {
        list.append(xs[i])
    }
    
    return list
}

public func drop(len: Int, _ xs: String)->String {
    var list = String()
    assert(len >= 0, "Illegal Length")
    if len == 0 {
        return xs
    }
    
    if len >= xs.characters.count {
        return list
    }
    
    for i in len..<(xs.characters.count) {
        let c = xs[advance(xs.startIndex, i)]
        list.append(c)
    }
    
    return list
}

//MARK: splitAt :: Int -> [a] -> ([a], [a])
public func splitAt<T>(len: Int, _ xs: [T]) -> ([T], [T]) {
    assert(len >= 0, "Illegal Length")
    
    let list1 = take(len, xs)
    let list2 = drop(len, xs)
    
    return (list1, list2)
}

public func splitAt(len: Int, _ xs: String)->(String, String) {
    assert(len >= 0, "Illegal Length")
    
    let list1 = take(len, xs)
    let list2 = drop(len, xs)
    
    return (list1, list2)
}

//MARK: takeWhile :: (a -> Bool) -> [a] -> [a]
public func takeWhile<U>(check: U -> Bool, _ xs: [U]) -> [U] {
    return filter(check, xs)
}

public func takeWhile(check: Character -> Bool, _ xs: String) -> String {
    return filter(check, xs)
}

//MARK: dropWhile :: (a -> Bool) -> [a] -> [a]
public func dropWhile<U>(check: U -> Bool, _ xs: [U]) -> [U] {
    return filter( { x in !check(x)}, xs)
}

public func dropWhile(check: Character -> Bool, _ xs: String) -> String {
    return filter({x in !check(x)}, xs)
}

//MARK: - Searching lists
//MARK: Searching by equality

//MARK: Searching with a predicate
//MARK: filter :: (a -> Bool) -> [a] -> [a]
public func filter<U>(check: U -> Bool, _ xs: [U]) -> [U] {
    var results = [U]()
    for x in xs {
        if check(x) {
            results.append(x)
        }
    }
    
    return results
}

public func filter(check: Character -> Bool, _ xs: String) -> String {
    var results = String()
    for x in xs.characters {
        if check(x) {
            results.append(x)
        }
    }
    
    return results
}

//MARK: Indexing lists
