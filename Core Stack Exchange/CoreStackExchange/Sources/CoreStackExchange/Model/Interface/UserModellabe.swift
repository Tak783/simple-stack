//
//  UserModellabe.swift
//  CoreStackExchange
//
//  Created by Tak Mazarura on 11/08/2025.
//

import Foundation

public protocol UserModellabe: Identifiable, Equatable {
    var id: Int { get }
    var profileImage: URL { get }
    var displayName: String { get }
    var reputation: Int { get }
    var isFollowed: Bool { get set }
}
