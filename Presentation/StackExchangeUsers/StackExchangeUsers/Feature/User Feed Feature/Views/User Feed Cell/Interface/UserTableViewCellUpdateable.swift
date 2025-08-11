//
//  UserTableViewCellUpdateable.swift
//  StackExchangeUsers
//
//  Created by Tak Mazarura on 11/08/2025.
//

import CoreStackExchange

protocol UserTableViewCellUpdateable {
    func update(withModel model: any UserModellabe)
    func updateFollowButton(isFollowing: Bool)
}
