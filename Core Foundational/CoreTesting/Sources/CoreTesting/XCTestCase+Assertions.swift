//
//  XCTestCase+Assertions.swift
//  CoreTesting
//
//  Created by Takomborerwa Mazarura on 10/04/2021.
//

import Foundation
import XCTest

public extension URLRequest {
    enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
    }
    
    enum ContentType: String {
        case json = "application/json"
        case formURLencoded = "application/x-www-form-urlencoded"
    }
}
