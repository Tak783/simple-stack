//
//  UserFeedServiceable.swift
//  StackUsers
//
//  Created by Tak Mazarura on 07/08/2025.
//

protocol UserFeedServiceable: AnyObject {
    typealias UserFeedLoadResult = Swift.Result<[UserModel], Swift.Error>
    
    func load(completion: @escaping (UserFeedLoadResult) -> Void)
}
