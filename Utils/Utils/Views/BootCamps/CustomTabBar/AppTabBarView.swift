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
    @State private var tabSelection: TabBarItem = TabBarItem(iconName: "house", title: "Home", color: .red)

    var body: some View {
        CustomTabBarContainerView(selection: $tabSelection) {
            Color.blue
        }
    }

//    var body: some View {
//        defaultTabView
//    }
}

#Preview {
    AppTabBarView()
}

extension AppTabBarView {
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
