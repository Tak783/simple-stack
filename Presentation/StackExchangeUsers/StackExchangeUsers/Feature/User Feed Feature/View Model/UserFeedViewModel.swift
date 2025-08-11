//
//  UserFeedViewModel.swift
//  StackExchangeUsers
//
//  Created by Tak Mazarura on 10/08/2025.
//

import CoreStackExchange
import CoreFoundational

final class UserFeedViewModel: UserFeedViewModellable {
    var onLoadingStateChange: Observer<Bool>?
    var onFeedLoadError: Observer<String?>?
    var onFeedLoadSuccess: Observer<Void>?
    var onFeedLoadEmptyState: Observer<Bool>?

    private(set) var title: String
    private(set) var userModels: [UserModel]
    private(set) var userFeedService: UserFeedServiceable
    
    init(userFeedService: UserFeedServiceable, title: String) {
        self.title = title
        self.userFeedService = userFeedService
        self.userModels = .init()
    }

    func loadFeed() {
        onLoadingStateChange?(true)
        userFeedService.load { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(users):
                self.userModels = users
                self.onFeedLoadSuccess?(())
                self.onFeedLoadError?(nil)
                self.onFeedLoadEmptyState?(users.isEmpty)
            case .failure:
                self.onFeedLoadError?("Failed to load user feed")
            }
            self.onLoadingStateChange?(false)
        }
    }
}
