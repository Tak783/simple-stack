//
//  LaunchCoordinator.swift
//  StackExchangeUsers
//
//  Created by Tak Mazarura on 10/08/2025.
//

import CoreNetworking
import CorePresentation

@MainActor
final class LaunchCoordinator {
    var router: Router
    var childCoordinators = [ChildCoordinatorable]()
    
    init(
        router: Router,
        childCoordinators: [ChildCoordinatorable] = [ChildCoordinatorable]()
    ) {
        self.router = router
        self.childCoordinators = childCoordinators
    }
}

// MARK: - LaunchCoordinatorable
extension LaunchCoordinator: LaunchCoordinatorable {
    func navigateToUserFeed() {
        let client = URLSessionHTTPClient()
        let feedService = RemoteUserFeedService(client: client)
        let userFollowingService = UserDefaultsFollowUserService()
        let feedViewModel = UserFeedViewModel(
            userFeedService: feedService,
            userFollowingService: userFollowingService,
            title: "Users"
        )
        let viewController = UserFeedViewController.instantiate()
        viewController.feedViewModel = feedViewModel
        
        router.navigateToViewController(
            viewController,
            withMethod: .push,
            animated: true
        )
    }
}

// MARK: - ParentCoordinatorable
extension LaunchCoordinator: ParentCoordinatorable {
    func didEnd(childCoordinator: any CorePresentation.ChildCoordinatorable) {}
}
