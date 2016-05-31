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

public func isPathSeparator(x: Character) -> Bool {
    return x == "/"
}

public func searchPathSeparator() -> Character {
    return ":"
}

public func isSearchPathSeparator(x: Character) -> Bool {
    return x == ":"
}

public func extSeparator() -> Character {
    return "."
}

public func isExtSeparator(x: Character) -> Bool {
    return x == "."
}

//MARK: - $PATH methods
public func splitSearchPath(filePath: String) -> [String] {
    let xs = splitWith(isSearchPathSeparator, filePath)
    return map({$0 == "" ? "." : $0}, xs)
}

public func getSearchPath() -> [String] {
    let path = NSProcessInfo.processInfo().environment["PATH"]
    return isJust(path) ? splitSearchPath(path!) : []
}

//MARK: - Extension functions
//splitExtension :: FilePath -> (String, String)
public func splitExtension(filePath: String) -> (String, String) {
    let dir  = dropWhileEnd((not .. isPathSeparator), filePath)
    let lastPathComponent = drop(length(dir), filePath)
    let name = dropWhileEnd((not .. isExtSeparator), lastPathComponent)
    let file = length(name) > 0 ? dir + initx(name) : filePath
    let ext  = drop(length(file), filePath)
    return (file, ext)
}

//takeExtension :: FilePath -> String
public func takeExtension(filePath: String) -> String {
    return snd(splitExtension(filePath))
}

//replaceExtension :: FilePath -> String -> FilePath
public func replaceExtension(filePath: String, _ newExt: String) -> String {
    let (path, _) = splitExtension(filePath)
    return addExtension(path, newExt)
}

//dropExtension :: FilePath -> String
public func dropExtension(filePath: String) -> String {
    return fst(splitExtension(filePath))
}

//addExtension :: FilePath -> String -> FilePath
public func addExtension(filePath: String, _ ext: String) -> String {
    if ext == "" {
        return filePath
    }

    return head(ext) == "." ? filePath + ext : filePath + "." + ext
}

//hasExtension :: FilePath -> Bool
public func hasExtension(filePath: String) -> Bool {
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

public func dropWhileEnd(check: Character -> Bool, _ xs: String) -> String {
    guard length(xs) > 0 else {
        return ""
    }
    let len = lengthOfWhileEndForString(check, xs)
    return take(len, xs)
}

private func lengthOfWhileEndForString(check: Character -> Bool, _ xs: String) -> Int {
    var len = length(xs)
    for i in 1...xs.characters.count {
        let index = xs.endIndex.advancedBy(-i)
        let c     = xs[index]

        guard check(c) else {
            break
        }

        len = len - 1
    }
    return len
}

//splitExtensions :: FilePath -> (FilePath, String)
public func splitExtensions(filePath: String) -> (String, String) {
    let dir  = dropWhileEnd((not .. isPathSeparator), filePath)
    let lastPathComponent = drop(length(dir), filePath)
    let name = takeWhile((not .. isExtSeparator), lastPathComponent)
    let file = dir + name
    let ext  = drop(length(file), filePath)
    return (file, ext)
}

public func dropExtensions(filePath: String) -> (String) {
    return fst(splitExtensions(filePath))
}

public func takeExtensions(filePath: String) -> (String) {
    return snd(splitExtensions(filePath))
}

public func replaceExtensions(filePath: String, _ newExt: String) -> String {
    let (path, _) = splitExtensions(filePath)
    return addExtension(path, newExt)
}

public func stripExtensions(ext: String, _ filePath: String) -> String? {
    guard length(ext) > 0 else {
        return filePath
    }

    let fullExt = (head(ext) == ".") ? ext : ("." + ext)
    return isSuffixOf(fullExt, filePath) ?  take(length(filePath) - length(fullExt), filePath) : nil
}

//MARK: Filename/directory functions
//splitFileName :: FilePath -> (String, String)
public func splitFileName(filePath: String) -> (String, String) {
    let dir  = dropWhileEnd((not .. isPathSeparator), filePath)
    let file = drop(length(dir), filePath)
    return (dir, file)
}

//takeFileName :: FilePath -> FilePath
public func takeFileName(filePath: String) -> String {
    return snd(splitFileName(filePath))
}

//replaceFileName :: FilePath -> String -> FilePath
public func replaceFileName(filePath: String, _ newName: String) -> String {
    let dir = dropFileName(filePath)
    return dir + newName
}

//dropFileName :: FilePath -> FilePath
//Drop the filename. Unlike takeDirectory, this function will leave a trailing path separator on the directory.
public func dropFileName(filePath: String) -> String {
    return fst(splitFileName(filePath))
}

//takeBaseName :: FilePath -> String
public func takeBaseName(filePath: String) -> String {
    return dropExtension(takeFileName(filePath))
}

//replaceBaseName :: FilePath -> String -> FilePath
public func replaceBaseName(filePath: String, _ baseName: String) -> String {
    let (dir, name) = splitFileName(filePath)
    return dir + baseName + takeExtension(name)
}

//takeDirectory :: FilePath -> FilePath
public func takeDirectory(filePath: String) -> String {
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
public func replaceDirectory(filePath: String, _ newDirectory: String) -> String {
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
public func splitPath(filePath: String) -> [String] {
    if filePath == "" {
        return []
    }
    let xs   = splitWith(isPathSeparator, filePath)
    let dirs = map({$0 + "/"}, initx(xs))
    let file = last(xs)
    return dirs + [file]
}

//joinPath :: [FilePath] -> FilePath
public func joinPath(filePaths: [String]) -> String {
    return concat(filePaths)
}

//splitDirectories :: FilePath -> [FilePath]
//Just as splitPath, but don't add the trailing slashes to each element.
public func splitDirectories(filePath: String) -> [String] {
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
public func hasTrailingPathSeparator(filePath: String) -> Bool {
    return filePath == "" ? false : isPathSeparator(last(filePath))
}

//addTrailingPathSeparator :: FilePath -> FilePath
public func addTrailingPathSeparator(filePath: String) -> String {
    return hasTrailingPathSeparator(filePath) ? filePath : filePath + "/"
}

//dropTrailingPathSeparator :: FilePath -> FilePath
public func dropTrailingPathSeparator(filePath: String) -> String {
    if filePath == "" || filePath == "/" {
        return filePath
    }

    return hasTrailingPathSeparator(filePath) ? initx(filePath) : filePath
}

//File name manipulations
//normalise :: FilePath -> FilePath
public func normalise(filePath: String) -> String {
   return filePath
}
