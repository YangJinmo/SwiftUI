//
//  VerticalPageTabView.swift
//  Utils
//
//  Created by Jmy on 2023/09/05.
//

import SwiftUI

struct VerticalPageTabView: View {
    var body: some View {
        TabView {
            Text("First")
                .navigationTitle("First Title")

            Text("Second")
                .navigationTitle("Second Title")

            List(1 ..< 50) { i in
                Text("Row \(i)")
            }
            .navigationTitle("Third Title")
        }
        // .tabViewStyle(.verticalPage)
        // Xcode 15 beta 1
    }
}

#Preview {
    VerticalPageTabView()
}
