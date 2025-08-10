//
//  UserFeedViewModel.swift
//  StackExchangeUsers
//
//  Created by Tak Mazarura on 10/08/2025.
//

import CoreStackExchange
import CoreFoundational

struct UserFeedViewModel: UserFeedViewModellable {
    var onLoadingStateChange: Observer<Bool>?
    var onFeedLoadError: Observer<String?>?
    var onFeedLoadSuccess: Observer<[UserModel]>?
    var onFeedLoadEmptyState: Observer<Bool>?

    var userFeedService: UserFeedServiceable
    var title: String

    init(userFeedService: UserFeedServiceable, title: String) {
        self.title = title
        self.userFeedService = userFeedService
    }

    func loadFeed() {
        onLoadingStateChange?(true)
        userFeedService.load { result in
            switch result {
            case let .success(users):
                onFeedLoadSuccess?(users)
                onFeedLoadError?(nil)
                onFeedLoadEmptyState?(users.isEmpty)
            case .failure:
                onFeedLoadError?("Failed to load user feed")
            }
            onLoadingStateChange?(false)
        }
    }
}
