//
//  UIViewController.swift
//  Animated Header
//
//  Created by Jmy on 2023/02/27.
//

import UIKit.UIViewController

extension UIViewController {
    func presentInKeyWindow(animated: Bool = true, completion: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            UIApplication.shared.mainKeyWindow?.rootViewController?
                .present(self, animated: animated, completion: completion)
        }
    }

    func presentInKeyWindowPresentedController(animated: Bool = true, completion: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            UIApplication.shared.keyWindowPresentedController?
                .present(self, animated: animated, completion: completion)
        }
    }
}
