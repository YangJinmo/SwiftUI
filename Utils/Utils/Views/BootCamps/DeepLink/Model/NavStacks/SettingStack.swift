//
//  SettingStack.swift
//  Utils
//
//  Created by Jmy on 2/4/24.
//

import SwiftUI

enum SettingStack: String, CaseIterable {
    case myProfile = "My Profile"
    case dataUsage = "Data Usage"
    case privacyPolicy = "Privacy Policy"
    case termsOfService = "Terms Of Service"

    static func convert(from: String) -> Self? {
        return allCases.first { tab in
            tab.rawValue.lowercased() == from.lowercased()
        }
    }
}
