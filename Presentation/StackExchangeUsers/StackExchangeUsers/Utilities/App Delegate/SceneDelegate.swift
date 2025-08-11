//
//  SceneDelegate.swift
//  StackUsers
//
//  Created by TM.DEV on 07/08/2025.
//

import UIKit
import CorePresentation
import CoreStackExchange

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
        
        UserDefaultsSEAPIKeyProvider.setStackExchangeAPIKey("{add-your-key}")
        
        let router = Router(navigationController: UINavigationController())
        launchCoordinator = LaunchCoordinator(router: router)
        launchCoordinator.navigateToUserFeed()
        
        // Set root view controller
        window.rootViewController = router.navigationController
        self.window = window
        window.makeKeyAndVisible()
    }
}
