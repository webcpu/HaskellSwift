//
//  Data.Maybe.swift
//  HaskellSwift
//
//  Created by Liang on 31/08/2015.
//  Copyright © 2015 Liang. All rights reserved.
//

import Foundation

//MARK: maybe :: b -> (a -> b) -> Maybe a -> b
public func maybe<A, B>(a: A, _ f:(B->A), _ b: B?) -> A {
    return b == nil ? a : f(b!) //Don't use ??, it is different from this one.
}
//MARK: isJust :: Maybe a -> Bool
//MARK: isNothing :: Maybe a -> Bool
//MARK: fromJust :: Maybe a -> a
//MARK: fromMaybe :: a -> Maybe a -> a
//MARK: listToMaybe :: [a] -> Maybe a
//MARK: maybeToList :: Maybe a -> [a]
//MARK: catMaybes :: [Maybe a] -> [a]
//MARK: mapMaybe :: (a -> Maybe b) -> [a] -> [b]