//
//  SideMenuOptionModel.swift
//  Utils
//
//  Created by Jmy on 3/27/25.
//

import SwiftUI

enum SideMenuOptionModel: Int, CaseIterable {
    case dashboard
    case performance
    case profile
    case search
    case notifications

    var title: String {
        switch self {
        case .dashboard: return "Dashboard"
        case .performance: return "Performance"
        case .profile: return "Profile"
        case .search: return "Search"
        case .notifications: return "Notifications"
        }
    }

    var imageName: String {
        switch self {
        case .dashboard: return "filemenu.and.cursorarrow"
        case .performance: return "chart.bar"
        case .profile: return "person"
        case .search: return "magnifyingglass"
        case .notifications: return "bell"
        }
    }
}
