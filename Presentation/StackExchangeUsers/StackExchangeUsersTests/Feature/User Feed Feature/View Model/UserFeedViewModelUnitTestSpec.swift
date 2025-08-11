//
//  UserFeedViewModelUnitTestSpec.swift
//  StackExchangeUsers
//
//  Created by TM.DEV on 10/08/2025.
//

import XCTest

protocol UserFeedViewModelUnitTestSpec {
    func test_init_setsInitialVariablesCorrectly()
    func test_loadFeed_setsLoadStateToTrue()
    func test_loadFeed_triggersAPICall_whichSuccessOrFailure_setsLoadStateToFalse()
    func test_loadFeed_triggersAPICall_whichOnError_returnsError()
    func test_loadFeed_triggersAPICall_whichOnSuccess_returnsUsers()
}

typealias UserFeedViewModelUnitTest = XCTestCase & UserFeedViewModelUnitTestSpec
