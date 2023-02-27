//
//  UIApplication.swift
//  Animated Header
//
//  Created by Jmy on 2023/02/27.
//

import UIKit.UIApplication

extension UIApplication {
    var mainKeyWindow: UIWindow? {
        return UIApplication.shared.connectedScenes
            // Keep only active scenes, onscreen and visible to the user
            // .filter { $0.activationState == .foregroundActive }
            // Keep only the first `UIWindowScene`
            .first(where: { $0 is UIWindowScene })
            // Get its associated windows
            .flatMap({ $0 as? UIWindowScene })?.windows
            // Finally, keep only the key window
            .first(where: \.isKeyWindow)
    }

    var keyWindowPresentedController: UIViewController? {
        var viewController = mainKeyWindow?.rootViewController

        // If root `UIViewController` is a `UITabBarController`
        if let presentedController = viewController as? UITabBarController {
            // Move to selected `UIViewController`
            viewController = presentedController.selectedViewController
        }

        // Go deeper to find the last presented `UIViewController`
        while let presentedController = viewController?.presentedViewController {
            // If root `UIViewController` is a `UITabBarController`
            if let presentedController = presentedController as? UITabBarController {
                // Move to selected `UIViewController`
                viewController = presentedController.selectedViewController
            } else {
                // Otherwise, go deeper
                viewController = presentedController
            }
        }

        return viewController
    }
}
