//
//  AppTabBarView.swift
//  Utils
//
//  Created by Jmy on 3/5/24.
//

import SwiftUI

// Generics
// ViewBuilder
// PreferenceKey
// MatchedGeometryEffect

struct AppTabBarView: View {
    @State private var selection: String = "home"
//    @State private var tabSelection: TabBarItem = TabBarItem(iconName: "house", title: "Home", color: .red)
    @State private var tabSelection: TabBarItem = .home

    var body: some View {
        CustomTabBarContainerView(selection: $tabSelection) {
            Color.red
//                .tabBarItem(tab: TabBarItem(iconName: "house", title: "Home", color: .red), selection: $tabSelection)
                .tabBarItem(tab: .home, selection: $tabSelection)

            Color.blue
//                .tabBarItem(tab: TabBarItem(iconName: "heart", title: "Favorites", color: .blue), selection: $tabSelection)
                .tabBarItem(tab: .favorites, selection: $tabSelection)

            Color.green
//                .tabBarItem(tab: TabBarItem(iconName: "person", title: "Profile", color: .green), selection: $tabSelection)
                .tabBarItem(tab: .profile, selection: $tabSelection)
        }
    }
}

#Preview {
    AppTabBarView()
}

extension AppTabBarView {
    private var defaultTabView: some View {
        TabView(selection: $selection) {
            Color.red
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
                .tag(1)

            Color.blue
                .tabItem {
                    Image(systemName: "heart")
                    Text("Favorites")
                }
                .tag(2)

            Color.orange
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
                .tag(3)
        }
    }
}

struct AppNavTabBarView: View {
    var body: some View {
        defaultTabView
    }
}

#Preview {
    AppNavTabBarView()
}

extension AppNavTabBarView {
    private var defaultTabView: some View {
        NavigationView {
            ZStack {
                Color.green.ignoresSafeArea()

                NavigationLink {
                    Text("Destination")
                        .navigationTitle("Title 2")
                        .navigationBarBackButtonHidden(false)
                } label: {
                    Text("Navigate")
                }
            }
        }
    }
}
