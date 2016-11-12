//
//  Prelude.swift
//  HaskellSwift
//
//  Created by Liang on 02/03/2016.
//  Copyright © 2016 Liang. All rights reserved.
//

import Foundation

//MARK: succ
public func succ<A: Integer>(_ x: A) -> A {
    return x + 1
}

public func succ(_ x: Character) -> Character {
    let value = String(x).utf16.first
    assert(value != nil, "Unexpected Character: \(x)")
    return Character(UnicodeScalar(value! + 1)!)
}

public func succ(_ x: Bool) -> Bool {
    return !x
}

//MARK: pred
public func pred<A: Integer>(_ x: A) -> A {
    return x - 1
}

public func pred(_ x: Character) -> Character {
    let value = String(x).utf16.first
    assert(value != nil, "Unexpected Character: \(x)")
    let newValue = value! == 0 ?  0 : value! - 1
    return Character(UnicodeScalar(newValue)!)
}

public func pred(_ x: Bool) -> Bool {
    return !x
}

//MARK: enumFromTo
public func enumFromTo(_ from: Int, _ to: Int) -> Array<Int> {
    return Array<Int>(from...to)
}

public func enumFromTo(_ from: Character, _ to: Character) -> String {
    guard
        let from    = String(from).utf16.first,
        let to      = String(to).utf16.first , to >= from else {
            return ""
    }
    let us = Array<UInt16>(from...to).map { Character(UnicodeScalar($0)!) }
    return String(us)
}

//MARK: until
public func until<B>(_ condition: (B) -> Bool, _ process: (B) -> B,  _ initialValue: B) -> B {
    var value = initialValue
    repeat {
        value = process(value)
    } while (!condition(value))
    return value
}

//MARK: - Integer
//MARK: div
//m (dividend) n (divisor)
public func div<A: Integer>(_ m: A, _ n: A) -> A {
    return m / n
}

//MARK: mod
public func mod<A: Integer>(_ m: A, _ n: A) -> A {
    return m % n
}

//MARK: divMod
public func divMod<A: Integer>(_ m: A, _ n: A) -> (A, A) {
    let quotient  = m / n
    let remainder = m % n
    return (quotient, remainder)
}

//MARK: - Numberic
//MARK: even
public func even<A: Integer>(_ x: A) -> Bool {
    return x % 2 == 0
}

//MARK: odd
public func odd<A: Integer>(_ x: A) -> Bool {
    return !even(x)
}

//MARK: - Files
//MARK: -File
public func fileExists(_ path: String) -> Bool {
    return FileManager.default.fileExists(atPath: path)
}

//readFile :: FilePath -> IO String
public func readFile(_ path: String) -> String? {
    let url = URL(fileURLWithPath: path)
    do {
        let text = try NSString(contentsOf: url, encoding: String.Encoding.utf8.rawValue)
        return text as String
    }
    catch let error as NSError {
        print(error.localizedDescription)
        return nil
    }
}

//writeFile :: FilePath -> String -> IO ()
public func writeFile(_ path: String, _ text: String) -> Bool {
    let block = { try text.write(toFile: path, atomically: true, encoding: String.Encoding.utf8) }
    return processFile(block)
}

//appendFile :: FilePath -> String -> IO ()
public func appendFile(_ path: String, _ text: String) -> Bool {
    guard fileExists(path) else {
        return writeFile(path, text)
    }
    guard let content = readFile(path) else {
        return false
    }
    return writeFile(path, content+text)
}

public func removeFile(_ path: String) -> Bool {
    let block = { try FileManager.default.removeItem(atPath: path) }
    return processFile(block)
}

public func copyFile(_ src: String, _ dst: String) -> Bool {
    let block = { try FileManager.default.copyItem(atPath: src, toPath: dst) }
    return processFile(block)
}

public func readDir(_ path: String) -> [String] {
    do {
        let directoryContents = try FileManager.default.contentsOfDirectory(atPath: path)
        return directoryContents
    } catch let error as NSError {
        print(error.localizedDescription)
        return []
    }
}

func processFile(_ process: () throws -> ()) -> Bool {
    do {
        try process()
        return true
    } catch let error as NSError {
        print("\(error)")
        return false
    }
}

//permission: 0o755
public func getFilePermission(_ path: String) -> UInt32? {
    do {
        let attributes = try FileManager().attributesOfItem(atPath: path)
        if let permission = attributes[FileAttributeKey("NSFilePosixPermissions")] as! NSNumber? {
            return permission.uint32Value
        } else {
            return nil
        }
    }
    catch let error {
        print(error)
        return nil
    }
}

public func setFilePermission(_ path: String, _ permission: Int16) -> Bool {
    let block = { try FileManager.default.setAttributes([FileAttributeKey(rawValue: FileAttributeKey.posixPermissions.rawValue)
        : NSNumber(value: permission)], ofItemAtPath: path) }
    return processFile(block)
}

