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
    var body: some View {
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

#Preview {
    AppTabBarView()
}
