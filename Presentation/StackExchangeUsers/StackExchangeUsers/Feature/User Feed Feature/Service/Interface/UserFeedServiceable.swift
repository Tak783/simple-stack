//
//  UserFeedServiceable.swift
//  StackUsers
//
//  Created by TM.DEV on 07/08/2025.
//

import CoreStackExchange

protocol UserFeedServiceable {
    typealias UserFeedLoadResult = Swift.Result<[UserModel], Swift.Error>
    
    func load(completion: @escaping (UserFeedLoadResult) -> Void)
}
