//
//  ContentView.swift
//  CollectionViewSwiftUI
//
//  Created by Jmy on 2023/07/07.
//

import SwiftUI

struct ContentView: View {
    let pages: [Color] = [.blue, .green, .yellow]

    @State var currentPage: Int = 0

    var body: some View {
        ZStack {
            CollectionViewWrapper(items: pages, currentPage: $currentPage) { page in
                Rectangle()
                    .foregroundColor(page)
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
