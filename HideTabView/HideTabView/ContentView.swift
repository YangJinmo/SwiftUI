//
//  ContentView.swift
//  HideTabView
//
//  Created by Jmy on 2023/07/05.
//

import SwiftUI

struct TabBarView: View {
    enum Tab: Int {
        case first, second
    }

    @State private var selectedTab = Tab.first

    var body: some View {
        VStack(spacing: 0) {
            if selectedTab == .first {
                FirstView()
            } else if selectedTab == .second {
                NavigationView {
                    VStack(spacing: 0) {
                        SecondView()
                        tabBarView
                    }
                }
            }

            if selectedTab != .second {
                tabBarView
            }
        }
    }

    var tabBarView: some View {
        VStack(spacing: 0) {
            Divider()

            HStack(spacing: 20) {
                tabBarItem(.first, title: "First", icon: "hare", selectedIcon: "hare.fill")
                tabBarItem(.second, title: "Second", icon: "tortoise", selectedIcon: "tortoise.fill")
            }
            .padding(.top, 8)
        }
        .frame(height: 50)
        .background(Color.white.edgesIgnoringSafeArea(.all))
    }

    func tabBarItem(_ tab: Tab, title: String, icon: String, selectedIcon: String) -> some View {
        ZStack(alignment: .topTrailing) {
            VStack(spacing: 3) {
                VStack {
                    Image(systemName: selectedTab == tab ? selectedIcon : icon)
                        .font(.system(size: 24))
                        .foregroundColor(selectedTab == tab ? .primary : .black)
                }
                .frame(width: 55, height: 28)

                Text(title)
                    .font(.system(size: 11))
                    .foregroundColor(selectedTab == tab ? .primary : .black)
            }
        }
        .frame(width: 65, height: 42)
        .onTapGesture {
            selectedTab = tab
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}

struct FirstView: View {
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: ThirdView()) {
                    Text("Tap to navigate Third View\nwith tabBar")
                        .font(.headline)
                }
            }
            .navigationTitle("First title")
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
            .background(Color.yellow) //.background(Color.yellow.edgesIgnoringSafeArea(.bottom))
        }
    }
}

struct SecondView: View {
    var body: some View {
        VStack {
            NavigationLink(destination: ThirdView()) {
                Text("Tap to navigate Third View\nwithout tabBar")
                    .font(.headline)
            }
        }
        .navigationTitle("Second title")
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
        .background(Color.orange) //.background(Color.orange.edgesIgnoringSafeArea(.bottom))
    }
}

struct ThirdView: View {
    var body: some View {
        VStack {
            Text("Third View")
                .font(.headline)
        }
        .navigationTitle("Third title")
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
        .background(Color.green) //.background(Color.green.edgesIgnoringSafeArea(.bottom))
    }
}
