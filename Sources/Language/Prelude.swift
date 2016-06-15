//
//  Prelude.swift
//  HaskellSwift
//
//  Created by Liang on 02/03/2016.
//  Copyright © 2016 Liang. All rights reserved.
//

import Foundation

//MARK: succ
public func succ<A: IntegerType>(x: A) -> A {
    return x + 1
}

public func succ(x: Character) -> Character {
    let value = String(x).utf16.first
    assert(value != nil, "Unexpected Character: \(x)")
    return Character(UnicodeScalar(value! + 1))
}

public func succ(x: Bool) -> Bool {
    return !x
}

//MARK: pred
public func pred<A: IntegerType>(x: A) -> A {
    return x - 1
}

public func pred(x: Character) -> Character {
    let value = String(x).utf16.first
    assert(value != nil, "Unexpected Character: \(x)")
    let newValue = value! == 0 ?  0 : value! - 1
    return Character(UnicodeScalar(newValue))
}

public func pred(x: Bool) -> Bool {
    return !x
}

//MARK: enumFromTo
public func enumFromTo<A: IntegerType>(from: A, _ to: A) -> Array<A> {
    return Array<A>(from...to)
}

public func enumFromTo(from: Character, _ to: Character) -> String {
    guard
        let from    = String(from).utf16.first,
        let to      = String(to).utf16.first where to >= from else {
            return ""
    }
    let us = Array<UInt16>(from...to).map { Character(UnicodeScalar($0)) }
    return String(us)
}

//MARK: until
public func until<B>(@noescape condition: B -> Bool, @noescape _ process: B -> B,  _ initialValue: B) -> B {
    var value = initialValue
    repeat {
        value = process(value)
    } while (!condition(value))
    return value
}

//MARK: - Integer
//MARK: div
//m (dividend) n (divisor)
public func div<A: IntegerType>(m: A, _ n: A) -> A {
    return m / n
}

//MARK: mod
public func mod<A: IntegerType>(m: A, _ n: A) -> A {
    return m % n
}

//MARK: divMod
public func divMod<A: IntegerType>(m: A, _ n: A) -> (A, A) {
    let quotient  = m / n
    let remainder = m % n
    return (quotient, remainder)
}

//MARK: - Numberic
//MARK: even
public func even<A: IntegerType>(x: A) -> Bool {
    return x % 2 == 0
}

//MARK: odd
public func odd<A: IntegerType>(x: A) -> Bool {
    return !even(x)
}

//MARK: - Files
//MARK: -File
public func fileExists(path: String) -> Bool {
    return NSFileManager.defaultManager().fileExistsAtPath(path)
}

//readFile :: FilePath -> IO String
public func readFile(path: String) -> String? {
    let url = NSURL(fileURLWithPath: path)
    do {
        let text = try NSString(contentsOfURL: url, encoding: NSUTF8StringEncoding)
        return text as String
    }
    catch let error as NSError {
        print(error.localizedDescription)
        return nil
    }
}

//writeFile :: FilePath -> String -> IO ()
public func writeFile(path: String, _ text: String) -> Bool {
    let block = { try text.writeToFile(path, atomically: true, encoding: NSUTF8StringEncoding) }
    return processFile(block)
}

//appendFile :: FilePath -> String -> IO ()
public func appendFile(path: String, _ text: String) -> Bool {
    guard fileExists(path) else {
        return writeFile(path, text)
    }
    guard let content = readFile(path) else {
        return false
    }
    return writeFile(path, content+text)
}

public func removeFile(path: String) -> Bool {
    let block = { try NSFileManager.defaultManager().removeItemAtPath(path) }
    return processFile(block)
}

public func copyFile(src: String, _ dst: String) -> Bool {
    let block = { try NSFileManager.defaultManager().copyItemAtPath(src, toPath: dst) }
    return processFile(block)
}

public func readDir(path: String) -> [String] {
    do {
        let directoryContents = try NSFileManager.defaultManager().contentsOfDirectoryAtPath(path)
        return directoryContents
    } catch let error as NSError {
        print(error.localizedDescription)
        return []
    }
}

func processFile(process: () throws -> ()) -> Bool {
    do {
        try process()
        return true
    } catch let error as NSError {
        print("\(error)")
        return false
    }
}

//permission: 0o755
public func getFilePermission(path: String) -> UInt32? {
    do {
        let attributes = try NSFileManager().attributesOfItemAtPath(path)
        if let permission = attributes["NSFilePosixPermissions"] as! NSNumber? {
            return permission.unsignedIntValue
        } else {
            return nil
        }
    }
    catch let error {
        print(error)
        return nil
    }
}

public func setFilePermission(path: String, _ permission: Int16) -> Bool {
    let block = { try NSFileManager.defaultManager().setAttributes([NSFilePosixPermissions : NSNumber(short: permission)], ofItemAtPath: path) }
    return processFile(block)
}

