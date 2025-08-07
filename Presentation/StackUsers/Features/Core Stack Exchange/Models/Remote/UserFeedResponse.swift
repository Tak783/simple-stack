//
//  UserFeedResponse.swift
//  StackUsers
//
//  Created by Tak Mazarura on 07/08/2025.
//

import Foundation

struct RemoteUserFeedResponse: Codable {
    let items: [RemoteUserModel]
    let hasMore: Bool
    let quotaMax: Int
    let quotaRemaining: Int

    private enum CodingKeys: String, CodingKey {
        case items
        case hasMore = "has_more"
        case quotaMax = "quota_max"
        case quotaRemaining = "quota_remaining"
    }
}
