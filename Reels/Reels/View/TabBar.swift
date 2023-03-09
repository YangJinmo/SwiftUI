//
//  TabBar.swift
//  Reels
//
//  Created by Jmy on 2023/03/08.
//

import SwiftUI

struct TabBar: View {
    @State var currentTab = "play.rectangle"

    init() {
        UITabBar.appearance().isHidden = true
    }

    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $currentTab) {
                Text("Home")
                    .tag("house.fill")

                Text("Search")
                    .tag("magnifyingglass")

                ReelsView()
                    .tag("play.rectangle")

                Text("Linked")
                    .tag("suit.heart")

                Text("Profile")
                    .tag("person.circle")
            }

            HStack(spacing: 0) {
                ForEach(["house.fill", "magnifyingglass", "play.rectangle", "suit.heart", "person.circle"], id: \.self) { image in
                    TabBarButton(image: image, isSystemImage: image != "Reels", currentTab: $currentTab)
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
            .overlay(Divider(), alignment: .top)
            .background(currentTab == "play.rectangle" ? .black : .clear)
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
        .foregroundColor(currentTab == image ? currentTab == "play.rectangle" ? .white : .primary : .gray)
        .frame(maxWidth: .infinity)
    }
}
