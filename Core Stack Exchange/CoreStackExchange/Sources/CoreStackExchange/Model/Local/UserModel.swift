//
//  UserModel.swift
//  StackUsers
//
//  Created by TM.DEV on 07/08/2025.
//

import Foundation

public struct UserModel: Equatable, Identifiable {
    public let id: Int
    public let profileImage: URL
    public let displayName: String
    public let reputation: Int
    public var isFollowed: Bool = false

    public init(from remote: RemoteUserModel, isFollowed: Bool = false) {
        self.id = remote.id
        self.profileImage = remote.profileImage
        self.displayName = remote.displayName
        self.reputation = remote.reputation
        self.isFollowed = isFollowed
    }
}

// MARK: - UserModellabe
extension UserModel: UserModellabe {}
