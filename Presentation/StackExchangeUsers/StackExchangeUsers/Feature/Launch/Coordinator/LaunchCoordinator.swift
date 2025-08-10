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
        let service = RemoteUserFeedService(client: client)
        let viewModel = UserFeedViewModel(userFeedService: service, title: "Users")
        let viewController = UserFeedViewController.instantiate()
        
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
