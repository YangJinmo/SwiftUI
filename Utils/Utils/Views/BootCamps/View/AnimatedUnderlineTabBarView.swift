//
//  AnimatedUnderlineTabBarView.swift
//  Utils
//
//  Created by Jmy on 12/10/24.
//

import SwiftUI

struct AnimatedUnderlineTabBarView: View {
    @State private var currentTab: Int = 0

    var body: some View {
        ZStack(alignment: .top) {
            TabView(selection: $currentTab) {
                firstView.tag(0)
                secondView.tag(1)
                thirdView.tag(2)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .edgesIgnoringSafeArea(.all)

            TabBarView(currentTab: $currentTab)
        }
        .background(Color.white)
    }

    private var firstView: some View {
        Color.yellow.opacity(0.2).edgesIgnoringSafeArea(.all)
    }

    private var secondView: some View {
        Color.red.opacity(0.2).edgesIgnoringSafeArea(.all)
    }

    private var thirdView: some View {
        Color.green.opacity(0.2).edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    AnimatedUnderlineTabBarView()
}

struct TabBarView: View {
    @Binding var currentTab: Int
    @Namespace var namespace

    var tabBarOptions: [String] = ["Hello World", "This is", "Somthing cool that I'm doing"]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(Array(zip(tabBarOptions.indices, tabBarOptions)), id: \.0) { index, name in
                    TabBarItemView(
                        currentTab: $currentTab,
                        namespace: namespace.self,
                        tabBarItemName: name,
                        tab: index
                    )
                }
                Spacer()
            }
            .padding(.horizontal)
        }
        .background(Color.white)
        .frame(height: 80)
        .edgesIgnoringSafeArea(.all)
    }
}

private struct TabBarItemView: View {
    @Binding var currentTab: Int
    let namespace: Namespace.ID

    var tabBarItemName: String
    var tab: Int

    var body: some View {
        Button {
            currentTab = tab
        } label: {
            VStack {
                Spacer()

                Text(tabBarItemName)
                    .foregroundColor(.black)

                if currentTab == tab {
                    Color.black
                        .frame(height: 2)
                        .matchedGeometryEffect(
                            id: "underline",
                            in: namespace,
                            properties: .frame
                        )
                } else {
                    Color.clear.frame(height: 2)
                }
            }
            .animation(.spring(), value: currentTab)
        }
        .buttonStyle(.plain)
    }
}
