//
//  SEUserAPIURLPoolable.swift
//  StackUsers
//
//  Created by Tak Mazarura on 07/08/2025.
//

import Foundation

protocol SEUserAPIURLPoolable {
    static func usersRequest(apiKey: String) -> URLRequest
}
