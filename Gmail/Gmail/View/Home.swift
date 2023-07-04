//
//  Home.swift
//  Gmail
//
//  Created by Jmy on 2023/07/04.
//

import SwiftUI

struct Home: View {
    @State var currentTab = "Mail"
    
    init() {
        UITabBar.appearance().isHidden = true
    }

    var body: some View {
        TabView(selection: $currentTab) {
            Text("Mail")
                .tag("Mail")

            Text("Meet")
                .tag("Meet")
        }
        .overlay(
            CustomTabBar(currentTab: $currentTab), alignment: .bottom
        )
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
