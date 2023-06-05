//
//  UIApplication.swift
//  Utils
//
//  Created by Jmy on 2023/06/05.
//

import UIKit.UIApplication

extension UIApplication {
    static var sharedKeyWindow: UIWindow? {
        UIApplication.shared.connectedScenes
            .first(where: { $0 is UIWindowScene })
            .flatMap({ $0 as? UIWindowScene })?.windows
            .first(where: \.isKeyWindow)
    }
}
