//
//  UIView.swift
//  Utils
//
//  Created by Jmy on 2023/11/25.
//

import UIKit.UIView

extension UIView {
    func findViewController() -> UIViewController? {
        if let nextResponder = next as? UIViewController {
            return nextResponder
        } else if let nextResponder = next as? UIView {
            return nextResponder.findViewController()
        }

        return nil
    }
}
