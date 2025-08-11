//
//  URLPool+SEUserAPIUnitTests.swift
//  StackExchangeUsers
//
//  Created by Tak Mazarura on 10/08/2025.
//

import XCTest
import CoreFoundational
import CoreNetworking
import CoreTesting
@testable import StackExchangeUsers

import XCTest
import CoreFoundational
import CoreNetworking
import CoreTesting
@testable import StackExchangeUsers

final class SEUsersURLPoolTests: XCTestCase {
    let expectedScheme = "https"
    let expectedHost = "api.stackexchange.com"
    let expectedBasePath = "/2.2"
}

// MARK: - SEUserAPIURLPoolable Tests
extension SEUsersURLPoolTests {
    func test_usersRequest_configuresUsersRequestCorrectly() {
        let endpoint = "/users"
        let expectedPathSuffix = expectedBasePath + endpoint + "?site=stackoverflow&pagesize=20&key=test_key"
        let expectedUrlAbsoluteString = fullURL(withPathSuffix: expectedPathSuffix)
        let request = URLPool.usersRequest(apiKey: "test_key", pagesize: 20)

        assert(request: request, urlAbsoluteString: expectedUrlAbsoluteString, httpMethod: .get)
    }
}

// MARK: - Test Helpers
extension SEUsersURLPoolTests {
    private func fullURL(withPathSuffix pathSuffix: String) -> String {
        return expectedScheme + "://" + expectedHost + pathSuffix
    }
}
