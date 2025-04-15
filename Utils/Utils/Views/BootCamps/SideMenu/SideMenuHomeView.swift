//
//  SideMenuHomeView.swift
//  Utils
//
//  Created by Jmy on 3/27/25.
//

import SwiftUI

@available(iOS 16.0, *)
struct SideMenuHomeView: View {
    @State private var showMenu = false
    @State private var selectedTab = 0

    var body: some View {
        NavigationStack {
            ZStack {
                TabView(selection: $selectedTab) {
                    Text("Dashboard")
                        .tag(0)

                    Text("Performance")
                        .tag(1)

                    Text("Profile")
                        .tag(2)

                    Text("Search")
                        .tag(3)

                    Text("Notifications")
                        .tag(4)

                    NavigationView {
                        VStack {
                            Text("Home View")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                        }
                        .padding()
                    }
                }

                SideMenuView(isShowing: $showMenu, selectedTab: $selectedTab)
            }
            .toolbar(showMenu ? .hidden : .visible, for: .navigationBar)
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        showMenu.toggle()
                    }) {
                        Image(systemName: "line.3.horizontal")
                    }
                }
            }
        }
    }
}

@available(iOS 16.0, *)
#Preview {
    SideMenuHomeView()
}
