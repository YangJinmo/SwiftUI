//
//  TabBar.swift
//  Reels
//
//  Created by Jmy on 2023/03/08.
//

import SwiftUI

struct TabBar: View {
    @State var currentTab = Symbol().fullName

    init() {
        UITabBar.appearance().isHidden = true
    }

    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $currentTab) {
                Text("Home")
                    .tag(Symbol.houseFill.fullName)

                Text("Search")
                    .tag(Symbol.magnifyingglass.fullName)

                ReelsView()
                    .tag(Symbol.playRectangle.fullName)

                Text("Linked")
                    .tag(Symbol.suitHeart.fullName)

                Text("Profile")
                    .tag(Symbol.personCircle.fullName)
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
            .background(currentTab == Symbol().fullName ? .black : .clear)
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
        .foregroundColor(currentTab == image ? currentTab == Symbol().fullName ? .white : .primary : .gray)
        .frame(maxWidth: .infinity)
    }
}