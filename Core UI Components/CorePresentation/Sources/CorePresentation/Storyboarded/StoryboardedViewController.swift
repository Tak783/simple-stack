//
//  StoryboardedViewController.swift
//  
//
//  Created by TM.Dev on 28/01/2022.
//  
//

import Foundation
import CoreFoundational
import UIKit

public typealias StoryboardedViewController = UIViewController & Storyboarded

@MainActor
extension Storyboarded where Self: UIViewController {
    private static var storyboardName: String {
        className.deletingSuffix("ViewController")
    }

     public static func instantiate(fromBundle bundle: Bundle = Bundle.main) -> Self {
        let storyboard = UIStoryboard(name: storyboardName, bundle: bundle)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: className) as? Self else {
            fatalError("Could not create View Controller with name \(className) from storyboard \(storyboardName)")
        }
        return viewController
    }
}

fileprivate extension String {
    /// Removes the given String from the end of the string String.
    /// If the text is not present, returns the original String intact.
    ///
    /// - Parameters:
    ///     - suffix: The text to be removed, e.g. "ViewController"
    ///
    /// - Returns:
    ///     - If suffix was found, String with the suffix removed, e.g. "MainViewController" -> "Main"
    ///     - If no suffix was found, the original string intact. e.g. "MainCoordinator" -> "MainCoordinator"
    ///
    func deletingSuffix(_ suffix: String) -> String {
        guard self.hasSuffix(suffix) else { return self }
        return String(self.dropLast(suffix.count))
    }
}
