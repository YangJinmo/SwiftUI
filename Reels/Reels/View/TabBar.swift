//
//  TabBar.swift
//  Reels
//
//  Created by Jmy on 2023/03/08.
//

import SwiftUI

struct TabBar: View {
    @State var currentTab = Symbol.play_rectangle.fullName

    init() {
        UITabBar.appearance().isHidden = true
    }

    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $currentTab) {
                Text("Home")
                    .tag(Symbol.house_fill.fullName)

                Text("Search")
                    .tag(Symbol.magnifyingglass.fullName)

                ReelsView(currentTab: $currentTab)
                    .tag(Symbol.play_rectangle.fullName)

                Text("Linked")
                    .tag(Symbol.suit_heart.fullName)

                Text("Profile")
                    .tag(Symbol.person_circle.fullName)
            }

            HStack(spacing: 0) {
                ForEach(Symbol.allCases, id: \.self) { image in
                    TabBarButton(
                        image: image.fullName,
                        isSystemImage: image.fullName != "Reels",
                        currentTab: $currentTab
                    )
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
            .overlay(Divider(), alignment: .top)
            .background(currentTab == Symbol.play_rectangle.fullName ? .black : .clear)
        }
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}

struct TabBarButton: View {
    var image: String
    var isSystemImage: Bool

    @Binding var currentTab: String

    var body: some View {
        Button {
            withAnimation {
                currentTab = image
            }
        } label: {
            ZStack {
                if isSystemImage {
                    Image(systemName: image)
                        .font(.title2)
                } else {
                    Image(image)
                        .resizable()
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 25)
                }
            }
        }
        .foregroundColor(currentTab == image ? currentTab == Symbol.play_rectangle.fullName ? .white : .primary : .gray)
        .frame(maxWidth: .infinity)
    }
}
