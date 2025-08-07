//
//  UserModel.swift
//  StackUsers
//
//  Created by Tak Mazarura on 07/08/2025.
//

import Foundation

struct UserModel {
    let profileImage: URL
    let displayName: String
    let reputation: Int
    var isFollowed: Bool = false

    init(from remote: RemoteUserModel, isFollowed: Bool = false) {
        self.profileImage = remote.profileImage
        self.displayName = remote.displayName
        self.reputation = remote.reputation
        self.isFollowed = isFollowed
    }
}
