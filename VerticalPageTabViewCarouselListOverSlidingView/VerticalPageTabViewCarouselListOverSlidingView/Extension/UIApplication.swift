//
//  UIApplication.swift
//  VerticalPageTabViewCarouselListOverSlidingView
//
//  Created by Jmy on 2023/03/08.
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
