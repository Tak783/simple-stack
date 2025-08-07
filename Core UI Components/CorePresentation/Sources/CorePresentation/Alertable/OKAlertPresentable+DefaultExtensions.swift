//
//  OKAlertPresentable.swift
//  
//
//  Created by TM.Dev on 07/10/2023.
//

import Foundation
import UIKit

@MainActor
public protocol OKAlertPresentable {
    func presentOkAlert(
        title: String?,
        message: String?,
        completion: (() -> Void)?
    )
}

extension OKAlertPresentable where Self: AlertPresentable {
    @MainActor public func presentOkAlert(
        title: String?, message: String?, completion: ((UIAlertAction) -> Void)? = nil) {
        let okAction = UIAlertAction(title: "OK", style: .default, handler: completion)
        presentAlertController(
            title: title,
            message: message,
            style: .alert,
            actions: [okAction],
            completion: nil
        )
    }
}
