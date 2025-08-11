//
//  UserFollowedStatusUpdatable.swift
//  StackExchangeUsers
//
//  Created by Tak Mazarura on 11/08/2025.
//

protocol UserFollowedStatusUpdatable {
    func followedStatus(forUserWithId userID: Int) -> Bool
    func didRequestToUpdateFollowStatusFor(userWithId: Int)
}
