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
                .tabItem {
                    Image(systemName: Tab.home.symbolImage)
                }
        }
        .tint(.red)
    }

    /// Home View With Nav View's
    @ViewBuilder
    func HomeView() -> some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
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
}

#Preview {
    Home()
        .environmentObject(AppData())
}
