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

    @State var hideBar = false

    var body: some View {
        TabView(selection: $currentTab) {
            MailView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.primary.opacity(0.05))
                .tag("Mail")

            Text("Meet")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.primary.opacity(0.05))
                .tag("Meet")
        }
        .overlay(
            VStack {
                Button {
                } label: {
                    HStack(spacing: 10) {
                        Image(systemName: "pencil")
                            .font(.title)

                        Text("Compose")
                            .fontWeight(.semibold)
                    }
                    .foregroundColor(Color("Pink"))
                    .padding(.vertical)
                    .padding(.horizontal)
                    .background(Color("TabBG"), in: Capsule())
                    .shadow(color: .primary.opacity(0.06), radius: 5, x: 5, y: 10)
                }
                .padding(.trailing)
                .offset(y: -15)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .opacity(currentTab == "envelope.fill" ? 1 : 0)
                .animation(.none, value: currentTab)

                CustomTabBar(currentTab: $currentTab, bottomEdge: bottomEdge)
            },
            alignment: .bottom
        )
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
