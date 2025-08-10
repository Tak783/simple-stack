//
//  UserFeedViewModellable.swift
//  StackExchangeUsers
//
//  Created by Tak Mazarura on 10/08/2025.
//

import CoreStackExchange
import CoreFoundational

protocol UserFeedViewModellable {
    var title: String { get }
    var users: [UserModel] { get }
    
    var userFeedService: UserFeedServiceable { get }
    
    var onLoadingStateChange: Observer<Bool>? { get set }
    var onFeedLoadError: Observer<String?>? { get set }
    var onFeedLoadSuccess: Observer<Void>? { get set }
    var onFeedLoadEmptyState: Observer<Bool>? { get set }

    func loadFeed()
}
