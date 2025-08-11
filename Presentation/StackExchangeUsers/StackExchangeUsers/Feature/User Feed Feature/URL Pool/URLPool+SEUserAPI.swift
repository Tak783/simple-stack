//
//  URLPool.swift
//  StackUsers
//
//  Created by TM.DEV on 07/08/2025.
//

import Foundation
import CoreFoundational
import CoreNetworking

extension URLPool {
    private static let scheme = "https"
    private static let host = "api.stackexchange.com"
    private static let path = "/2.2"
    
    private enum EndPoints: String {
        case users = "/users"
    }
}

// MARK: - SEUserAPIURLPoolable
extension URLPool: SEUserAPIURLPoolable {
    static func usersRequest(apiKey: String, pagesize: Int = 20) -> URLRequest {
        let endPoint = path + EndPoints.users.rawValue
        let queryItems = [
            URLQueryItem(name: "site", value: "stackoverflow"),
            URLQueryItem(name: "pagesize", value: String(pagesize)),
            URLQueryItem(name: "key", value: apiKey)
        ]
        let url = configureURL(
            scheme: scheme,
            host: host,
            path: endPoint,
            parameters: queryItems
        )
        return .init(method: .get, url: url)
    }
}
