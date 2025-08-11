//
//  MockData.swift
//  StackUsers
//
//  Created by TM.DEV on 07/08/2025.
//

import Foundation
import MockNetworking

final class MockData {
    enum FileName: String {
        case user = "User"
        case userFeed = "UserFeed"
        case emptyUsersFeed = "EmptyUsersFeed"
        case malformedUsersFeed = "MalformedUsersFeed"
        case malformedJSON = "MalformedJSON"
    }

    static var mockNetworkingBundle: Bundle {
        Bundle(for: MockData.self)
    }
}

extension MockData {
    static func any_badJSONData(fromBundle bundle: Bundle = .main) -> Data {
        return any_data(for: MockData.FileName.malformedJSON.rawValue, fromBundle: bundle)
    }

    static func any_data(for filename: String, fromBundle bundle: Bundle = .main) -> Data {
        return MockServer.loadLocalJSON(filename, fromBundle: bundle)
    }
}
