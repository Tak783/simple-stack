//
//  UserFeedViewModel.swift
//  StackExchangeUsers
//
//  Created by Tak Mazarura on 10/08/2025.
//

import CoreStackExchange
import CoreFoundational

final class UserFeedViewModel {
    var onLoadingStateChange: Observer<Bool>?
    var onFeedLoadError: Observer<String?>?
    var onFeedLoadSuccess: Observer<Void>?
    var onFeedLoadEmptyState: Observer<Bool>?
    
    private(set) var title: String
    private(set) var userModels: [UserModel]
    
    private var userFeedService: UserFeedServiceable
    private var userFollowingService: FollowUserServiceable
    
    init(
        userFeedService: UserFeedServiceable,
        userFollowingService: FollowUserServiceable,
        title: String
    ) {
        self.title = title
        self.userFeedService = userFeedService
        self.userFollowingService = userFollowingService
        self.userModels = .init()
    }
}

// MARK: - UserFeedViewModellable
extension UserFeedViewModel: UserFeedViewModellable {
    func loadFeed() {
        onLoadingStateChange?(true)
        userFeedService.load { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(userModels):
                let userModelsWithFollowedStatus = addFollowedStatus(
                    toUserModels: userModels
                )
                self.userModels = userModelsWithFollowedStatus
                self.onFeedLoadSuccess?(())
                self.onFeedLoadError?(nil)
                self.onFeedLoadEmptyState?(userModelsWithFollowedStatus.isEmpty)
            case .failure:
                self.onFeedLoadError?("Failed to load user feed")
            }
            self.onLoadingStateChange?(false)
        }
    }
}

// MARK: - UserFollowedStatusUpdatable
extension UserFeedViewModel: UserFollowedStatusUpdatable {
    func didRequestToUpdateFollowStatusFor(userWithId userID: Int) {
        guard let index = userModels.firstIndex(where: { $0.id == userID }) else {
            return
        }
        let newFollowedStatus = !userModels[index].isFollowed
        updateUsingService(newUserFollowedStatus: newFollowedStatus, userID: userID)
        updateLocally(newUserFollowedStatus: newFollowedStatus, userIndex: index)
    }
    
    func followedStatus(forUserWithId userID: Int) -> Bool {
        guard let index = userModels.firstIndex(where: { $0.id == userID }) else {
            return false
        }
        return userModels[index].isFollowed
    }
}

// MARK: - Helpers
extension UserFeedViewModel {
    private func addFollowedStatus(toUserModels userModels: [UserModel]) -> [UserModel] {
        var updatedUserModels = userModels
        for (index, userModel) in updatedUserModels.enumerated() {
            updatedUserModels[index].isFollowed = userFollowingService.isFollowed(
                userModel.id
            )
        }
        return updatedUserModels
    }
    
    private func updateUsingService(newUserFollowedStatus: Bool, userID: Int) {
        userFollowingService.setFollowed(newUserFollowedStatus, for: userID)
    }
    
    private func updateLocally(newUserFollowedStatus: Bool, userIndex: Int) {
        userModels[userIndex].isFollowed = newUserFollowedStatus
    }
}
