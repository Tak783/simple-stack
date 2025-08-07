//
//  UserDefaultsSEAPIKeyProvider.swift
//  StackUsers
//
//  Created by Tak Mazarura on 07/08/2025.
//

import Foundation

/// User Defaults only used for speed, API Call should happen on the backend for security, speed and re-usability purposes
public struct UserDefaultsSEAPIKeyProvider: SEAPIKeyProviding {
    private static let apiKeyKey = "stackExchangeAPIKey"
    
    public static func stackExchangeAPIKey() -> String? {
        UserDefaults.standard.string(forKey: apiKeyKey)
    }
}
