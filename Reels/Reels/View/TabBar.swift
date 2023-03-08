//
//  TabBar.swift
//  Reels
//
//  Created by Jmy on 2023/03/08.
//

import SwiftUI

struct TabBar: View {
    init() {
        UITabBar.appearance().isHidden = true
    }

    @State var currentTab = "play.rectangle"

    var body: some View {
        VStack {
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

            HStack {
                ForEach(["house.fill", "magnifyingglass", "play.rectangle", "suit.heart", "person.circle"], id: \.self) { image in
                    TabBarButton(image: image, isSystemImage: image != "Reels", currentTab: $currentTab)
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
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
                        .font(.title)
                } else {
                    Image(image)
                        .resizable()
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 25)
                }
            }
        }
        .foregroundColor(currentTab == image ? .primary : .gray)
        .frame(maxWidth: .infinity)
    }
}
