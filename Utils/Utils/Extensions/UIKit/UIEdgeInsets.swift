//
//  UIEdgeInsets.swift
//  Utils
//
//  Created by Jmy on 2023/06/05.
//

import UIKit.UIGeometry

extension UIEdgeInsets {
    static var safeAreaInsets: UIEdgeInsets {
        return UIApplication.sharedKeyWindow?.safeAreaInsets ?? UIEdgeInsets()
    }
}
