//
//  TestsUserDefaultsManager.swift
//  StackExchangeUsers
//
//  Created by Tak Mazarura on 11/08/2025.
//

import Foundation

struct TestsUserDefaultsManager {
    static func clearUserDefaults() {
        if let bundleID = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: bundleID)
        }
    }
}
