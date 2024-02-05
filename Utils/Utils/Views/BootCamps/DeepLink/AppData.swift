//
//  AppData.swift
//  Utils
//
//  Created by Jmy on 2/4/24.
//

import SwiftUI

class AppData: ObservableObject {
    @Published var activeTab: Tab = .home
    @Published var homeNavStack: [HomeStack] = []
    @Published var favouriteNavStack: [FavouriteStack] = []
    @Published var settingNavStack: [SettingStack] = []
}
