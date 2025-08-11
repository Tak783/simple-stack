//
//  UserDefaultsFollowUserServiceSpec.swift
//  StackExchangeUsers
//
//  Created by TM.DEV on 11/08/2025.
//

import XCTest

protocol UserDefaultsFollowUserServiceSpec {
    func test_init_whenCacheIsEmpty_setsFollowedIdsAsEmptySet()
    func test_init_whenCacheIsNotEmpty_setsFollowedIdsAsNonEmptySetWithExpectedIds()

    func test_isFollowed_whenUserIsFollowed_returnsTrue()
    func test_isFollowed_whenUserIsNotFollowed_returnsFalse()
    func test_setFollowed_whenIsFollowedIsTrue_addsUserToCache()
    func test_setFollowed_whenIsFollowedIsFalse_removesUserFromCache()
}

typealias UserDefaultsFollowUserServiceUnitTest = XCTestCase & UserFeedViewModelUnitTestSpec
