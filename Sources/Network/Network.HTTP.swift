//
//  Network.HTTP.swift
//  HaskellSwift
//
//  Created by Liang on 30/06/2016.
//  Copyright © 2016 Liang. All rights reserved.
//

import Foundation

public struct Response {
    public let data: Data?
    public let response: URLResponse?
    public let error: NSError?
}

public func simpleHTTP(_ url: URL) -> Response! {
    return URLSession.shared.sync(url)
}

public func getURL(_ urlString: String) -> URL? {
    return URL(string: urlString)
}

extension URLSession {
    func sync(_ url: URL) -> Response! {
        var result: Response!
        let semaphore = DispatchSemaphore(value: 0)
        dataTask(with: url) {
            result = Response(data: $0, response: $1, error: $2 as NSError?)
            semaphore.signal()
            }.resume()

        _ = semaphore.wait(timeout: DispatchTime.distantFuture)

        return result
    }
}
