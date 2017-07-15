//
//  System.Directory.swift
//  HaskellSwift
//
//  Created by Liang on 28/06/2016.
//  Copyright © 2016 Liang. All rights reserved.
//

import Foundation

//MARK: - Actions on directories
//createDirectory :: FilePath -> IO ()
public func createDirectory(_ path: String) -> Bool {
    let block = { try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true) }
    return process(block)
}

private func process(_ block: () throws -> ()) -> Bool {
    do {
        try block()
        return true
    } catch let error as NSError {
        print("\(error)")
        return false
    }
}
