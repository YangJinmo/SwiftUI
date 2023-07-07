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
        GeometryReader { proxy in
            let _ = print(proxy.size.height)

            CollectionViewWrapper(items: pages, currentPage: $currentPage) { page in
                page
                    .ignoresSafeArea()
                    .frame(
                        width: proxy.size.width,
                        height: proxy.size.height
                    )
            }
        }
        .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
