//
//  TabBar.swift
//  Reels
//
//  Created by Jmy on 2023/03/08.
//

import SwiftUI

struct TabBar: View {
    @State var currentTab = Symbol().imageName

    init() {
        UITabBar.appearance().isHidden = true
    }

    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $currentTab) {
                Text("Home")
                    .tag(Symbol.houseFill.imageName)

                Text("Search")
                    .tag(Symbol.magnifyingglass.imageName)

                ReelsView()
                    .tag(Symbol.playRectangle.imageName)

                Text("Linked")
                    .tag(Symbol.suitHeart.imageName)

                Text("Profile")
                    .tag(Symbol.personCircle.imageName)
            }

            HStack(spacing: 0) {
                ForEach(Symbol.allCases, id: \.self) { symbol in
                    TabBarButton(
                        image: symbol.imageName,
                        isSystemImage: symbol.imageName != "Reels",
                        currentTab: $currentTab
                    )
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
            .overlay(Divider(), alignment: .top)
            .background(currentTab == Symbol().imageName ? .black : .clear)
            .preferredColorScheme(.dark)
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
        .foregroundColor(currentTab == image ? currentTab == Symbol().imageName ? .white : .primary : .gray)
        .frame(maxWidth: .infinity)
    }
}
