//
//  CGFloat.swift
//  Utils
//
//  Created by Jmy on 2023/06/05.
//

import CoreFoundation
import UIKit.UIGeometry

extension CGFloat {
    static var top: CGFloat {
        return UIEdgeInsets.safeAreaInsets.top
    }

    static var bottom: CGFloat {
        return UIEdgeInsets.safeAreaInsets.bottom
    }

    static var toastBottom: CGFloat {
        return bottom > 0 ? bottom : 20
    }
}
