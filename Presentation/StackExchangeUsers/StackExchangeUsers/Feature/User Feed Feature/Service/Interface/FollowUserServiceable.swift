//
//  FollowUserServiceable.swift
//  StackExchangeUsers
//
//  Created by Tak Mazarura on 11/08/2025.
//

import Foundation

public protocol FollowUserServiceable {
    var followedIDs: Set<Int> { get }
    
    func isFollowed(_ userID: Int) -> Bool
    func setFollowed(_ isFollowed: Bool, for userID: Int)
    
    @discardableResult func toggleFollow(_ userID: Int) -> Bool
}
