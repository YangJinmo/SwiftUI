//
//  Home.swift
//  Utils
//
//  Created by Jmy on 2/5/24.
//

import SwiftUI

struct Home: View {
    @EnvironmentObject private var appData: AppData

    var body: some View {
        TabView(selection: $appData.activeTab) {
            HomeView()
                .tag(Tab.home)
                .tabItem {
                    Image(systemName: Tab.home.symbolImage)
                }

            FavouriteView()
                .tag(Tab.favourites)
                .tabItem {
                    Image(systemName: Tab.favourites.symbolImage)
                }

            SettingView()
                .tag(Tab.settings)
                .tabItem {
                    Image(systemName: Tab.settings.symbolImage)
                }
        }
        .tint(.red)
    }

    /// Home View With Nav View's
    @ViewBuilder
    func HomeView() -> some View {
        if #available(iOS 16.0, *) {
            NavigationStack(path: $appData.homeNavStack) {
                List {
                    ForEach(HomeStack.allCases, id: \.rawValue) { link in
                        NavigationLink(value: link) {
                            Text(link.rawValue)
                        }
                    }
                }
                .navigationTitle("Home")
                .navigationDestination(for: HomeStack.self) { link in
                    /// USE SWITCH CASE TO SWITCH VIEW FOR EACH ENUM CASE
                    /// FOR VIDEO PURPOSE IM SIMPLY USING TEXT
                    Text(link.rawValue + " View")
                }
            }
        } else {
            // Fallback on earlier versions
        }
    }

    /// Favourite's View With Nav View's
    @ViewBuilder
    func FavouriteView() -> some View {
        if #available(iOS 16.0, *) {
            NavigationStack(path: $appData.favouriteNavStack) {
                List {
                    ForEach(FavouriteStack.allCases, id: \.rawValue) { link in
                        NavigationLink(value: link) {
                            Text(link.rawValue)
                        }
                    }
                }
                .navigationTitle("Favourite's")
                .navigationDestination(for: FavouriteStack.self) { link in
                    /// USE SWITCH CASE TO SWITCH VIEW FOR EACH ENUM CASE
                    /// FOR VIDEO PURPOSE IM SIMPLY USING TEXT
                    Text(link.rawValue + " View")
                }
            }
        } else {
            // Fallback on earlier versions
        }
    }

    /// Setting's View With Nav View's
    @ViewBuilder
    func SettingView() -> some View {
        if #available(iOS 16.0, *) {
            NavigationStack(path: $appData.settingNavStack) {
                List {
                    ForEach(SettingStack.allCases, id: \.rawValue) { link in
                        NavigationLink(value: link) {
                            Text(link.rawValue)
                        }
                    }
                }
                .navigationTitle("Setting's")
                .navigationDestination(for: SettingStack.self) { link in
                    /// USE SWITCH CASE TO SWITCH VIEW FOR EACH ENUM CASE
                    /// FOR VIDEO PURPOSE IM SIMPLY USING TEXT
                    Text(link.rawValue + " View")
                }
            }
        } else {
            // Fallback on earlier versions
        }
    }
}

#Preview {
    Home()
        .environmentObject(AppData())
}
