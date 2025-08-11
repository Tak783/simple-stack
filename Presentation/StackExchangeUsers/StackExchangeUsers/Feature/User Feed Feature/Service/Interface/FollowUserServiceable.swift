//
//  FollowUserServiceable.swift
//  StackExchangeUsers
//
//  Created by TM.DEV on 11/08/2025.
//

import Foundation

public protocol FollowUserServiceable {
    var followedIDs: Set<Int> { get }
    
    func isFollowed(_ userID: Int) -> Bool
    func setFollowed(_ isFollowed: Bool, for userID: Int)
}
