//
//  RemoteUserModel.swift
//  StackUsers
//
//  Created by Tak Mazarura on 07/08/2025.
//

import Foundation

struct RemoteUserModel: Codable {
    let profileImage: URL
    let displayName: String
    let reputation: Int

    private enum CodingKeys: String, CodingKey {
        case profileImage = "profile_image"
        case displayName = "display_name"
        case reputation
    }
}
