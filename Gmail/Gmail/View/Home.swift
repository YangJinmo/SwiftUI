//
//  Home.swift
//  Gmail
//
//  Created by Jmy on 2023/07/04.
//

import SwiftUI

struct Home: View {
    @State var currentTab = "Mail"
    
    var bottomEdge: CGFloat

    init(bottomEdge: CGFloat) {
        UITabBar.appearance().isHidden = true
        self.bottomEdge = bottomEdge
    }

    var body: some View {
        TabView(selection: $currentTab) {
            Text("Mail")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.primary.opacity(0.05))
                .tag("Mail")

            Text("Meet")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.primary.opacity(0.05))
                .tag("Meet")
        }
        .overlay(
            CustomTabBar(currentTab: $currentTab, bottomEdge: bottomEdge),
            alignment: .bottom
        )
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
