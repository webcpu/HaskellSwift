//
//  System.FilePath.Posix.swift
//  HaskellSwift
//
//  Created by Liang on 27/05/16.
//  Copyright © 2016 Liang. All rights reserved.
//

import Foundation

//MARK: - Separator predicates
public func pathSeparator() -> Character {
    return "/"
}

public func isPathSeparator(_ x: Character) -> Bool {
    return x == "/"
}

public func searchPathSeparator() -> Character {
    return ":"
}

public func isSearchPathSeparator(_ x: Character) -> Bool {
    return x == ":"
}

public func extSeparator() -> Character {
    return "."
}

public func isExtSeparator(_ x: Character) -> Bool {
    return x == "."
}

//MARK: - $PATH methods
public func splitSearchPath(_ filePath: String) -> [String] {
    let xs = splitWith(isSearchPathSeparator, filePath)
    return map({$0 == "" ? "." : $0}, xs)
}

public func getSearchPath() -> [String] {
    let path = ProcessInfo.processInfo.environment["PATH"]
    return isJust(path) ? splitSearchPath(path!) : []
}

//MARK: - Extension functions
//splitExtension :: FilePath -> (String, String)
public func splitExtension(_ filePath: String) -> (String, String) {
    let dir  = dropWhileEnd((not .. isPathSeparator), filePath)
    let lastPathComponent = drop(length(dir), filePath)
    let name = dropWhileEnd((not .. isExtSeparator), lastPathComponent)
    let file = length(name) > 0 ? dir + initx(name) : filePath
    let ext  = drop(length(file), filePath)
    return (file, ext)
}

//takeExtension :: FilePath -> String
public func takeExtension(_ filePath: String) -> String {
    return snd(splitExtension(filePath))
}

//replaceExtension :: FilePath -> String -> FilePath
public func replaceExtension(_ filePath: String, _ newExt: String) -> String {
    let (path, _) = splitExtension(filePath)
    return addExtension(path, newExt)
}

//dropExtension :: FilePath -> String
public func dropExtension(_ filePath: String) -> String {
    return fst(splitExtension(filePath))
}

//addExtension :: FilePath -> String -> FilePath
public func addExtension(_ filePath: String, _ ext: String) -> String {
    if ext == "" {
        return filePath
    }

    return head(ext) == "." ? filePath + ext : filePath + "." + ext
}

//hasExtension :: FilePath -> Bool
public func hasExtension(_ filePath: String) -> Bool {
    return takeExtension(filePath) != ""
}

//     //dropWhileEnd :: (a -> Bool) -> [a] -> [a]
//     public func dropWhile<U>(check: U -> Bool, _ xs: [U]) -> [U] {
//         var len = 0
//         for i in 0..<xs.count {
//                          guard check(xs[i]) else {
//                              len = i
//                              break
//                          }
//                  }
//                      return drop(len, xs)
// }

public func dropWhileEnd(_ check: (Character) -> Bool, _ xs: String) -> String {
    guard length(xs) > 0 else {
        return ""
    }
    let len = lengthOfWhileEndForString(check, xs)
    return take(len, xs)
}

private func lengthOfWhileEndForString(_ check: (Character) -> Bool, _ xs: String) -> Int {
    var len = length(xs)
    for i in 1...xs.characters.count {
        let index = xs.characters.index(xs.endIndex, offsetBy: -i)
        let c     = xs[index]

        guard check(c) else {
            break
        }

        len = len - 1
    }
    return len
}

//splitExtensions :: FilePath -> (FilePath, String)
public func splitExtensions(_ filePath: String) -> (String, String) {
    let dir  = dropWhileEnd((not .. isPathSeparator), filePath)
    let lastPathComponent = drop(length(dir), filePath)
    let name = takeWhile((not .. isExtSeparator), lastPathComponent)
    let file = dir + name
    let ext  = drop(length(file), filePath)
    return (file, ext)
}

public func dropExtensions(_ filePath: String) -> (String) {
    return fst(splitExtensions(filePath))
}

public func takeExtensions(_ filePath: String) -> (String) {
    return snd(splitExtensions(filePath))
}

public func replaceExtensions(_ filePath: String, _ newExt: String) -> String {
    let (path, _) = splitExtensions(filePath)
    return addExtension(path, newExt)
}

public func stripExtensions(_ ext: String, _ filePath: String) -> String? {
    guard length(ext) > 0 else {
        return filePath
    }

    let fullExt = (head(ext) == ".") ? ext : ("." + ext)
    return isSuffixOf(fullExt, filePath) ?  take(length(filePath) - length(fullExt), filePath) : nil
}

//MARK: Filename/directory functions
//splitFileName :: FilePath -> (String, String)
public func splitFileName(_ filePath: String) -> (String, String) {
    let dir  = dropWhileEnd((not .. isPathSeparator), filePath)
    let file = drop(length(dir), filePath)
    return (dir, file)
}

//takeFileName :: FilePath -> FilePath
public func takeFileName(_ filePath: String) -> String {
    return snd(splitFileName(filePath))
}

