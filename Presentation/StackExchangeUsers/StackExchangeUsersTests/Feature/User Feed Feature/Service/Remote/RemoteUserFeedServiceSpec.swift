//
//  RemoteUserFeedServiceSpec.swift
//  StackUsers
//
//  Created by TM.DEV on 07/08/2025.
//

import XCTest

protocol RemoteUserFeedServiceSpec {
    func test_load_onSuccess_returnsUsers()
    func test_load_onSuccessWithNon200Code_returnsError()
    func test_load_onSuccessWithInvalidData_returnsError()
    func test_load_onFailure_returnsError()
}

typealias RemoteUserFeedServiceTest = XCTestCase & RemoteUserFeedServiceSpec
