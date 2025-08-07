//
//  URLRequest+Extensions.swift
//  CoreFoundational
//
//  Created by Takomborerwa Mazarura on 10/04/2021.
//

import Foundation

public extension URLRequest {
    enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
    }
}

enum ContentType: String {
    case json = "application/json"
    case formURLencoded = "application/x-www-form-urlencoded"
}

public extension URLRequest {
    init(method: HTTPMethod, url: URL){
        self.init(url: url)
        httpMethod = method.rawValue
    }
}
