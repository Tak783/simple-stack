//
//  UserDefaultsFollowUserService.swift
//  StackExchangeUsers
//
//  Created by Tak Mazarura on 11/08/2025.
//

import Foundation

final class UserDefaultsFollowUserService {
    private let followedUsersKey = "followed_user_ids"
    private let defaults: UserDefaults
    private var cache: Set<Int>
    
    var followedIDs: Set<Int> { cache }
    
    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
        if let ids = defaults.array(forKey: followedUsersKey) as? [Int] {
            self.cache = Set(ids)
        } else {
            self.cache = []
        }
    }
}

// MARK: - FollowUserServiceable
extension UserDefaultsFollowUserService: FollowUserServiceable {
    func isFollowed(_ userID: Int) -> Bool {
        cache.contains(userID)
    }
    
    func setFollowed(_ isFollowed: Bool, for userID: Int) {
        if isFollowed {
            cache.insert(userID)
        } else {
            cache.remove(userID)
        }
        saveUserDefaults()
    }
}

extension UserDefaultsFollowUserService {
    private func saveUserDefaults() {
        defaults.set(Array(cache), forKey: followedUsersKey)
    }
}