//replaceFileName :: FilePath -> String -> FilePath
public func replaceFileName(_ filePath: String, _ newName: String) -> String {
    let dir = dropFileName(filePath)
    return dir + newName
}

//dropFileName :: FilePath -> FilePath
//Drop the filename. Unlike takeDirectory, this function will leave a trailing path separator on the directory.
public func dropFileName(_ filePath: String) -> String {
    return fst(splitFileName(filePath))
}

//takeBaseName :: FilePath -> String
public func takeBaseName(_ filePath: String) -> String {
    return dropExtension(takeFileName(filePath))
}

//replaceBaseName :: FilePath -> String -> FilePath
public func replaceBaseName(_ filePath: String, _ baseName: String) -> String {
    let (dir, name) = splitFileName(filePath)
    return dir + baseName + takeExtension(name)
}

//takeDirectory :: FilePath -> FilePath
public func takeDirectory(_ filePath: String) -> String {
    let dir = dropFileName(filePath)
    if dir == "" {
        return "."
    }

    if dir == "/" {
        return dir
    }
    return isPathSeparator(last(dir)) ? initx(dir) : dir
}

//replaceDirectory :: FilePath -> String -> FilePath
public func replaceDirectory(_ filePath: String, _ newDirectory: String) -> String {
    let file = takeFileName(filePath)
    if newDirectory == "" {
        return file
    }

    let dir = isPathSeparator(last(newDirectory)) ? newDirectory : newDirectory + "/"
    return dir + file
}

infix operator </> { associativity right precedence 100}
public func </> (path0: String, path1: String) -> String {
    if path0 == "" {
        return path1
    }

    if length(path1) > 0 && isPathSeparator(head(path1)) {
        return path1
    }

    let path = isPathSeparator(last(path0)) ? path0: path0 + "/"

    return path + path1
}

//splitPath :: FilePath -> [FilePath]
public func splitPath(_ filePath: String) -> [String] {
    if filePath == "" {
        return []
    }
    let xs   = splitWith(isPathSeparator, filePath)
    let dirs = map({$0 + "/"}, initx(xs))
    let file = last(xs)
    return dirs + [file]
}

//joinPath :: [FilePath] -> FilePath
public func joinPath(_ filePaths: [String]) -> String {
    return concat(filePaths)
}

//splitDirectories :: FilePath -> [FilePath]
//Just as splitPath, but don't add the trailing slashes to each element.
public func splitDirectories(_ filePath: String) -> [String] {
    if filePath == "" {
        return []
    }
    let xs      = splitWith(isPathSeparator, filePath)
    let rootDir = head(xs) == "" ? "/" : head(xs)
    let rest    = tail(xs)
    return [rootDir] + rest
}

//MARK: - Trailing slash functions
//hasTrailingPathSeparator :: FilePath -> Bool
public func hasTrailingPathSeparator(_ filePath: String) -> Bool {
    return filePath == "" ? false : isPathSeparator(last(filePath))
}

//addTrailingPathSeparator :: FilePath -> FilePath
public func addTrailingPathSeparator(_ filePath: String) -> String {
    return hasTrailingPathSeparator(filePath) ? filePath : filePath + "/"
}

//dropTrailingPathSeparator :: FilePath -> FilePath
public func dropTrailingPathSeparator(_ filePath: String) -> String {
    if filePath == "" || filePath == "/" {
        return filePath
    }

    return hasTrailingPathSeparator(filePath) ? initx(filePath) : filePath
}

//File name manipulations
//normalisePath :: FilePath -> FilePath
public func normalisePath(_ filePath: String) -> String {
    let path0 = trimWhitespaces(filePath)
    if path0 == "" || path0 == "." {
        return "."
    }
    let path1 = removeDotDirectory(path0)
    let path2 = normalisePathSeparator(path1)
    if path2 == "" {
        return isAbsolutePath(path0) ? "/" : "./"
    } else {
        return path2 == "." ? "./" : path2
    }
}

func trimWhitespaces(_ xs: String) -> String {
    let whitespaceCharacterSet = CharacterSet.whitespacesAndNewlines
    return xs.trimmingCharacters(in: whitespaceCharacterSet)
}

func removeDotDirectory(_ filePath: String) -> String {
    return filePath.replacingOccurrences(of: "/./", with: "")
}

func normalisePathSeparator(_ filePath: String) -> String {
    let removeExtraPathSeparator: (String) -> [String] = map({$0 == "." ? "" : $0}) .. concat .. map(nub) .. group .. splitWith(isPathSeparator)
    let normalise = concat .. intersperse("/") .. removeExtraPathSeparator
    return normalise(filePath)
}

//MARK: File name manipulations
//equalFilePath :: FilePath -> FilePath -> Bool
//Check if file system is case-insensitive

//isRelativePath :: FilePath -> Bool
public func isRelativePath(_ filePath: String) -> Bool {
    return not(isAbsolutePath(filePath))
}

//isAbsolutePath :: FilePath -> Bool
public func isAbsolutePath(_ filePath: String) -> Bool {
    let path = trimWhitespaces(filePath)
    return path == "" ? false : head(path) == "/"
}

//isValid :: FilePath -> Boo
//makeValid :: FilePath -> FilePath
