//
//  URLRequest+Extensions.swift
//  CoreNetworking
//
//  Created by Tak Mazarura on 06/06/2021.
//

import Foundation

public extension URLRequest {
    enum ContentType: String {
        case json = "application/json"
        case formURLencoded = "application/x-www-form-urlencoded"
    }
    
    mutating func setContentType(_ contentType: ContentType) {
        setValue(contentType.rawValue, forHTTPHeaderField: "Content-Type")
    }
}
