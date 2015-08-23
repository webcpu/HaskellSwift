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

public func not(value: Bool) -> Bool {
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
public func initx<T>(xs: [T])->[T] {
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

public func initx(xs: String)->String {
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
    let len = lengthOfWhile(check, xs)
    return take(len, xs)
}

func lengthOfWhile<U>(check: U -> Bool, _ xs: [U]) -> Int {
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

public func takeWhile(check: Character -> Bool, _ xs: String) -> String {
    let len = lengthOfWhileForString(check, xs)
    return take(len, xs)
}

func lengthOfWhileForString(check: Character -> Bool, _ xs: String) -> Int {
    var len = 0
    for i in 0..<xs.characters.count {
        let c = xs[advance(xs.startIndex, i)]
        guard check(c) else {
            break
        }
        len = i + 1
    }
    return len
}

//MARK: dropWhile :: (a -> Bool) -> [a] -> [a]
public func dropWhile<U>(check: U -> Bool, _ xs: [U]) -> [U] {
    var len = 0
    for i in 0..<xs.count {
        guard check(xs[i]) else {
            len = i
            break
        }
    }
    return drop(len, xs)
}

public func dropWhile(check: Character -> Bool, _ xs: String) -> String {
    let len = lengthOfWhileForString(check, xs)
    return drop(len, xs)
}

//MARK: span :: (a -> Bool) -> [a] -> ([a], [a])
public func span<U>(check: U -> Bool, _ xs: [U]) -> ([U], [U]) {
    let len = lengthOfWhile(check, xs)
    return (take(len, xs), drop(len, xs))
}

public func span(check: Character -> Bool, _ xs: String) -> (String, String) {
    let len = lengthOfWhileForString(check, xs)
    return (take(len, xs), drop(len, xs))
}

//MARK: break :: (a -> Bool) -> [a] -> ([a], [a])
public func breakx<U>(check: U -> Bool, _ xs: [U]) -> ([U], [U]) {
    let len = lengthOfWhile({(x: U) in !check(x) }, xs)
    return (take(len, xs), drop(len, xs))
}

public func breakx(check: Character -> Bool, _ xs: String) -> (String, String) {
    let len = lengthOfWhileForString({(x: Character) in !check(x)}, xs)
    return (take(len, xs), drop(len, xs))
}

//MARK: group :: Eq a => [a] -> [[a]]
public func group<U: Equatable>(xs: [U]) -> [[U]] {
    var result          = [[U]]()
    var list            = xs
    var groupedItems    = [U]()
    while (list.count > 0) {
        let item        = head(list)
        groupedItems    = takeWhile( {x in x == item}, list)
        list            = drop(groupedItems.count, list)
        if groupedItems.count > 0 {
            result.append(groupedItems)
        }
    }
    
    return result
}

public func group(xs: String) -> [String] {
    var result          = [String]()
    var list            = xs
    var groupedItems    = String()
    while (list.characters.count > 0) {
        let item        = head(list)
        groupedItems    = takeWhile( { x in x == item}, list)
        list            = drop(groupedItems.characters.count, list)
        if groupedItems.characters.count > 0 {
            result.append(groupedItems)
        }
    }
    
    return result
}
//MARK: inits :: [a] -> [[a]]
public func inits<U>(xs: [U]) -> [[U]] {
    var result = [[U]]()
    for i in 0...xs.count {
        result.append(take(i, xs))
    }
    
    return result
}

public func inits(xs: String) -> [String] {
    var result = [String]()
    for i in 0...xs.characters.count {
        result.append(take(i, xs))
    }
    
    return result
}

//MARK: tails :: [a] -> [[a]]
public func tails<U>(xs: [U]) -> [[U]] {
    var result = [[U]]()
    for i in 0...xs.count {
        result.append(drop(i, xs))
    }
    
    return result
}

public func tails(xs: String) -> [String] {
    var result = [String]()
    for i in 0...xs.characters.count {
        result.append(drop(i, xs))
    }
    
    return result
}

//MARK: - Predicates
//MARK: isPrefixOf :: Eq a => [a] -> [a] -> Bool
public func isPrefixOf<U: Equatable>(xs1: [U], _ xs2: [U]) -> Bool {
    return take(xs1.count, xs2) == xs1
}

public func isPrefixOf(xs1: String, _ xs2: String) -> Bool {
    return take(xs1.characters.count, xs2) == xs1
}

//MARK: isSuffixOf :: Eq a => [a] -> [a] -> Bool
public func isSuffixOf<U: Equatable>(xs1: [U], _ xs2: [U]) -> Bool {
    if xs1.count > xs2.count {
        return false
    }
    
    return drop(xs2.count - xs1.count, xs2) == xs1
}

public func isSuffixOf(xs1: String, _ xs2: String) -> Bool {
    if xs1.characters.count > xs2.characters.count {
        return false
    }
    
    return drop(xs2.characters.count - xs1.characters.count, xs2) == xs1
}

//MARK: isInfixOf :: Eq a => [a] -> [a] -> Bool
public func isInfixOf<U: Equatable>(xs1: [U], _ xs2: [U]) -> Bool {
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

public func isInfixOf(xs1: String, _ xs2: String) -> Bool {
    if xs1.characters.count > xs2.characters.count {
        return false
    }
    
    for i in 0...xs2.characters.count - xs1.characters.count {
        let xs = drop(i, xs2)
        if isPrefixOf(xs1, xs) {
            return true
        }
    }
    
    return false
}

//MARK: isSubsequenceOf :: Eq a => [a] -> [a] -> Bool
public func isSubsequenceOf<U: Equatable>(xs1: [U], _ xs2: [U]) -> Bool {
    return isInfixOf(xs1, xs2) && xs1.count < xs2.count
}

public func isSubsequenceOf(xs1: String, _ xs2: String) -> Bool {
    return isInfixOf(xs1, xs2) && xs1.characters.count < xs2.characters.count
}

//MARK: - Searching lists
//MARK: Searching by equality
//MARK: elem :: (Foldable t, Eq a) => a -> t a -> Bool
public func elem<A: Equatable>(xs: [A], _ value: A )->Bool {
    for x in xs {
        if x == value {
            return true
        }
    }
    
    return false
}

public func elem(xs: String, _ value: Character )->Bool {
    for x in xs.characters {
        if x == value {
            return true
        }
    }
    
    return false
}

//MARK: notElem :: (Foldable t, Eq a) => a -> t a -> Bool 
public func notElem<A: Equatable>(xs: [A], _ value: A )->Bool {
    return not(elem(xs, value))
}

public func notElem(xs: String, _ value: Character )->Bool {
    return not(elem(xs, value))
}

//MARK: lookup :: Eq a => a -> [(a, b)] -> Maybe b
public func lookup<A: Equatable, B: Equatable>(key: A, _ dictionary: [A:B]) -> B? {
    return dictionary[key]
}

//MARK: Searching with a predicate
//MARK: find :: Foldable t => (a -> Bool) -> t a -> Maybe a
public func find<U>(check: U -> Bool, _ xs: [U]) -> U? {
    for x in xs {
        if check(x) {
            return x
        }
    }
    
    return nil
}

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

//MARK: partition :: (a -> Bool) -> [a] -> ([a], [a])
public func partition<U>(check: U -> Bool, _ xs: [U]) -> ([U], [U]) {
    let result = (filter(check, xs), filter( { x in not(check(x)) }, xs))
    return result
}

public func partition(check: Character -> Bool, _ xs: String) -> (String, String) {
    let result = (filter(check, xs), filter( { x in not(check(x)) }, xs))
    return result
}

//MARK: Indexing lists
//MARK: (!!) :: [a] -> Int -> a 

//MARK: elemIndex :: Eq a => a -> [a] -> Maybe Int
public func elemIndex<U: Equatable>(value: U, _ xs: [U]) -> Int? {
    for i in 0..<xs.count {
        if value == xs[i] {
            return i
        }
    }
    
    return nil
}

public func elemIndex(value: Character, _ xs: String) -> Int? {
    for i in 0..<xs.characters.count {
        let c =  xs[advance(xs.startIndex, i)]
        if value == c {
            return i
        }
    }
    
    return nil
}

//MARK: elemIndices :: Eq a => a -> [a] -> [Int]
public func elemIndices<U: Equatable>(value: U, _ xs: [U]) -> [Int] {
    var result = [Int]()
    for i in 0..<xs.count {
        if value == xs[i] {
            result.append(i)
        }
    }
    
    return result
}

public func elemIndices(value: Character, _ xs: String) -> [Int] {
    var result = [Int]()
    for i in 0..<xs.characters.count {
        let c =  xs[advance(xs.startIndex, i)]
        if value == c {
            result.append(i)
        }
    }
    
    return result
}

//MARK: findIndex :: (a -> Bool) -> [a] -> Maybe Int
public func findIndex<U>(check: U -> Bool, _ xs: [U]) -> Int? {
    for i in 0..<xs.count {
        if check(xs[i]) {
            return i
        }
    }
    
    return nil
}

public func findIndex(check: Character -> Bool, _ xs: String) -> Int? {
    for i in 0..<xs.characters.count {
        let c =  xs[advance(xs.startIndex, i)]
        if check(c) {
            return i
        }
    }
    
    return nil
}
//MARK: findIndices :: (a -> Bool) -> [a] -> [Int]
public func findIndices<U: Equatable>(check: U -> Bool, _ xs: [U]) -> [Int] {
    var result = [Int]()
    for i in 0..<xs.count {
        if check(xs[i]) {
            result.append(i)
        }
    }
    
    return result
}

public func findIndices(check: Character -> Bool, _ xs: String) -> [Int] {
    var result = [Int]()
    for i in 0..<xs.characters.count {
        let c =  xs[advance(xs.startIndex, i)]
        if check(c) {
            result.append(i)
        }
    }
    
    return result
}

//MARK: - Zipping and unzipping lists
//MARK: zip :: [a] -> [b] -> [(a, b)]
public func zip<A, B>(xs1: [A], _ xs2: [B]) -> [(A, B)] {
    let len = xs1.count > xs2.count ? xs1.count : xs2.count
    var result = [(A, B)]()
    for i in 0..<len {
        result.append((xs1[i], xs2[i]))
    }
    
    return result
}

//infix operator == {}
//public func == <A: Equatable> (t1: (A, A), t2: (A, A)) -> Bool{
//    return (t1.0 == t2.0) && (t1.1 == t2.1)
//}

public func compareTuples <A: Equatable, B: Equatable> (t1: (A, B), _ t2: (A, B)) -> Bool{
    return (t1.0 == t2.0) && (t1.1 == t2.1)
}

public func compareTupleArray <A: Equatable, B: Equatable> (xs1: [(A, B)], _ xs2: [(A, B)]) -> Bool{
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

public func compareTuples <A: Equatable, B: Equatable, C: Equatable> (t1: (A, B, C), _ t2: (A, B, C)) -> Bool{
    return (t1.0 == t2.0) && (t1.1 == t2.1) && (t1.2 == t2.2)
}

public func compareTupleArray <A: Equatable, B: Equatable, C: Equatable> (xs1: [(A, B, C)], _ xs2: [(A, B, C)]) -> Bool{
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
public func zip3<A, B, C>(xs1: [A], _ xs2: [B], _ xs3: [C]) -> [(A, B, C)] {
    let len     = min(xs1.count, xs2.count, xs3.count)
    var result  = [(A, B, C)]()
    for i in 0..<len {
        result.append((xs1[i], xs2[i], xs3[i]))
    }
    
    return result
}

//MARK: zip4 :: [a] -> [b] -> [c] -> [d] -> [(a, b, c, d)]
public func zip4<A, B, C, D>(xs1: [A], _ xs2: [B], _ xs3: [C], _ xs4: [D]) -> [(A, B, C, D)] {
    let len     = min(xs1.count, xs2.count, xs3.count, xs4.count)
    var result  = [(A, B, C, D)]()
    for i in 0..<len {
        result.append((xs1[i], xs2[i], xs3[i], xs4[i]))
    }
    
    return result
}

public func compareTuples <A: Equatable, B: Equatable, C: Equatable, D: Equatable> (t1: (A, B, C, D), _ t2: (A, B, C, D)) -> Bool{
    return (t1.0 == t2.0) && (t1.1 == t2.1) && (t1.2 == t2.2) && (t1.3 == t2.3)
}

public func compareTupleArray <A: Equatable, B: Equatable, C: Equatable, D: Equatable> (xs1: [(A, B, C, D)], _ xs2: [(A, B, C, D)]) -> Bool{
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
public func zip5<A, B, C, D, E>(xs1: [A], _ xs2: [B], _ xs3: [C], _ xs4: [D], _ xs5: [E]) -> [(A, B, C, D, E)] {
    let len     = min(xs1.count, xs2.count, xs3.count, xs4.count, xs5.count)
    var result  = [(A, B, C, D, E)]()
    for i in 0..<len {
        result.append((xs1[i], xs2[i], xs3[i], xs4[i], xs5[i]))
    }
    
    return result
}

public func compareTuples <A: Equatable, B: Equatable, C: Equatable, D: Equatable, E: Equatable> (t1: (A, B, C, D, E), _ t2: (A, B, C, D, E)) -> Bool{
    return (t1.0 == t2.0) && (t1.1 == t2.1) && (t1.2 == t2.2) && (t1.3 == t2.3) && (t1.4 == t2.4)
}

public func compareTupleArray <A: Equatable, B: Equatable, C: Equatable, D: Equatable, E: Equatable> (xs1: [(A, B, C, D, E)], _ xs2: [(A, B, C, D, E)]) -> Bool{
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
public func zip6<A, B, C, D, E, F>(xs1: [A], _ xs2: [B], _ xs3: [C], _ xs4: [D], _ xs5: [E], _ xs6: [F]) -> [(A, B, C, D, E, F)] {
    let len     = min(xs1.count, xs2.count, xs3.count, xs4.count, xs5.count, xs6.count)
    var result  = [(A, B, C, D, E, F)]()
    for i in 0..<len {
        result.append((xs1[i], xs2[i], xs3[i], xs4[i], xs5[i], xs6[i]))
    }
    
    return result
}

public func compareTuples <A: Equatable, B: Equatable, C: Equatable, D: Equatable, E: Equatable, F: Equatable> (t1: (A, B, C, D, E, F), _ t2: (A, B, C, D, E, F)) -> Bool{
    return (t1.0 == t2.0) && (t1.1 == t2.1) && (t1.2 == t2.2) && (t1.3 == t2.3) && (t1.4 == t2.4) && (t1.5 == t2.5)
}

public func compareTupleArray <A: Equatable, B: Equatable, C: Equatable, D: Equatable, E: Equatable, F: Equatable> (xs1: [(A, B, C, D, E, F)], _ xs2: [(A, B, C, D, E, F)]) -> Bool{
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
public func zip7<A, B, C, D, E, F, G>(xs1: [A], _ xs2: [B], _ xs3: [C], _ xs4: [D], _ xs5: [E], _ xs6: [F], _ xs7: [G]) -> [(A, B, C, D, E, F, G)] {
    let len     = min(xs1.count, xs2.count, xs3.count, xs4.count, xs5.count, xs6.count, xs7.count)
    var result  = [(A, B, C, D, E, F, G)]()
    for i in 0..<len {
        result.append((xs1[i], xs2[i], xs3[i], xs4[i], xs5[i], xs6[i], xs7[i]))
    }
    
    return result
}

public func compareTuples <A: Equatable, B: Equatable, C: Equatable, D: Equatable, E: Equatable, F: Equatable, G: Equatable > (t1: (A, B, C, D, E, F, G), _ t2: (A, B, C, D, E, F, G)) -> Bool{
    return (t1.0 == t2.0) && (t1.1 == t2.1) && (t1.2 == t2.2) && (t1.3 == t2.3) && (t1.4 == t2.4) && (t1.5 == t2.5) && (t1.6 == t2.6)
}

public func compareTupleArray <A: Equatable, B: Equatable, C: Equatable, D: Equatable, E: Equatable, F: Equatable, G: Equatable> (xs1: [(A, B, C, D, E, F, G)], _ xs2: [(A, B, C, D, E, F, G)]) -> Bool{
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
public func zipWith<A, B, U>(process: (A, B)->U, _ xs1: [A], _ xs2: [B]) -> [U] {
    var results = [U]()
    let len = min(xs1.count, xs2.count)
    for i in 0..<len {
        let c = process(xs1[i], xs2[i])
        results.append(c)
    }
    
    return results
}

//MARK: zipWith3 :: (a -> b -> c -> d) -> [a] -> [b] -> [c] -> [d]
public func zipWith3<A, B, C, U>(process: (A, B, C)->U, _ xs1: [A], _ xs2: [B], _ xs3: [C]) -> [U] {
    var results = [U]()
    let len = min(xs1.count, xs2.count, xs3.count)
    for i in 0..<len {
        let c = process(xs1[i], xs2[i], xs3[i])
        results.append(c)
    }
    
    return results
}

//MARK: zipWith4 :: (a -> b -> c -> d -> e) -> [a] -> [b] -> [c] -> [d] -> [e]
public func zipWith4<A, B, C, D, U>(process: (A, B, C, D)->U, _ xs1: [A], _ xs2: [B], _ xs3: [C], _ xs4: [D]) -> [U] {
    var results = [U]()
    let len = min(xs1.count, xs2.count, xs3.count, xs4.count)
    for i in 0..<len {
        let u = process(xs1[i], xs2[i], xs3[i], xs4[i])
        results.append(u)
    }
    
    return results
}

//MARK: zipWith5 :: (a -> b -> c -> d -> e -> f) -> [a] -> [b] -> [c] -> [d] -> [e] -> [f]
public func zipWith5<A, B, C, D, E, U>(process: (A, B, C, D, E)->U, _ xs1: [A], _ xs2: [B], _ xs3: [C], _ xs4: [D], _ xs5: [E]) -> [U] {
    var results = [U]()
    let len = min(xs1.count, xs2.count, xs3.count, xs4.count, xs5.count)
    for i in 0..<len {
        let u = process(xs1[i], xs2[i], xs3[i], xs4[i], xs5[i])
        results.append(u)
    }
    
    return results
}

//MARK: zipWith6 :: (a -> b -> c -> d -> e -> f -> g) -> [a] -> [b] -> [c] -> [d] -> [e] -> [f] -> [g]
public func zipWith6<A, B, C, D, E, F, U>(process: (A, B, C, D, E, F)->U, _ xs1: [A], _ xs2: [B], _ xs3: [C], _ xs4: [D], _ xs5: [E], _ xs6: [F]) -> [U] {
    var results = [U]()
    let len = min(xs1.count, xs2.count, xs3.count, xs4.count, xs5.count, xs6.count)
    for i in 0..<len {
        let u = process(xs1[i], xs2[i], xs3[i], xs4[i], xs5[i], xs6[i])
        results.append(u)
    }
    
    return results
}

//MARK: zipWith7 :: (a -> b -> c -> d -> e -> f -> g -> h) -> [a] -> [b] -> [c] -> [d] -> [e] -> [f] -> [g] -> [h]
public func zipWith7<A, B, C, D, E, F, G, U>(process: (A, B, C, D, E, F, G)->U, _ xs1: [A], _ xs2: [B], _ xs3: [C], _ xs4: [D], _ xs5: [E], _ xs6: [F], _ xs7: [G]) -> [U] {
    var results = [U]()
    let len = min(xs1.count, xs2.count, xs3.count, xs4.count, xs5.count, xs6.count, xs7.count)
    for i in 0..<len {
        let u = process(xs1[i], xs2[i], xs3[i], xs4[i], xs5[i], xs6[i], xs7[i])
        results.append(u)
    }
    
    return results
}
//MARK: unzip :: [(a, b)] -> ([a], [b])
public func unzip<A, B>(xs: [(A, B)]) -> ([A],[B])  {
    var r0 = [A]()
    var r1 = [B]()
    for x in xs {
        r0.append(x.0)
        r1.append(x.1)
    }
    
    return (r0, r1)
}

//MARK: unzip3 :: [(a, b, c)] -> ([a], [b], [c])
public func unzip3<A, B, C>(xs: [(A, B, C)]) -> ([A],[B],[C])  {
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
public func unzip4<A, B, C, D>(xs: [(A, B, C, D)]) -> ([A],[B],[C],[D])  {
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
public func unzip5<A, B, C, D, E>(xs: [(A, B, C, D, E)]) -> ([A],[B],[C],[D],[E])  {
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
public func unzip6<A, B, C, D, E, F>(xs: [(A, B, C, D, E, F)]) -> ([A],[B],[C],[D],[E],[F])  {
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
public func unzip7<A, B, C, D, E, F, G>(xs: [(A, B, C, D, E, F, G)]) -> ([A],[B],[C],[D],[E],[F],[G])  {
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
public func lines(s: String)->[String] {
    return splitWith({ x in x == "\n" }, s)
}

public func splitWith(check: Character->Bool, _ s: String)->[String] {
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

//MARK: words :: String -> [String]
public func words(s: String)->[String] {
    let isWhiteSpace    = { (c: Character) in c == " " || c == "\n" || c == "\t" }
    let xs              = splitWith(isWhiteSpace, s)
    let result          = filter({ x in x.characters.count > 0} , xs)
    return result
}

//MARK: unlines :: [String] -> String
public func unlines(xs: [String])->String {
    let result          = join("\n", xs)
    return result
}

public func join(delimiter: String, _ xs: [String]) -> String {
    var result = ""
    for i in 0..<xs.count {
        let t = i == xs.count - 1 ? xs[i] : xs[i] + delimiter
        result = result + t
    }
    return result
}

//MARK: unwords :: [String] -> String
public func unwords(xs: [String])->String {
    let result          = join(" ", xs)
    return result
}

//MARK: "Set" operations
//MARK: nub :: Eq a => [a] -> [a]
public func nub<A: Equatable>(xs: [A]) -> [A] {
    var results  = [A]()
    for x in xs {
        if find( { y in x == y }, results) == nil {
            results.append(x)
        }
    }
    
    return results
}

//MARK: delete :: Eq a => a -> [a] -> [a]
public func delete<A: Equatable>(value: A, _ xs: [A]) -> [A] {
    let idx     = elemIndex(value, xs)
    return idx == nil ? xs : take(idx!, xs) + drop(idx! + 1, xs)
}

//MARK: (\\) :: Eq a => [a] -> [a] -> [a] infix 5
//MARK: union :: Eq a => [a] -> [a] -> [a]
public func union<A: Equatable>(xs1: [A], _ xs2: [A]) -> [A] {
    return nub(xs1 + xs2)
}

//MARK: intersect :: Eq a => [a] -> [a] -> [a]
public func intersect<A: Equatable>(xs1: [A], _ xs2: [A]) -> [A] {
    let isElement   = { (x : A) -> Bool in elemIndex(x, xs2) != nil }
    return filter(isElement, xs1)
}

//MARK: sort :: Ord a => [a] -> [a]
public func sort<A: Comparable>(xs: [A]) -> [A] {
    return sortOn({x, y in x < y}, xs)
}
//MARK: sortOn :: Ord b => (a -> b) -> [a] -> [a]
public func sortOn<A: Comparable>(f: (A,A)->Bool, _ xs: [A]) -> [A] {
    return xs.sort(f)
}

//MARK: insert :: Ord a => a -> [a] -> [a]
//MARK: nubBy :: (a -> a -> Bool) -> [a] -> [a]
//MARK: deleteBy :: (a -> a -> Bool) -> a -> [a] -> [a]
//MARK: deleteFirstsBy :: (a -> a -> Bool) -> [a] -> [a] -> [a]
//MARK: unionBy :: (a -> a -> Bool) -> [a] -> [a] -> [a]
//MARK: intersectBy :: (a -> a -> Bool) -> [a] -> [a] -> [a]
//MARK: groupBy :: (a -> a -> Bool) -> [a] -> [[a]]
//MARK: sortBy :: (a -> a -> Ordering) -> [a] -> [a]
//MARK: insertBy :: (a -> a -> Ordering) -> a -> [a] -> [a]
//MARK: maximumBy :: Foldable t => (a -> a -> Ordering) -> t a -> a
//MARK: minimumBy :: Foldable t => (a -> a -> Ordering) -> t a -> a
//MARK: genericLength :: Num i => [a] -> i
//MARK: genericTake :: Integral i => i -> [a] -> [a]
//MARK: genericDrop :: Integral i => i -> [a] -> [a]
//MARK: genericSplitAt :: Integral i => i -> [a] -> ([a], [a])
//MARK: genericIndex :: Integral i => [a] -> i -> a
//MARK: genericReplicate :: Integral i => i -> a -> [a]
