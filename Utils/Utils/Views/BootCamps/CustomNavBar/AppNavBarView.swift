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

        NavigationView {
            CustomNavBarContainerView {
                ZStack {
                    Color.orange.ignoresSafeArea()

                    NavigationLink {
                        Text("Destination")
                    } label: {
                        Text("Navigate")
                    }
                }
            }
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
