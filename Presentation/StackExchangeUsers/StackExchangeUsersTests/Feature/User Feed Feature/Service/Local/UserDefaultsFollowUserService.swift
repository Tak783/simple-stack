//
//  UserDefaultsFollowUserService.swift
//  StackExchangeUsers
//
//  Created by Tak Mazarura on 11/08/2025.
//

import XCTest
@testable import StackExchangeUsers

final class UserDefaultsFollowUserServiceTests: XCTestCase, UserDefaultsFollowUserServiceSpec {
    private var defaults: UserDefaults!
    private let followedUsersKey = "followed_user_ids"
    
    override func setUp() {
        super.setUp()
        defaults = UserDefaults(suiteName: "test.\(UUID().uuidString)")!
        TestsUserDefaultsManager.clearUserDefaults()
    }
    
    override func tearDown() {
        TestsUserDefaultsManager.clearUserDefaults()
        defaults = nil
        super.tearDown()
    }
}

// MARK: - Test `init`
extension UserDefaultsFollowUserServiceTests {
    func test_init_whenCacheIsEmpty_setsFollowedIdsAsEmptySet() {
        let sut = make_sut()
        
        XCTAssertTrue(sut.followedIDs.isEmpty, "Expected empty followedIDs when cache is empty")
    }
    
    func test_init_whenCacheIsNotEmpty_setsFollowedIdsAsNonEmptySetWithExpectedIds() {
        let expected = [1, 2, 3]
        defaults.set(expected, forKey: followedUsersKey)
        
        let sut = make_sut()
        
        XCTAssertEqual(sut.followedIDs, Set(expected), "Expected followedIDs to match persisted IDs")
    }
}

// MARK: - Test `isFollowed`
extension UserDefaultsFollowUserServiceTests {
    func test_isFollowed_whenUserIsFollowed_returnsTrue() {
        defaults.set([42], forKey: followedUsersKey)
        let sut = make_sut()
        
        XCTAssertTrue(sut.isFollowed(42))
    }
    
    func test_isFollowed_whenUserIsNotFollowed_returnsFalse() {
        let sut = make_sut()
        
        XCTAssertFalse(sut.isFollowed(99))
    }
}

// MARK: - Test `setFollowed`
extension UserDefaultsFollowUserServiceTests {
    func test_setFollowed_whenIsFollowedIsTrue_addsUserToCache() {
        let sut = make_sut()

        sut.setFollowed(true, for: 7)

        XCTAssertTrue(sut.followedIDs.contains(7), "Expected cache to include ID after follow")
        
        let persisted = defaults.array(forKey: followedUsersKey) as? [Int] ?? []
        XCTAssertTrue(persisted.contains(7), "Expected UserDefaults to include ID after follow")
    }

    func test_setFollowed_whenIsFollowedIsFalse_removesUserFromCache() {
        defaults.set([9], forKey: followedUsersKey)
        let sut = make_sut()

        sut.setFollowed(false, for: 9)

        XCTAssertFalse(sut.followedIDs.contains(9), "Expected cache to remove ID after unfollow")
        let persisted = defaults.array(forKey: followedUsersKey) as? [Int] ?? []
        XCTAssertFalse(persisted.contains(9), "Expected UserDefaults to remove ID after unfollow")
    }
}

// MARK: - Helpers
private extension UserDefaultsFollowUserServiceTests {
    func make_sut() -> UserDefaultsFollowUserService {
        let sut = UserDefaultsFollowUserService(defaults: defaults)
        return sut
    }
}
