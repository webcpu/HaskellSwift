//
//  DataList.swift
//  HaskellSwift
//
//  Created by Liang on 14/08/2015.
//  Copyright © 2015 Liang. All rights reserved.
//

import Foundation

#if os(iOS) || os(tvOS) || os(watchOS)
import UIKit
#endif

public enum Ordering {
    case lt
    case eq
    case gt
}

public func not(_ value: Bool) -> Bool {
    return !value
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
public func head<T>(_ xs: [T]) ->T {
    assert(xs.isEmpty != true, "Empty List")
    return xs[0]
}

public func head(_ xs: String) -> Character {
    assert(xs.isEmpty != true, "Empty List")
    let c =  xs[xs.startIndex]
    return c
}

//MARK: last :: [a] -> a
public func last<T>(_ xs: [T]) ->T {
    assert(xs.isEmpty != true, "Empty List")
    return xs[xs.count - 1]
}

public func last(_ xs: String) -> Character {
    assert(xs.isEmpty != true, "Empty List")
    let c =  xs[xs.characters.index(before: xs.endIndex)]
    return c
}

//MARK: tail :: [a] -> [a]
public func tail<T>(_ xs: [T])->[T] {
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

public func tail(_ xs: String)->String {
    var list = String()
    assert(xs.characters.count > 0, "Empty List")
    if xs.characters.count == 1 {
        return list
    }
    
    for i in 1..<(xs.characters.count) {
        let c = xs[xs.characters.index(xs.startIndex, offsetBy: i)]
        list.append(c)
    }
    
    return list
}

//MARK: init :: [a] -> [a]
public func initx<T>(_ xs: [T])->[T] {
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

public func initx(_ xs: String)->String {
    var list = String()
    assert(xs.characters.count > 0, "Empty List")
    if xs.characters.count == 1 {
        return list
    }
    
    for i in 0..<(xs.characters.count - 1) {
        let c = xs[xs.characters.index(xs.startIndex, offsetBy: i)]
        list.append(c)
    }
    
    return list
}

//MARK: uncons :: [a] -> Maybe (a, [a])
public func uncons<A>(_ xs: [A]) -> (A, [A])? {
    return length(xs) > 0 ? (head(xs), tail(xs)) : nil
}

public func uncons(_ xs: String) -> (Character, String)? {
    return length(xs) > 0 ? (head(xs), tail(xs)) : nil
}

//MARK: null :: Foldable t => t a -> Bool
public func null<T>(_ xs: [T]) -> Bool {
    return xs.isEmpty
}

public func null(_ xs: String) -> Bool {
    return xs.characters.isEmpty
}

//MARK: length :: Foldable t => t a -> Int
public func length<T>(_ xs: [T]) -> Int {
    return xs.count
}

public func length(_ xs: String) -> Int {
    return xs.characters.count
}

//MARK: - List transformations
//MARK: map :: (a -> b) -> [a] -> [b]
public func map(_ transform: (Character)->Character, _ xs: String) -> String {
    var results = String()
    for i in 0..<xs.characters.count {
        let c = xs[xs.characters.index(xs.startIndex, offsetBy: i)]
        results.append(transform(c))
    }
    
    return results
}

public func map<U>(_ transform: (Character)-> U, _ xs: String) -> [U] {
    var results = [U]()
    for i in 0..<xs.characters.count {
        let c = xs[xs.characters.index(xs.startIndex, offsetBy: i)]
        results.append(transform(c))
    }
    
    return results
}

public func map<T, U>(_ transform: (T)->U, _ xs: [T]) -> [U] {
    var results = [U]()
    for x in xs {
        results.append(transform(x))
    }
    
    return results
}

public func map(_ transform: (Character)->Character) -> ((String) -> String) {
    return curry(map, transform)
}

public func map<U>(_ transform: (Character)-> U) -> ((String) -> [U]) {
    return curry(map, transform)
}

public func map<T, U>(_ transform: (T)->U) -> (([T]) -> [U]) {
    return curry(map, transform)
}

public func map<T: Collection, U>( _ transform: @noescape(T.Iterator.Element) -> U, _ xs: T) -> [U] {
    var ys = [U]()
    for x in xs {
        ys.append(transform(x))
    }
    return ys
}

//public func map<T: CollectionType>(@noescape transform: (T.Generator.Element) -> Character, _ xs: T) -> String {
//    var ys = String()
//    for x in xs {
//        ys = ys + String(transform(x))
//    }
//    return ys
//}

public func map<T: Collection, U>( _ transform: @noescape(T.Iterator.Element) -> U) -> ((T) -> [U]) {
    return curry(map, transform)
}

//public func map<T: CollectionType>(@noescape transform: (T.Generator.Element) -> Character) -> (T -> String) {
//    return curry(map, transform)
//}

//MARK: reverse :: [a] -> [a]
public func reverse<T>(_ xs: [T]) -> [T] {
    return [T](xs.reversed())
}

public func reverse(_ xs: String) -> String {
    return String(xs.characters.reversed())
}

//MARK: intersperse :: a -> [a] -> [a]
public func intersperse<T>(_ separator: T, _ xs: [T]) -> [T] {
    if xs.count <= 1 {
        return xs
    }
    let combine = { (a: [T], b: T) -> [T] in a + [separator] + [b] }
    return foldl(combine, [xs[0]], tail(xs))
}

public func intersperse(_ separator: Character, _ xs: String) -> String {
    if xs.characters.count <= 1 {
        return xs
    }
    let combine = { (a: String, b: Character) -> String in a + String(separator) + String(b) }
    return foldl(combine, String(head(xs)), tail(xs))
}

public func intersperse<T>(_ separator: T) -> (([T]) -> [T]) {
    return curry(intersperse, separator)
}

public func intersperse(_ separator: Character) -> ((String) -> String) {
    return curry(intersperse, separator)
}

//MARK: intercalate :: [a] -> [[a]] -> [a]
public func intercalate<T>(_ xs: [T], _ xss: [[T]]) -> [T] {
    return concat(intersperse(xs, xss))
}

public func intercalate(_ xs: String, _ xss: [String]) -> String {
    return concat(intersperse(xs, xss))
}

//MARK: transpose :: [[a]] -> [[a]]
//r * c -> c * r
public func transpose<B>(_ xss: [[B]]) -> [[B]] {
    var bss = [[B]]()
    
    let cols = maximumBy({ (x , y) -> Ordering in
        if x > y {
            return Ordering.gt
        } else {
            return Ordering.lt
        }}, map({ x in length(x)}, xss))
    
    for c in  0..<cols {
        var bs = [B]()
        for r in 0..<length(xss) {
            if c < length(xss[r]) {
                bs.append(xss[r][c])
            }
        }
        bss.append(bs)
    }
    
    return bss
}

public func transpose(_ xss: [String]) -> [String] {
    var bss = [String]()
    
    let cols = maximumBy({ (x , y) -> Ordering in
        if x > y {
            return Ordering.gt
        } else {
            return Ordering.lt
        }}, map({ x in length(x)}, xss))
    
    for c in  0..<cols {
        var bs = String()
        for r in 0..<length(xss) {
            if c < length(xss[r]) {
                let x = xss[r][xss[r].characters.index(xss[r].startIndex, offsetBy: c)]
                bs.append(x)
            }
        }
        bss.append(bs)
    }
    
    return bss
}

//MARK: subsequences :: [a] -> [[a]]
public func subsequences<B>(_ xs: [B]) -> [[B]] {
    if xs.isEmpty {
        return emptySubSequence()
    }
    
    return emptySubSequence() + nonEmptySubsequences(xs)
}

func emptySubSequence<B>() -> [[B]] {
    var r = [[B]]()
    r.append([B]())
    return r
}

func nonEmptySubsequences<B>(_ xs: [B]) -> [[B]] {
    if xs.isEmpty {
        return [[B]]()
    }
    
    let r0 = [head(xs)]
    let f  = { (ys: [B], r: [[B]]) -> [[B]] in [ys] + [[head(xs)] + ys] + r }
    let r1 = foldr(f, [[B]](), nonEmptySubsequences(tail(xs)))
    
    return [r0] + r1
}

public func subsequences(_ xs: String) -> [String] {
    if xs.isEmpty {
        return emptySubSequence()
    }
    
    return emptySubSequence() + nonEmptySubsequences(xs)
}

func emptySubSequence() -> [String] {
    var r = [String]()
    r.append(String())
    return r
}

func nonEmptySubsequences(_ xs: String) -> [String] {
    if xs.isEmpty {
        return [String]()
    }
    
    let r0 = String(head(xs))
    let f  = { (ys: String, r: [String]) -> [String] in [ys] + [String(head(xs)) + ys] + r }
    let r1 = foldr(f, [String](), nonEmptySubsequences(tail(xs)))
    
    return [r0] + r1
}

//MARK: permutations :: [a] -> [[a]]
public func permutations<B>(_ xs: [B]) -> [[B]] {
    if let (h, t) = uncons(xs) {
        let r0 = permutations(t)
        //return r0 >>= f
        let f =  { ys in between(h, ys) }
        return r0.map(f).reduce([], combine: +)
    } else {
        return [[]]
    }
}

public func permutations(_ xs: String) -> [String] {
    if let (h, t) = uncons(xs) {
        let r0 = permutations(t)
        let f  = { (ys: String) -> [String] in between(h, ys) }
        //return r0 >>=
        return r0.map(f).reduce([], combine: +)
    } else {
        return [""]
    }
}

func between<A>(_ x: A, _ ys: [A]) -> [[A]] {
    if let (h, t) = uncons(ys) {
        return [[x] + ys] + map({[h] + $0}, between(x, t))
    } else {
        return [[x]]
    }
}

func between(_ x: Character, _ ys: String) -> [String] {
    if let (h, t) = uncons(ys) {
        let rest = map({String(h) + $0}, between(x, t))
        return [String(x) + ys] + rest
    } else {
        return [String(x)]
    }
}

//MARK: - Reducing lists (folds)
//MARK: foldl :: Foldable t => (a -> b -> a) -> a -> t b -> a
public func foldl<A,B>(_ process: (A, B)->A, _ initialValue: A, _ xs: [B]) -> A {
    assert(!xs.isEmpty, "Empty List")
    return reduce(process, initialValue, xs)
}

public func foldl(_ process: (String, Character)->String, _ initialValue: String, _ xs: String) -> String {
    assert(!xs.isEmpty, "Empty List")
    return reduce(process, initialValue, xs)
}

public func foldl<A,B>(_ process: (A, B)->A, _ initialValue: A) -> (([B]) -> A) {
    return { (xs: [B]) -> A in
        foldl(process, initialValue, xs)
    }
}

public func foldl<A,B>(_ process: (A, B)->A) -> ((A) -> ([B]) -> A) {
    return { (initialValue: A) -> (([B]) -> A) in
        foldl(process, initialValue)
    }
}

public func foldl(_ process: (String, Character)->String, _ initialValue: String) ->((String) -> String) {
    return {(xs: String) -> String in
        foldl(process, initialValue, xs)
    }
}

public func foldl(_ process: (String, Character)->String) -> ((String) -> (String) -> String) {
    return  {(initialValue: String) -> ((String) -> String) in
        foldl(process, initialValue)
    }
}

//MARK: foldl1 :: Foldable t => (a -> b -> a) -> t b -> a
public func foldl1<A>(_ process: (A, A)->A, _ xs: [A]) -> A {
    assert(!xs.isEmpty, "Empty List")
    return foldl(process, xs[0], drop(1, xs))
}

public func foldl1(_ process: (String, Character)->String, _ xs: String) -> String {
    assert(xs.characters.count > 0, "Empty List")
    return foldl(process, String(xs[xs.startIndex]), drop(1, xs))
}

public func foldl1<A>(_ process: (A, A)->A) -> (([A]) -> A) {
    return curry(foldl1, process)
}

//MARK: reduce :: Foldable t => (b -> a -> b) -> b -> t a -> b
public func reduce<A, B> (_ combine: (A, B)->A, _ initial: A, _ xs: [B]) -> A {
    var result = initial
    for x in xs {
        result = combine(result, x)
    }
    
    return result
}

public func reduce(_ combine: (String, Character)->String, _ initial: String, _ xs: String) -> String {
    var result = initial
    for x in xs.characters {
        result = combine(result, x)
    }
    
    return result
}

public func reduce<A, B> (_ combine: (A, B)->A, _ initial: A) -> (([B]) -> A) {
    return { (xs: [B]) -> A in
        return reduce(combine, initial, xs)
    }
}

public func reduce<A, B> (_ combine: (A, B) -> A) -> ((A) -> ([B]) -> A) {
    return { (initial: A) -> (([B]) -> A) in
        return reduce(combine, initial)
    }
}

public func reduce(_ combine: (String, Character)->String, _ initial: String) -> ((String) -> String) {
    return { (xs: String) -> String in
        return reduce(combine, initial, xs)
    }
}

public func reduce(_ combine: (String, Character)-> String) -> (String) -> (String) -> String {
    return { (initial: String) -> ((String) -> String) in
        return reduce(combine, initial)
    }
}

//MARK: foldr :: Foldable t => (a -> b -> b) -> b -> t a -> b
public func foldr<A,B>(_ process: (A, B)->B, _ initialValue: B, _ xs: [A]) -> B {
    var result = initialValue
    for x in xs.reversed() {
        result = process(x, result)
    }
    
    return result
}

public func foldr(_ process: (Character, String)->String, _ initialValue: String, _ xs: String) -> String {
    var result = initialValue
    for x in xs.characters.reversed() {
        result = process(x, result)
    }
    
    return result
}

//public func foldr<A,B>(process: (A, B)->B, _ initialValue: B) -> ([A] -> B) {
//    return { (xs: [A]) -> B in
//        return foldr(process, initialValue, xs)
//    }
//}
//
//public func foldr<A,B>(process: (A, B)->B) ->  (B -> [A] -> B) {
//    return { (initialValue: B) -> ([A] -> B) in
//        return foldr(process, initialValue)
//    }
//}
//
//public func foldr(process: (Character, String)->String, _ initialValue: String) -> (String -> String) {
//    return { (xs: String) -> String in
//        return foldr(process, initialValue, xs)
//    }
//}
//
//public func foldr(process: (Character, String)->String) -> (String -> String -> String) {
//    return { (initialValue: String) -> (String -> String) in
//        return foldr(process, initialValue)
//    }
//}

//MARK: foldr1 :: Foldable t => (a -> a -> a) -> t a -> a
public func foldr1<A>(_ process: (A, A)->A, _ xs: [A]) -> A {
    assert(!xs.isEmpty, "Empty List")
    return foldr(process, xs[xs.count-1], take(xs.count - 1, xs))
}

public func foldr1(_ process: (Character, String)->String, _ xs: String) -> String {
    assert(xs.characters.count > 0, "Empty List")
    return foldr(process, String(xs[xs.characters.index(before: xs.endIndex)]), take(xs.characters.count - 1, xs))
}

public func foldr1<A>(_ process: (A, A)->A) -> (([A]) -> A) {
    return curry(foldr1, process)
}

public func foldr1(_ process: (Character, String)->String) -> ((String) -> String) {
    return curry(foldr1, process)
}

//MARK: - Building lists
//MARK: Scans
//MARK: scanl :: (b -> a -> b) -> b -> [a] -> [b]
public func scanl<A,B>(_ combine: (A, B)->A, _ initialValue: A, _ xs: [B]) -> [A] {
    assert(!xs.isEmpty, "Empty List")
    var ys      = [A]()
    var value   = initialValue
    for x in xs {
        value  = combine(value, x)
        ys.append(value)
    }
    
    return ys
}

public func scanl(_ combine: (String, Character)->String, _ initialValue: String, _ xs: String) -> [String] {
    assert(!xs.isEmpty, "Empty List")
    var ys      = [String]()
    var value   = initialValue
    for x in xs.characters {
        value  = combine(value, x)
        ys.append(value)
    }
    
    return ys
}

public func scanl<A,B>(_ combine: (A, B)->A, _ initialValue: A) -> (([B]) -> [A]) {
    return { (xs: [B]) -> [A] in
        return scanl(combine, initialValue, xs)
    }
}

public func scanl<A,B>(_ combine: (A, B)->A) -> ((A) -> (([B]) -> [A])) {
    return { (initialValue: A) -> (([B]) -> [A]) in
        return scanl(combine, initialValue)
    }
}

public func scanl(_ combine: (String, Character)->String, _ initialValue: String) -> ((String) -> [String]) {
    return { (xs: String) -> [String] in
        return scanl(combine, initialValue, xs)
    }
}

public func scanl(_ combine: (String, Character)->String) -> ((String) -> ((String) -> [String])) {
    return { (initialValue: String) -> ((String) -> [String]) in
        return scanl(combine, initialValue)
    }
}

//MARK: scanl' :: (b -> a -> b) -> b -> [a] -> [b]
//MARK: scanl1 :: (a -> a -> a) -> [a] -> [a]
public func scanl1<A>(_ combine: (A, A)->A, _ xs: [A]) -> [A] {
    assert(!xs.isEmpty, "Empty List")
    if xs.count == 1 {
        return xs
    }
    return [xs[0]] + scanl(combine, xs[0], drop(1, xs))
}

public func scanl1(_ combine: (String, Character)->String, _ xs: String) -> [String] {
    assert(xs.characters.count > 0, "Empty List")
    if xs.characters.count == 1 {
        return [xs]
    }
    let result = scanl(combine, String(xs[xs.startIndex]), drop(1, xs))
    return [String(xs[xs.startIndex])] + result
}

public func scanl1<A>(_ combine: (A, A)->A) -> (([A]) -> [A]) {
    return curry(scanl1, combine)
}

public func scanl1(_ combine: (String, Character)->String) -> ((String) -> [String]) {
    return curry(scanl1, combine)
}

//MARK: scanr :: (a -> b -> b) -> b -> [a] -> [b]
public func scanr<A,B>(_ combine: (A, B)->B, _ initialValue: B, _ xs: [A]) -> [B] {
    assert(!xs.isEmpty, "Empty List")
    var ys      = [B]()
    var value   = initialValue
    for x in xs.reversed() {
        value  = combine(x, value)
        ys.append(value)
    }
    
    return ys
}

public func scanr(_ combine: (Character, String)->String, _ initialValue: String, _ xs: String) -> [String] {
    assert(!xs.isEmpty, "Empty List")
    var ys      = [String]()
    var value   = initialValue
    for x in xs.characters.reversed() {
        value  = combine(x, value)
        ys.append(value)
    }
    
    return ys
}

public func scanr<A,B>(_ combine: (A, B)->B, _ initialValue: B) -> (([A]) -> [B]){
    return { (xs: [A]) -> [B] in
        return scanr(combine, initialValue, xs)
    }
}

public func scanr<A,B>(_ combine: (A, B)->B) -> ((B) -> (([A]) -> [B])) {
    return { (initialValue: B) -> (([A]) -> [B]) in
        return scanr(combine, initialValue)
    }
}

public func scanr(_ combine: (Character, String)->String, _ initialValue: String) -> ((String) -> [String]) {
    return { (xs: String) -> [String] in
        return scanr(combine, initialValue, xs)
    }
}

public func scanr(_ combine: (Character, String)->String) -> ((String) -> ((String) -> [String])) {
    return { (initialValue: String) -> ((String) -> [String]) in
        return scanr(combine, initialValue)
    }
}

//MARK: scanr1 :: (a -> a -> a) -> [a] -> [a]
public func scanr1<A>(_ combine: (A, A)->A, _ xs: [A]) -> [A] {
    assert(!xs.isEmpty, "Empty List")
    if xs.count == 1 {
        return xs
    }
    let ys = scanr(combine, last(xs), take(xs.count - 1, xs))
    return [last(xs)] + ys
}

public func scanr1(_ combine: (Character, String)->String, _ xs: String) -> [String] {
    assert(xs.characters.count > 0, "Empty List")
    if xs.characters.count == 1 {
        return [xs]
    }
    let ys = scanr(combine, String(last(xs)), take(xs.characters.count - 1, xs))
    return [String(last(xs))] + ys
}

public func scanr1<A>(_ combine: (A, A)->A) -> (([A]) -> [A]) {
    return curry(scanr1, combine)
}

public func scanr1(_ combine: (Character, String)->String) -> ((String) -> [String]) {
    return curry(scanr1, combine)
}

//MARK: - Accumulating maps
//MARK: mapAccumL :: Traversable t => (a -> b -> (a, c)) -> a -> t b -> (a, t c)
//MARK: mapAccumR :: Traversable t => (a -> b -> (a, c)) -> a -> t b -> (a, t c)

//MARK: Infinite lists
//MARK: iterate :: (a -> a) -> a -> [a]
//MARK: repeat :: a -> [a]

//MARK: replicate :: Int -> a -> [a]
public func replicate<A>(_ len: Int, _ value: A) -> [A] {
    return [A].init(repeating: value, count: len)
}

public func replicate<A>(_ len: Int) -> ((A) -> [A]) {
    return curry(replicate, len)
}

public func replicate(_ len: Int, _ value: Character) -> String {
    return String(repeating: value, count: len)
}

//MARK: cycle :: [a] -> [a]

//MARK: - Unfolding
//MARK: unfoldr :: (b -> Maybe (a, b)) -> b -> [a]
public func unfoldr<A,B>(_ f: (B) -> (A, B)?, _ seed: B) -> [A] {
    var xs  = [A]()
    var b   = seed
    repeat {
        let r    = f(b)
        guard r != nil else {
            break;
        }
        xs.append(r!.0)
        b       = r!.1
    } while (true)
    
    return xs
}

public func unfoldr<A,B>(_ f: (B) -> (A, B)?) -> ((B) -> [A]) {
    return curry(unfoldr,f)
}

//MARK: - Sublists
//MARK: Extracting sublists
//MARK: take :: Int -> [a] -> [a]


//MARK: - Special folds
//MARK: concat :: Foldable t => t [a] -> [a]
public func concat<A> (_ xss: [[A]]) -> [A] {
    // assert(xs.count >= 0 , "Illegal Length")
    var xs = [A]()
    if xss.isEmpty {
        return xs
    }
    
    let process = { (a : [A], b: [A]) in a + b }
    xs          = foldl(process, xs, xss)
    
    return xs
}

public func concat (_ xss: [String]) -> String {
    var xs = String()
    if xss.isEmpty {
        return xs
    }
    
    let process = { (a : String, b: String) in a + b }
    xs          = foldl(process, xs, xss)
    
    return xs
}

public func concat (_ xss: [Character]) -> String {
    var xs = String()
    if xss.isEmpty {
        return xs
    }
    
    let process = { (a : String, b: Character) in a + String(b) }
    xs          = foldl(process, xs, xss)
    
    return xs
}
//MARK: concatMap :: Foldable t => (a -> [b]) -> t a -> [b]
public func concatMap<A, B> (_ process: (A)->[B], _ xs: [A]) -> [B] {
    // assert(xs.count >= 0 , "Illegal Length")
    
    var xss          = [[B]]()
    for x in xs {
        xss.append(process(x))
    }
    
    let results      = concat(xss)
    
    return results
}

public func concatMap(_ process: (Character)->String, _ xs: [Character]) -> String {
    // assert(xs.count >= 0 , "Illegal Length")
    
    var xss          = [String]()
    for x in xs {
        xss.append(process(x))
    }
    
    let results      = concat(xss)
    
    return results
}

//MARK: and :: Foldable t => t Bool -> Bool
public func and(_ xs: [Bool]) -> Bool {
    for x in xs {
        if x == false {
            return false
        }
    }
    return true
}

//MARK: or :: Foldable t => t Bool -> Bool
public func or(_ xs: [Bool]) -> Bool {
    for x in xs {
        if x {
            return true
        }
    }
    return false
}

//MARK: any :: Foldable t => (a -> Bool) -> t a -> Bool
public func any<A>(_ process: (A)->Bool, _ xs: [A]) -> Bool {
    for x in xs {
        let isMatched = process(x)
        if isMatched {
            return true
        }
    }
    return false
}

public func any<A>(_ process:((A)->Bool)->Bool, _ xs: [(A)->Bool]) -> Bool {
    for x in xs {
        let isMatched = process(x)
        if isMatched {
            return true
        }
    }
    return false
}

public func any(_ process: (Character)->Bool, _ xs: String) -> Bool {
    for x in xs.characters {
        let isMatched = process(x)
        if isMatched {
            return true
        }
    }
    return false
}

//MARK: all :: Foldable t => (a -> Bool) -> t a -> Bool
public func all<A>(_ process: (A)->Bool, _ xs: [A]) -> Bool {
    for x in xs {
        let isMatched = process(x)
        if !isMatched {
            return false
        }
    }
    return true
}

public func all(_ process: (Character)->Bool, _ xs: String) -> Bool {
    for x in xs.characters {
        let isMatched = process(x)
        if !isMatched {
            return false
        }
    }
    return true
}

//MARK: sum :: (Foldable t, Num a) => t a -> a
public func sum(_ xs: [CGFloat])-> CGFloat {
    return reduce(+, 0, xs)
}

public func sum(_ xs: [Double])-> Double {
    return reduce(+, 0, xs)
}

public func sum(_ xs: [Float])-> Float {
    return reduce(+, 0, xs)
}

public func sum(_ xs: [Int]) -> Int {
    return reduce(+, 0, xs)
}

public func sum(_ xs: [Int16]) -> Int16 {
    return reduce(+, 0, xs)
}

public func sum(_ xs: [Int32]) -> Int32 {
    return reduce(+, 0, xs)
}

public func sum(_ xs: [Int64]) -> Int64 {
    return reduce(+, 0, xs)
}

public func sum(_ xs: [Int8]) -> Int8 {
    return reduce(+, 0, xs)
}

public func sum(_ xs: [UInt]) -> UInt {
    return reduce(+, 0, xs)
}

public func sum(_ xs: [UInt16]) -> UInt16 {
    return reduce(+, 0, xs)
}

public func sum(_ xs: [UInt32]) -> UInt32 {
    return reduce(+, 0, xs)
}

public func sum(_ xs: [UInt64]) -> UInt64 {
    return reduce(+, 0, xs)
}

public func sum(_ xs: [UInt8]) -> UInt8 {
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
public func product(_ xs: [CGFloat])-> CGFloat {
    return reduce(*, 1, xs)
}

public func product(_ xs: [Double])-> Double {
    return reduce(*, 1, xs)
}

public func product(_ xs: [Float])-> Float {
    return reduce(*, 1, xs)
}

public func product(_ xs: [Int]) -> Int {
    return reduce(*, 1, xs)
}

public func product(_ xs: [Int16]) -> Int16 {
    return reduce(*, 1, xs)
}

public func product(_ xs: [Int32]) -> Int32 {
    return reduce(*, 1, xs)
}

public func product(_ xs: [Int64]) -> Int64 {
    return reduce(*, 1, xs)
}

public func product(_ xs: [Int8]) -> Int8 {
    return reduce(*, 1, xs)
}

public func product(_ xs: [UInt]) -> UInt {
    return reduce(*, 1, xs)
}

public func product(_ xs: [UInt16]) -> UInt16 {
    return reduce(*, 1, xs)
}

public func product(_ xs: [UInt32]) -> UInt32 {
    return reduce(*, 1, xs)
}

public func product(_ xs: [UInt64]) -> UInt64 {
    return reduce(*, 1, xs)
}

public func product(_ xs: [UInt8]) -> UInt8 {
    return reduce(*, 1, xs)
}

//MARK: maximum :: forall a. (Foldable t, Ord a) => t a -> a
public func maximum<T: Comparable>(_ xs: [T])-> T {
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
public func minimum<T: Comparable>(_ xs: [T])-> T {
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
public func take<T>(_ len: Int, _ xs: [T]) -> [T] {
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

public func take<T>(_ len: Int) -> (([T]) -> [T]) {
    return curry(take, len)
}

public func take(_ len: Int, _ xs: String)->String {
    var list = String()
    assert(len >= 0, "Illegal Length")
    if len == 0 {
        return list
    }
    
    if len >= xs.characters.count {
        return xs
    }
    
    for i in 0..<len {
        let c = xs[xs.characters.index(xs.startIndex, offsetBy: i)]
        list.append(c)
    }
    
    return list
}

//MARK: drop :: Int -> [a] -> [a]
public func drop<T>(_ len: Int, _ xs: [T]) -> [T] {
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

public func drop(_ len: Int, _ xs: String)->String {
    var list = String()
    assert(len >= 0, "Illegal Length")
    if len == 0 {
        return xs
    }
    
    if len >= xs.characters.count {
        return list
    }
    
    for i in len..<(xs.characters.count) {
        let c = xs[xs.characters.index(xs.startIndex, offsetBy: i)]
        list.append(c)
    }
    
    return list
}

//MARK: splitAt :: Int -> [a] -> ([a], [a])
public func splitAt<T>(_ len: Int, _ xs: [T]) -> ([T], [T]) {
    assert(len >= 0, "Illegal Length")
    
    let list1 = take(len, xs)
    let list2 = drop(len, xs)
    
    return (list1, list2)
}

public func splitAt(_ len: Int, _ xs: String)->(String, String) {
    assert(len >= 0, "Illegal Length")
    
    let list1 = take(len, xs)
    let list2 = drop(len, xs)
    
    return (list1, list2)
}

//MARK: takeWhile :: (a -> Bool) -> [a] -> [a]
public func takeWhile<U>(_ check: (U) -> Bool, _ xs: [U]) -> [U] {
    let len = lengthOfWhile(check, xs)
    return take(len, xs)
}

func lengthOfWhile<U>(_ check: (U) -> Bool, _ xs: [U]) -> Int {
    var len = 0
    for i in 0..<xs.count {
        let result = check(xs[i])
        guard result else {
            break
        }
        len = i + 1
    }
    
    return len
}

public func takeWhile(_ check: (Character) -> Bool, _ xs: String) -> String {
    let len = lengthOfWhileForString(check, xs)
    return take(len, xs)
}

func lengthOfWhileForString(_ check: (Character) -> Bool, _ xs: String) -> Int {
    var len = 0
    for i in 0..<xs.characters.count {
        let c = xs[xs.characters.index(xs.startIndex, offsetBy: i)]
        guard check(c) else {
            break
        }
        len = i + 1
    }
    return len
}

//MARK: dropWhile :: (a -> Bool) -> [a] -> [a]
public func dropWhile<U>(_ check: (U) -> Bool, _ xs: [U]) -> [U] {
    var len = 0
    for i in 0..<xs.count {
        guard check(xs[i]) else {
            len = i
            break
        }
    }
    return drop(len, xs)
}

public func dropWhile(_ check: (Character) -> Bool, _ xs: String) -> String {
    let len = lengthOfWhileForString(check, xs)
    return drop(len, xs)
}

//MARK: span :: (a -> Bool) -> [a] -> ([a], [a])
public func span<U>(_ check: (U) -> Bool, _ xs: [U]) -> ([U], [U]) {
    let len = lengthOfWhile(check, xs)
    return (take(len, xs), drop(len, xs))
}

public func span(_ check: (Character) -> Bool, _ xs: String) -> (String, String) {
    let len = lengthOfWhileForString(check, xs)
    return (take(len, xs), drop(len, xs))
}

//MARK: break :: (a -> Bool) -> [a] -> ([a], [a])
public func breakx<U>(_ check: (U) -> Bool, _ xs: [U]) -> ([U], [U]) {
    let len = lengthOfWhile({(x: U) in !check(x) }, xs)
    return (take(len, xs), drop(len, xs))
}

public func breakx<U>(_ check: (U) -> Bool) -> ([U]) -> ([U], [U]) {
    return { xs in breakx(check, xs) }
}

public func breakx(_ check: (Character) -> Bool, _ xs: String) -> (String, String) {
    let len = lengthOfWhileForString({(x: Character) in !check(x)}, xs)
    return (take(len, xs), drop(len, xs))
}

public func breakx(_ check: (Character) -> Bool) -> (String) -> (String, String) {
    return curry(breakx, check)
}

//MARK: stripPrefix :: Eq a => [a] -> [a] -> Maybe [a]
public func stripPrefix<U: Equatable>(_ xs: [U], _ ys: [U]) -> [U]? {
    return isPrefixOf(xs, ys) ? drop(length(xs), ys) : nil
}

public func stripPrefix(_ xs: String, _ ys: String) -> String? {
    return isPrefixOf(xs, ys) ? drop(length(xs), ys) : nil
}

//MARK: group :: Eq a => [a] -> [[a]]
public func group<U: Equatable>(_ xs: [U]) -> [[U]] {
    return groupBy({x,y in x == y}, xs)
}

public func group(_ xs: String) -> [String] {
    return groupBy({x,y in x == y}, xs)
}

//MARK: inits :: [a] -> [[a]]
public func inits<U>(_ xs: [U]) -> [[U]] {
    var result = [[U]]()
    for i in 0...xs.count {
        result.append(take(i, xs))
    }
    
    return result
}

public func inits(_ xs: String) -> [String] {
    var result = [String]()
    for i in 0...xs.characters.count {
        result.append(take(i, xs))
    }
    
    return result
}

//MARK: tails :: [a] -> [[a]]
public func tails<U>(_ xs: [U]) -> [[U]] {
    var result = [[U]]()
    for i in 0...xs.count {
        result.append(drop(i, xs))
    }
    
    return result
}

public func tails(_ xs: String) -> [String] {
    var result = [String]()
    for i in 0...xs.characters.count {
        result.append(drop(i, xs))
    }
    
    return result
}

//MARK: - Predicates
//MARK: isPrefixOf :: Eq a => [a] -> [a] -> Bool
public func isPrefixOf<U: Equatable>(_ xs1: [U], _ xs2: [U]) -> Bool {
    return take(xs1.count, xs2) == xs1
}

public func isPrefixOf(_ xs1: String, _ xs2: String) -> Bool {
    return take(xs1.characters.count, xs2) == xs1
}

//MARK: isSuffixOf :: Eq a => [a] -> [a] -> Bool
public func isSuffixOf<U: Equatable>(_ xs1: [U], _ xs2: [U]) -> Bool {
    if xs1.count > xs2.count {
        return false
    }
    
    return drop(xs2.count - xs1.count, xs2) == xs1
}

public func isSuffixOf(_ xs1: String, _ xs2: String) -> Bool {
    if xs1.characters.count > xs2.characters.count {
        return false
    }
    
    return xs2.hasSuffix(xs1)//drop(xs2.characters.count - xs1.characters.count, xs2) == xs1
}

//FIXME: Performance is bad
//MARK: isInfixOf :: Eq a => [a] -> [a] -> Bool
public func isInfixOf<U: Equatable>(_ xs1: [U], _ xs2: [U]) -> Bool {
    if xs1.count > xs2.count {
        return false
    }
    
    for i in 0...xs2.count - xs1.count {
        let xs = drop(i, xs2)
        if isPrefixOf(xs1, xs) {
            return true
        }
    }
    
    return false
}

public func isInfixOf(_ xs1: String, _ xs2: String) -> Bool {
    return isJust(xs2.range(of: xs1))
}

//MARK: isSubsequenceOf :: Eq a => [a] -> [a] -> Bool
public func isSubsequenceOf<U: Equatable>(_ xs1: [U], _ xs2: [U]) -> Bool {
    return elem(xs1, subsequences(xs2))
}

public func isSubsequenceOf(_ xs1: String, _ xs2: String) -> Bool {
    return elem(xs1, subsequences(xs2))
}

//MARK: - Searching lists
//MARK: Searching by equality
//MARK: elem :: (Foldable t, Eq a) => a -> t a -> Bool
public func elem<A: Equatable>(_ value: A, _ xs: [A])->Bool {
    for x in xs {
        if x == value {
            return true
        }
    }
    
    return false
}

public func elem<A: Equatable>(_ value: [A], _ xs: [[A]])->Bool {
    for x in xs {
        if x == value {
            return true
        }
    }
    
    return false
}

public func elem(_ c: Character , _ xs: String)->Bool {
    for x in xs.characters {
        if x == c {
            return true
        }
    }
    
    return false
}

//MARK: notElem :: (Foldable t, Eq a) => a -> t a -> Bool 
public func notElem<A: Equatable>(_ x: A, _ xs: [A])->Bool {
    return not(elem(x, xs))
}

public func notElem(_ x: Character, _ xs: String)->Bool {
    return not(elem(x, xs))
}

//MARK: lookup :: Eq a => a -> [(a, b)] -> Maybe b
public func lookup<A: Equatable, B: Equatable>(_ key: A, _ dictionary: [A:B]) -> B? {
    return dictionary[key]
}

//MARK: Searching with a predicate
//MARK: find :: Foldable t => (a -> Bool) -> t a -> Maybe a
public func find<U>(_ check: (U) -> Bool, _ xs: [U]) -> U? {
    for x in xs {
        if check(x) {
            return x
        }
    }
    
    return nil
}

public func find(_ check: (Character) -> Bool, _ xs: String) -> Character? {
    for x in xs.characters {
        if check(x) {
            return x
        }
    }
    
    return nil
}

//MARK: filter :: (a -> Bool) -> [a] -> [a]
public func filter<U>(_ check: (U) -> Bool, _ xs: [U]) -> [U] {
    var results = [U]()
    for x in xs {
        if check(x) {
            results.append(x)
        }
    }
    
    return results
}

public func filter<U>(_ check: (U) -> Bool) -> (([U]) -> [U]) {
    return curry(filter, check)
}

public func filter(_ check: (Character) -> Bool, _ xs: String) -> String {
    var results = String()
    for x in xs.characters {
        if check(x) {
            results.append(x)
        }
    }
    
    return results
}

//MARK: partition :: (a -> Bool) -> [a] -> ([a], [a])
public func partition<U>(_ check: (U) -> Bool, _ xs: [U]) -> ([U], [U]) {
    let result = (filter(check, xs), filter( { x in not(check(x)) }, xs))
    return result
}

public func partition<U>(_ check: (U) -> Bool) -> (xs: [U]) -> ([U], [U]) {
    return { xs in partition(check, xs) }
}

public func partition(_ check: (Character) -> Bool, _ xs: String) -> (String, String) {
    let result = (filter(check, xs), filter( { x in not(check(x)) }, xs))
    return result
}

public func partition(_ check: (Character) -> Bool)  -> (xs: String) -> (String, String) {
    return { xs in partition(check, xs) }
}

//MARK: Indexing lists
//MARK: (!!) :: [a] -> Int -> a 
infix operator !! { associativity right precedence 100 }
public func !!(xs: String, i: Int) -> Character {
    let index = xs.index(xs.startIndex, offsetBy: i)
    return xs[index]
}

public func !!<U>(xs: [U], i: Int) -> U {
    return xs[i]
}

//MARK: elemIndex :: Eq a => a -> [a] -> Maybe Int
public func elemIndex<U: Equatable>(_ value: U, _ xs: [U]) -> Int? {
    for i in 0..<xs.count {
        if value == xs[i] {
            return i
        }
    }
    
    return nil
}

public func elemIndex(_ value: Character, _ xs: String) -> Int? {
    for i in 0..<xs.characters.count {
        let c =  xs[xs.characters.index(xs.startIndex, offsetBy: i)]
        if value == c {
            return i
        }
    }
    
    return nil
}

//MARK: elemIndices :: Eq a => a -> [a] -> [Int]
public func elemIndices<U: Equatable>(_ value: U, _ xs: [U]) -> [Int] {
    var result = [Int]()
    for i in 0..<xs.count {
        if value == xs[i] {
            result.append(i)
        }
    }
    
    return result
}

public func elemIndices(_ value: Character, _ xs: String) -> [Int] {
    var result = [Int]()
    for i in 0..<xs.characters.count {
        let c =  xs[xs.characters.index(xs.startIndex, offsetBy: i)]
        if value == c {
            result.append(i)
        }
    }
    
    return result
}

//MARK: findIndex :: (a -> Bool) -> [a] -> Maybe Int
public func findIndex<U>(_ check: (U) -> Bool, _ xs: [U]) -> Int? {
    for i in 0..<xs.count {
        if check(xs[i]) {
            return i
        }
    }
    
    return nil
}

public func findIndex(_ check: (Character) -> Bool, _ xs: String) -> Int? {
    for i in 0..<xs.characters.count {
        let c =  xs[xs.characters.index(xs.startIndex, offsetBy: i)]
        if check(c) {
            return i
        }
    }
    
    return nil
}
//MARK: findIndices :: (a -> Bool) -> [a] -> [Int]
public func findIndices<U: Equatable>(_ check: (U) -> Bool, _ xs: [U]) -> [Int] {
    var result = [Int]()
    for i in 0..<xs.count {
        if check(xs[i]) {
            result.append(i)
        }
    }
    
    return result
}

public func findIndices(_ check: (Character) -> Bool, _ xs: String) -> [Int] {
    var result = [Int]()
    for i in 0..<xs.characters.count {
        let c =  xs[xs.characters.index(xs.startIndex, offsetBy: i)]
        if check(c) {
            result.append(i)
        }
    }
    
    return result
}

//MARK: - Zipping and unzipping lists
//MARK: zip :: [a] -> [b] -> [(a, b)]
public func zip<A, B>(_ xs1: [A], _ xs2: [B]) -> [(A, B)] {
    let len = xs1.count > xs2.count ? xs1.count : xs2.count
    var result = [(A, B)]()
    for i in 0..<len {
        result.append((xs1[i], xs2[i]))
    }
    
    return result
}

public func zip<A, B>(_ xs1: [A]) -> (([B]) -> [(A, B)]) {
    return curry(zip, xs1)
}

//infix operator == {}
//public func == <A: Equatable> (t1: (A, A), t2: (A, A)) -> Bool{
//    return (t1.0 == t2.0) && (t1.1 == t2.1)
//}

public func compareTuples <A: Equatable, B: Equatable> (_ t1: (A, B), _ t2: (A, B)) -> Bool{
    return (t1.0 == t2.0) && (t1.1 == t2.1)
}

public func compareTupleArray <A: Equatable, B: Equatable> (_ xs1: [(A, B)], _ xs2: [(A, B)]) -> Bool{
    guard xs1.count == xs2.count else {
        return false
    }
    
    for i in 0..<xs1.count {
        let result = compareTuples(xs1[i], xs2[i])
        guard result == true else {
            return false
        }
    }
    
    return true
}

public func compareTuples <A: Equatable, B: Equatable, C: Equatable> (_ t1: (A, B, C), _ t2: (A, B, C)) -> Bool{
    return (t1.0 == t2.0) && (t1.1 == t2.1) && (t1.2 == t2.2)
}

public func compareTupleArray <A: Equatable, B: Equatable, C: Equatable> (_ xs1: [(A, B, C)], _ xs2: [(A, B, C)]) -> Bool{
    guard xs1.count == xs2.count else {
        return false
    }
    
    for i in 0..<xs1.count {
        let result = compareTuples(xs1[i], xs2[i])
        guard result == true else {
            return false
        }
    }
    
    return true
}

//MARK: zip3 :: [a] -> [b] -> [c] -> [(a, b, c)]
public func zip3<A, B, C>(_ xs1: [A], _ xs2: [B], _ xs3: [C]) -> [(A, B, C)] {
    let len     = min(xs1.count, xs2.count, xs3.count)
    var result  = [(A, B, C)]()
    for i in 0..<len {
        result.append((xs1[i], xs2[i], xs3[i]))
    }
    
    return result
}

//MARK: zip4 :: [a] -> [b] -> [c] -> [d] -> [(a, b, c, d)]
public func zip4<A, B, C, D>(_ xs1: [A], _ xs2: [B], _ xs3: [C], _ xs4: [D]) -> [(A, B, C, D)] {
    let len     = min(xs1.count, xs2.count, xs3.count, xs4.count)
    var result  = [(A, B, C, D)]()
    for i in 0..<len {
        result.append((xs1[i], xs2[i], xs3[i], xs4[i]))
    }
    
    return result
}

public func compareTuples <A: Equatable, B: Equatable, C: Equatable, D: Equatable> (_ t1: (A, B, C, D), _ t2: (A, B, C, D)) -> Bool{
    return (t1.0 == t2.0) && (t1.1 == t2.1) && (t1.2 == t2.2) && (t1.3 == t2.3)
}

public func compareTupleArray <A: Equatable, B: Equatable, C: Equatable, D: Equatable> (_ xs1: [(A, B, C, D)], _ xs2: [(A, B, C, D)]) -> Bool{
    guard xs1.count == xs2.count else {
        return false
    }
    
    for i in 0..<xs1.count {
        let result = compareTuples(xs1[i], xs2[i])
        guard result == true else {
            return false
        }
    }
    
    return true
}

//MARK: zip5 :: [a] -> [b] -> [c] -> [d] -> [e] -> [(a, b, c, d, e)]
public func zip5<A, B, C, D, E>(_ xs1: [A], _ xs2: [B], _ xs3: [C], _ xs4: [D], _ xs5: [E]) -> [(A, B, C, D, E)] {
    let len     = min(xs1.count, xs2.count, xs3.count, xs4.count, xs5.count)
    var result  = [(A, B, C, D, E)]()
    for i in 0..<len {
        result.append((xs1[i], xs2[i], xs3[i], xs4[i], xs5[i]))
    }
    
    return result
}

public func compareTuples <A: Equatable, B: Equatable, C: Equatable, D: Equatable, E: Equatable> (_ t1: (A, B, C, D, E), _ t2: (A, B, C, D, E)) -> Bool{
    return (t1.0 == t2.0) && (t1.1 == t2.1) && (t1.2 == t2.2) && (t1.3 == t2.3) && (t1.4 == t2.4)
}

public func compareTupleArray <A: Equatable, B: Equatable, C: Equatable, D: Equatable, E: Equatable> (_ xs1: [(A, B, C, D, E)], _ xs2: [(A, B, C, D, E)]) -> Bool{
    guard xs1.count == xs2.count else {
        return false
    }
    
    for i in 0..<xs1.count {
        let result = compareTuples(xs1[i], xs2[i])
        guard result == true else {
            return false
        }
    }
    
    return true
}

//MARK: zip6 :: [a] -> [b] -> [c] -> [d] -> [e] -> [f] -> [(a, b, c, d, e, f)]
public func zip6<A, B, C, D, E, F>(_ xs1: [A], _ xs2: [B], _ xs3: [C], _ xs4: [D], _ xs5: [E], _ xs6: [F]) -> [(A, B, C, D, E, F)] {
    let len     = min(xs1.count, xs2.count, xs3.count, xs4.count, xs5.count, xs6.count)
    var result  = [(A, B, C, D, E, F)]()
    for i in 0..<len {
        result.append((xs1[i], xs2[i], xs3[i], xs4[i], xs5[i], xs6[i]))
    }
    
    return result
}

public func compareTuples <A: Equatable, B: Equatable, C: Equatable, D: Equatable, E: Equatable, F: Equatable> (_ t1: (A, B, C, D, E, F), _ t2: (A, B, C, D, E, F)) -> Bool{
    return (t1.0 == t2.0) && (t1.1 == t2.1) && (t1.2 == t2.2) && (t1.3 == t2.3) && (t1.4 == t2.4) && (t1.5 == t2.5)
}

public func compareTupleArray <A: Equatable, B: Equatable, C: Equatable, D: Equatable, E: Equatable, F: Equatable> (_ xs1: [(A, B, C, D, E, F)], _ xs2: [(A, B, C, D, E, F)]) -> Bool{
    guard xs1.count == xs2.count else {
        return false
    }
    
    for i in 0..<xs1.count {
        let result = compareTuples(xs1[i], xs2[i])
        guard result == true else {
            return false
        }
    }
    
    return true
}
//MARK: zip7 :: [a] -> [b] -> [c] -> [d] -> [e] -> [f] -> [g] -> [(a, b, c, d, e, f, g)]
public func zip7<A, B, C, D, E, F, G>(_ xs1: [A], _ xs2: [B], _ xs3: [C], _ xs4: [D], _ xs5: [E], _ xs6: [F], _ xs7: [G]) -> [(A, B, C, D, E, F, G)] {
    let len     = min(xs1.count, xs2.count, xs3.count, xs4.count, xs5.count, xs6.count, xs7.count)
    var result  = [(A, B, C, D, E, F, G)]()
    for i in 0..<len {
        result.append((xs1[i], xs2[i], xs3[i], xs4[i], xs5[i], xs6[i], xs7[i]))
    }
    
    return result
}

public func compareTuples <A: Equatable, B: Equatable, C: Equatable, D: Equatable, E: Equatable, F: Equatable, G: Equatable > (_ t1: (A, B, C, D, E, F, G), _ t2: (A, B, C, D, E, F, G)) -> Bool{
    return (t1.0 == t2.0) && (t1.1 == t2.1) && (t1.2 == t2.2) && (t1.3 == t2.3) && (t1.4 == t2.4) && (t1.5 == t2.5) && (t1.6 == t2.6)
}

public func compareTupleArray <A: Equatable, B: Equatable, C: Equatable, D: Equatable, E: Equatable, F: Equatable, G: Equatable> (_ xs1: [(A, B, C, D, E, F, G)], _ xs2: [(A, B, C, D, E, F, G)]) -> Bool{
    guard xs1.count == xs2.count else {
        return false
    }
    
    for i in 0..<xs1.count {
        let result = compareTuples(xs1[i], xs2[i])
        guard result == true else {
            return false
        }
    }
    
    return true
}

//MARK: zipWith :: (a -> b -> c) -> [a] -> [b] -> [c]
public func zipWith<A, B, U>(_ process: (A, B)->U, _ xs1: [A], _ xs2: [B]) -> [U] {
    var results = [U]()
    let len = min(xs1.count, xs2.count)
    for i in 0..<len {
        let c = process(xs1[i], xs2[i])
        results.append(c)
    }
    
    return results
}

//MARK: zipWith3 :: (a -> b -> c -> d) -> [a] -> [b] -> [c] -> [d]
public func zipWith3<A, B, C, U>(_ process: (A, B, C)->U, _ xs1: [A], _ xs2: [B], _ xs3: [C]) -> [U] {
    var results = [U]()
    let len = min(xs1.count, xs2.count, xs3.count)
    for i in 0..<len {
        let c = process(xs1[i], xs2[i], xs3[i])
        results.append(c)
    }
    
    return results
}

//MARK: zipWith4 :: (a -> b -> c -> d -> e) -> [a] -> [b] -> [c] -> [d] -> [e]
public func zipWith4<A, B, C, D, U>(_ process: (A, B, C, D)->U, _ xs1: [A], _ xs2: [B], _ xs3: [C], _ xs4: [D]) -> [U] {
    var results = [U]()
    let len = min(xs1.count, xs2.count, xs3.count, xs4.count)
    for i in 0..<len {
        let u = process(xs1[i], xs2[i], xs3[i], xs4[i])
        results.append(u)
    }
    
    return results
}

//MARK: zipWith5 :: (a -> b -> c -> d -> e -> f) -> [a] -> [b] -> [c] -> [d] -> [e] -> [f]
public func zipWith5<A, B, C, D, E, U>(_ process: (A, B, C, D, E)->U, _ xs1: [A], _ xs2: [B], _ xs3: [C], _ xs4: [D], _ xs5: [E]) -> [U] {
    var results = [U]()
    let len = min(xs1.count, xs2.count, xs3.count, xs4.count, xs5.count)
    for i in 0..<len {
        let u = process(xs1[i], xs2[i], xs3[i], xs4[i], xs5[i])
        results.append(u)
    }
    
    return results
}

//MARK: zipWith6 :: (a -> b -> c -> d -> e -> f -> g) -> [a] -> [b] -> [c] -> [d] -> [e] -> [f] -> [g]
public func zipWith6<A, B, C, D, E, F, U>(_ process: (A, B, C, D, E, F)->U, _ xs1: [A], _ xs2: [B], _ xs3: [C], _ xs4: [D], _ xs5: [E], _ xs6: [F]) -> [U] {
    var results = [U]()
    let len = min(xs1.count, xs2.count, xs3.count, xs4.count, xs5.count, xs6.count)
    for i in 0..<len {
        let u = process(xs1[i], xs2[i], xs3[i], xs4[i], xs5[i], xs6[i])
        results.append(u)
    }
    
    return results
}

//MARK: zipWith7 :: (a -> b -> c -> d -> e -> f -> g -> h) -> [a] -> [b] -> [c] -> [d] -> [e] -> [f] -> [g] -> [h]
public func zipWith7<A, B, C, D, E, F, G, U>(_ process: (A, B, C, D, E, F, G)->U, _ xs1: [A], _ xs2: [B], _ xs3: [C], _ xs4: [D], _ xs5: [E], _ xs6: [F], _ xs7: [G]) -> [U] {
    var results = [U]()
    let len = min(xs1.count, xs2.count, xs3.count, xs4.count, xs5.count, xs6.count, xs7.count)
    for i in 0..<len {
        let u = process(xs1[i], xs2[i], xs3[i], xs4[i], xs5[i], xs6[i], xs7[i])
        results.append(u)
    }
    
    return results
}
//MARK: unzip :: [(a, b)] -> ([a], [b])
public func unzip<A, B>(_ xs: [(A, B)]) -> ([A],[B])  {
    var r0 = [A]()
    var r1 = [B]()
    for x in xs {
        r0.append(x.0)
        r1.append(x.1)
    }
    
    return (r0, r1)
}

//MARK: unzip3 :: [(a, b, c)] -> ([a], [b], [c])
public func unzip3<A, B, C>(_ xs: [(A, B, C)]) -> ([A],[B],[C])  {
    var r0 = [A]()
    var r1 = [B]()
    var r2 = [C]()
    
    for x in xs {
        r0.append(x.0)
        r1.append(x.1)
        r2.append(x.2)
    }
    
    return (r0, r1, r2)
}

//MARK: unzip4 :: [(a, b, c, d)] -> ([a], [b], [c], [d])
public func unzip4<A, B, C, D>(_ xs: [(A, B, C, D)]) -> ([A],[B],[C],[D])  {
    var r0 = [A]()
    var r1 = [B]()
    var r2 = [C]()
    var r3 = [D]()
    
    for x in xs {
        r0.append(x.0)
        r1.append(x.1)
        r2.append(x.2)
        r3.append(x.3)
    }
    
    return (r0, r1, r2, r3)
}

//MARK: unzip5 :: [(a, b, c, d, e)] -> ([a], [b], [c], [d], [e])
public func unzip5<A, B, C, D, E>(_ xs: [(A, B, C, D, E)]) -> ([A],[B],[C],[D],[E])  {
    var r0 = [A]()
    var r1 = [B]()
    var r2 = [C]()
    var r3 = [D]()
    var r4 = [E]()
    
    for x in xs {
        r0.append(x.0)
        r1.append(x.1)
        r2.append(x.2)
        r3.append(x.3)
        r4.append(x.4)
    }
    
    return (r0, r1, r2, r3, r4)
}

//MARK: unzip6 :: [(a, b, c, d, e, f)] -> ([a], [b], [c], [d], [e], [f])
public func unzip6<A, B, C, D, E, F>(_ xs: [(A, B, C, D, E, F)]) -> ([A],[B],[C],[D],[E],[F])  {
    var r0 = [A]()
    var r1 = [B]()
    var r2 = [C]()
    var r3 = [D]()
    var r4 = [E]()
    var r5 = [F]()
    
    for x in xs {
        r0.append(x.0)
        r1.append(x.1)
        r2.append(x.2)
        r3.append(x.3)
        r4.append(x.4)
        r5.append(x.5)
    }
    
    return (r0, r1, r2, r3, r4, r5)
}

//MARK: unzip7 :: [(a, b, c, d, e, f, g)] -> ([a], [b], [c], [d], [e], [f], [g])
public func unzip7<A, B, C, D, E, F, G>(_ xs: [(A, B, C, D, E, F, G)]) -> ([A],[B],[C],[D],[E],[F],[G])  {
    var r0 = [A]()
    var r1 = [B]()
    var r2 = [C]()
    var r3 = [D]()
    var r4 = [E]()
    var r5 = [F]()
    var r6 = [G]()
    
    for x in xs {
        r0.append(x.0)
        r1.append(x.1)
        r2.append(x.2)
        r3.append(x.3)
        r4.append(x.4)
        r5.append(x.5)
        r6.append(x.6)
    }
    
    return (r0, r1, r2, r3, r4, r5, r6)
}

//MARK: - Special lists
//MARK: Functions on strings
//MARK: lines :: String -> [String]
public func lines(_ s: String)->[String] {
    return s.components(separatedBy: CharacterSet.newlines)
}

//public func lines(s: String)->[String] {
//    let linefeed : Character = "\n"
//    return splitWith({ (x : Character) in x == linefeed }, s)
//}

public func splitWith(_ check: (Character)->Bool, _ s: String)->[String] {
    var xs      = [String]()
    var i       = 0
    var list    = s
    for c in s.characters {
        if check(c) {
            xs.append(take(i, list))
            list = drop(i + 1, list)
            i   = 0
        } else {
            i   = i + 1
        }
    }
    if i != 0 {
        xs.append(list)
    }
    
    return xs
}

public func splitWith(_ check: (Character)->Bool) -> (String) -> [String] {
    return { (s: String) -> [String] in
        return splitWith(check, s)
    }
}

//MARK: words :: String -> [String]
public func words(_ s: String)->[String] {
    let isWhiteSpace    = { (c: Character) in c == " " || c == "\n" || c == "\t" }
    let xs              = splitWith(isWhiteSpace, s)
    let result          = filter({ x in x.characters.count > 0} , xs)
    return result
}

//MARK: unlines :: [String] -> String
public func unlines(_ xs: [String])->String {
    let result          = join("\n", xs)
    return result
}

public func join(_ delimiter: String, _ xs: [String]) -> String {
    var result = ""
    for i in 0..<xs.count {
        let t = i == xs.count - 1 ? xs[i] : xs[i] + delimiter
        result = result + t
    }
    return result
}

//MARK: unwords :: [String] -> String
public func unwords(_ xs: [String])->String {
    let result          = join(" ", xs)
    return result
}

//MARK: "Set" operations
//MARK: nub :: Eq a => [a] -> [a]
public func nub<A: Equatable>(_ xs: [A]) -> [A] {
    return nubBy( {x, y in x == y}, xs)
}

public func nub<A: Equatable>(_ xs: [A?]) -> [A?] {
    return nubBy( {x, y in x == y}, xs)
}

public func nub(_ xs: String) -> String {
    return nubBy({(x: Character, y: Character) in x == y}, xs)
}

//MARK: delete :: Eq a => a -> [a] -> [a]
public func delete<A: Equatable>(_ value: A, _ xs: [A]) -> [A] {
    let idx     = elemIndex(value, xs)
    return idx == nil ? xs : take(idx!, xs) + drop(idx! + 1, xs)
}

public func delete(_ value: Character, _ xs: String) -> String {
    let idx     = elemIndex(value, xs)
    return idx == nil ? xs : take(idx!, xs) + drop(idx! + 1, xs)
}

public func delete(_ value: String, _ xs: String) -> String {
    assert(value.characters.count == 1)
    let c       = value[value.characters.startIndex]
    let idx     = elemIndex(c, xs)
    return idx == nil ? xs : take(idx!, xs) + drop(idx! + 1, xs)
}

//MARK: (\\) :: Eq a => [a] -> [a] -> [a] infix 5
//MARK: union :: Eq a => [a] -> [a] -> [a]
public func union<A: Equatable>(_ xs1: [A], _ xs2: [A]) -> [A] {
    return nub(xs1 + xs2)
}

//MARK: intersect :: Eq a => [a] -> [a] -> [a]
public func intersect<A: Equatable>(_ xs1: [A], _ xs2: [A]) -> [A] {
    let isElement   = { (x : A) -> Bool in elemIndex(x, xs2) != nil }
    return filter(isElement, xs1)
}

public func intersect(_ xs1: String, _ xs2: String) -> String {
    let isElement   = { (x ) -> Bool in elemIndex(x, xs2) != nil }
    return filter(isElement, xs1)
}

//MARK: sort :: Ord a => [a] -> [a]
public func sort<A: Comparable>(_ xs: [A]) -> [A] {
    return sortOn({x, y in x < y}, xs)
}
//MARK: sortOn :: Ord b => (a -> b) -> [a] -> [a]
public func sortOn<A: Comparable>(_ f: (A,A)->Bool, _ xs: [A]) -> [A] {
    return xs.sorted(isOrderedBefore: f)
}

//MARK: insert :: Ord a => a -> [a] -> [a]
public func insert<A: Equatable>(_ value: A, _ xs: [A]) -> [A] {
    return xs + [value]
}

public func insert(_ value: String, _ xs: String) -> String {
    return xs + value
}

public func insert(_ value: Character, _ xs: String) -> String {
    return xs + String(value)
}

//MARK: - Generalized functions
//MARK: The "By" operations
//MARK: nubBy :: (a -> a -> Bool) -> [a] -> [a]
public func nubBy<A: Equatable>(_ f: (A,A)->Bool, _ xs: [A]) -> [A] {
    var results  = [A]()
    for x in xs {
        if find( { y in f(x, y) }, results) == nil {
            results.append(x)
        }
    }
    
    return results
}

public func nubBy<A: Equatable>(_ f: (A,A)->Bool) -> ([A]) -> [A] {
    return { (xs: [A]) -> [A] in return nubBy(f, xs) }
}

public func nubBy<A: Equatable>(_ f: (A?,A?)->Bool, _ xs: [A?]) -> [A?] {
    var results  = [A?]()
    for x in xs {
        if find( { y in f(x, y) }, results) == nil {
            results.append(x)
        }
    }
    
    return results
}

public func nubBy(_ f: (Character, Character)->Bool, _ xs: String) -> String {
    var results  = String()
    for x in xs.characters {
        if find( { y in f(x, y) }, results) == nil {
            results.append(x)
        }
    }
    
    return results
}

public func nubBy(_ f: (Character, Character)->Bool) -> (String) -> String {
    return { (xs: String) -> String in
        return nubBy(f, xs)
    }
}

//MARK: deleteBy :: (a -> a -> Bool) -> a -> [a] -> [a]
public func deleteBy<A: Equatable>(_ f: (A,A)->Bool, _ y: A, _ xs: [A]) -> [A] {
    let idx     = indexElemBy(f, y, xs)
    return idx == nil ? xs : take(idx!, xs) + drop(idx!+1, xs)
}

func indexElemBy<A: Equatable>(_ f: (A,A)->Bool, _ y: A, _ xs: [A]) -> Int? {
    for i in 0..<xs.count {
        if f(y, xs[i]) {
            return i
        }
    }
    return nil
}

public func deleteBy(_ f: (Character,Character)->Bool, _ y: Character, _ xs: String) -> String {
    let idx     = indexElemBy(f, y, xs)
    return idx == nil ? xs : take(idx!, xs) + drop(idx!+1, xs)
}

func indexElemBy(_ f: (Character, Character)->Bool, _ y: Character, _ xs: String) -> Int? {
    for i in 0..<xs.characters.count {
        let c = xs[xs.characters.index(xs.startIndex, offsetBy: i)]
        if f(y, c) {
            return i
        }
    }
    return nil
}

//MARK: deleteFirstsBy :: (a -> a -> Bool) -> [a] -> [a] -> [a]
public func deleteFirstsBy<A: Equatable>(_ f: (A,A)->Bool, _ xs1: [A], _ xs2: [A]) -> [A] {
    var result = xs1
    for x in xs2 {
        result = deleteBy(f, x, result)
    }
    
    return result
}

public func deleteFirstsBy(_ f: (Character, Character)->Bool, _ xs1: String, _ xs2: String) -> String {
    var result  = xs1
    for i in 0..<xs2.characters.count {
        let c   = xs2[xs2.characters.index(xs2.startIndex, offsetBy: i)]
        result  = deleteBy(f, c, result)
    }
    return result
}

//MARK: unionBy :: (a -> a -> Bool) -> [a] -> [a] -> [a]
public func unionBy<A: Equatable>(_ f : (A, A)->Bool, _ xs1: [A], _ xs2: [A]) -> [A] {
    return xs1 + deleteFirstsBy(f, nub(xs2), xs1)
}

public func unionBy(_ f: (Character, Character)->Bool, _ xs1: String, _ xs2: String) -> String {
    return xs1 + deleteFirstsBy(f, nub(xs2), xs1)
}

//MARK: intersectBy :: (a -> a -> Bool) -> [a] -> [a] -> [a]
public func intersectBy<A: Equatable>(_ f : (A, A)->Bool, _ xs1: [A], _ xs2: [A]) -> [A] {
    return filter( { x in any({ y in f(x, y)}, xs2)}, xs1)
}

public func intersectBy(_ f: (Character, Character)->Bool, _ xs1: String, _ xs2: String) -> String {
    return filter( { x in any({ y in f(x, y)}, xs2)}, xs1)
}

//MARK: groupBy :: (a -> a -> Bool) -> [a] -> [[a]]
public func groupBy<A: Equatable>(_ f : (A, A)->Bool, _ xs: [A]) -> [[A]] {
    if xs.count <= 1 {
        return [xs]
    }
    
    var result          = [[A]]()
    var list            = xs
    while (list.count > 0) {
        let y           = head(list)
        let ys          = takeWhile( { x in f(y, x)}, drop(1, list))
        list            = drop(ys.count > 0 ? ys.count + 1 : 1, list)
        result.append(ys.count > 0 ? [y] + ys : [y])
        //print("y = \(y), items = \(ys), list = \(list)")
    }
    
    return result
}

public func groupBy(_ f: (Character, Character)->Bool, _ xs: String) -> [String] {
    var result          = [String]()
    var list            = xs
    while (list.characters.count > 0) {
        let y           = head(list)
        let ys          = takeWhile( { x in f(y, x)}, drop(1, list))
        list            = drop(ys.characters.count > 0 ? ys.characters.count + 1 : 1 , list)
        result.append(ys.characters.count > 0 ? String(y) + ys : String(y))
    }
    
    return result
}

//MARK: sortBy :: (a -> a -> Ordering) -> [a] -> [a]
public func sortBy<A: Comparable>(_ f : (A, A)->Bool, _ xs: [A]) -> [A] {
    return xs.sorted(isOrderedBefore: f)
}

public func sortBy<A: Comparable>(_ f : (A, A)->Bool) -> ([A]) -> [A] {
    return curry(sortBy, f)
}

//MARK: insertBy :: (a -> a -> Ordering) -> a -> [a] -> [a]
public func insertBy<A: Equatable>(_ f : (A, A)->Bool, _ value: A, _ xs: [A]) -> [A] {
    let idx = indexElemBy(f, value, xs)
    if idx == nil {
        return xs + [value]
    }
    let l = take(idx!, xs)
    let r = drop(idx!, xs)
    return  l + [value] + r
}

public func insertBy(_ f : (Character, Character)->Bool, _ value: Character, _ xs: String) -> String {
    let idx = indexElemBy(f, value, xs)
    if idx == nil {
        return xs + String(value)
    }
    return take(idx!, xs) + String(value) + drop(idx!, xs)
}

//MARK: maximumBy :: Foldable t => (a -> a -> Ordering) -> t a -> a
public func maximumBy<A: Comparable>(_ f : (A, A)->Ordering, _ xs: [A]) -> A {
    assert(xs.count > 0, "Empty List")
    var result = xs[0]
    _ = foldl({(a: A, b: A) -> A in
        result = f(a, b) == .gt ? a : b
        return result
        }, result, xs)
    return result
}

//MARK: minimumBy :: Foldable t => (a -> a -> Ordering) -> t a -> a
public func minimumBy<A: Comparable>(_ f : (A, A)->Ordering, _ xs: [A]) -> A {
    assert(xs.count > 0, "Empty List")
    var result = xs[0]
    _ = foldl({(a: A, b: A) -> A in
        result = f(a, b) == .lt ? a : b
        return result
        }, result, xs)
    return result
}

//MARK: - The "generic" operations
//MARK: genericLength :: Num i => [a] -> i
public func genericLength<A>(_ xs: [A])->Int {
    return xs.count
}

public func genericLength(_ xs: String)->Int {
    return xs.characters.count
}

//MARK: genericTake :: Integral i => i -> [a] -> [a]
public func genericTake<T>(_ len: Int, _ xs: [T]) -> [T] {
    return take(len, xs)
}

//MARK: genericDrop :: Integral i => i -> [a] -> [a]
public func genericDrop<T>(_ len: Int, _ xs: [T]) -> [T] {
    return drop(len, xs)
}

//MARK: genericSplitAt :: Integral i => i -> [a] -> ([a], [a])
public func genericSplitAt(_ len: Int, _ xs: String)->(String, String) {
    return splitAt(len, xs)
}

//MARK: genericIndex :: Integral i => [a] -> i -> a


//MARK: genericReplicate :: Integral i => i -> a -> [a]
public func genericReplicate<A>(_ len: Int, _ value: A) -> [A] {
    return replicate(len, value)
}
