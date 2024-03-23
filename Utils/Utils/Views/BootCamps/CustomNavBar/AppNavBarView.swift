//
//  AppNavBarView.swift
//  Utils
//
//  Created by Jmy on 3/17/24.
//

import SwiftUI

struct AppNavBarView: View {
    var body: some View {
        // defaultNavView

        // NavigationView {
        // CustomNavBarContainerView {
        CustomNavView {
            ZStack {
                Color.orange.ignoresSafeArea()

                CustomNavLink(destination:
                    Text("Destination")
                        .customNavigationTitle("Second Screen")
                        .customNavigationSubtitle("Subtitle should be showing!!!!")
                ) {
                    Text("Navigate")
                }

//                NavigationLink {
//                    Text("Destination")
//                } label: {
//                    Text("Navigate")
//                }
            }
            .customNavBarItems(title: "New Title!", subtitle: "Subtitle!", backButtonHidden: false)
            // .customNavigationTitle("Custom Title!")
            // .customNavigationSubtitle("Subtitle")
            // .customNavigationBackButtonHidden(true)
        }
    }
}

#Preview {
    AppNavBarView()
}

extension AppNavBarView {
    private var defaultNavView: some View {
        NavigationView {
            ZStack {
                Color.green.ignoresSafeArea()

                NavigationLink {
                    Text("Destination")
                        .navigationTitle("Title 2")
                        .navigationBarBackButtonHidden(false)
                } label: {
                    Text("Navigate")
                }
            }
            .navigationTitle("Navigation Title")
        }
    }
}
