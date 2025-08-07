//
//  RemoteUserModel.swift
//  StackUsers
//
//  Created by Tak Mazarura on 07/08/2025.
//

import Foundation

public struct RemoteUserModel: Codable, Equatable, Identifiable {
    public let id: Int
    public let profileImage: URL
    public let displayName: String
    public let reputation: Int
    
    private enum CodingKeys: String, CodingKey {
        case id = "user_id"
        case profileImage = "profile_image"
        case displayName = "display_name"
        case reputation
    }
}
