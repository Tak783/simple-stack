//
//  SceneDelegate.swift
//  StackUsers
//
//  Created by Tak Mazarura on 07/08/2025.
//

import UIKit
import CorePresentation

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var launchCoordinator: LaunchCoordinator!
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        
        let router = Router(navigationController: UINavigationController())
        launchCoordinator = Self.appLaunchCoordinator()
        
        // Set root view controller
        window.rootViewController = router.navigationController
        self.window = window
        window.makeKeyAndVisible()
    }
}

extension SceneDelegate {
    private static func appLaunchCoordinator() -> LaunchCoordinator {
        let router = Router(navigationController: .init())
        let launchCoordinator = LaunchCoordinator(
            router: router
        )
        launchCoordinator.navigateToUserFeed()
        return launchCoordinator
    }
}
