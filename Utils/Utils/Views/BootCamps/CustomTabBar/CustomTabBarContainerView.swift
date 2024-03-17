//
//  CustomTabBarContainerView.swift
//  Utils
//
//  Created by Jmy on 3/8/24.
//

import SwiftUI

struct CustomTabBarContainerView<Content: View>: View {
    @Binding var selection: TabBarItem
    let content: Content
    @State private var tabs: [TabBarItem] = []

    init(selection: Binding<TabBarItem>, @ViewBuilder content: () -> Content) {
        _selection = selection
        self.content = content()
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            content
                .ignoresSafeArea()

            CustomTabBarView(tabs: tabs, selection: $selection, localSelection: selection)
        }
        .onPreferenceChange(TabBarItemsPreferenceKey.self, perform: { value in
            tabs = value
        })
    }
}

#Preview {
    VStack {
        let tabs: [TabBarItem] = [
            .home, .favorites, .profile,
        ]

        CustomTabBarContainerView(selection: .constant(tabs.first!)) {
            Color.red
        }
    }

//    VStack {
//        let tabs = [
//            TabBarItem(iconName: "house", title: "Home", color: .red),
//            TabBarItem(iconName: "heart", title: "Favorites", color: .blue),
//            TabBarItem(iconName: "person", title: "Profile", color: .green),
//        ]
//
//        Spacer()
//
//        CustomTabBarView(
//            tabs: tabs,
//            selection: .constant(tabs.first!)
//        )
//    }
}
