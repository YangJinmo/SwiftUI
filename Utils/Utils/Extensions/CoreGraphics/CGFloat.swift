//
//  CGFloat.swift
//  Utils
//
//  Created by Jmy on 2023/06/05.
//

import CoreFoundation
import UIKit.UIGeometry

extension CGFloat {
    static var toastBottom: CGFloat {
        return UIEdgeInsets.safeAreaInsets.bottom > 0 ? UIEdgeInsets.safeAreaInsets.bottom : 20
    }
}
