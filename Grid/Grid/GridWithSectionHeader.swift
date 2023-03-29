//
//  GridWithSectionHeader.swift
//  Grid
//
//  Created by Jmy on 2023/03/29.
//

import SwiftUI

struct GridWithSectionHeader: View {
    var header: some View {
        LazyVGrid(
            columns: Array(repeating: GridItem(.fixed(200), spacing: 0, alignment: .center), count: 9),
            spacing: 16
        ) {
            ForEach(1 ..< 10) {
                Text("Header \($0)")
            }
        }
        .padding(.vertical)
        .background(Color.blue)
        .foregroundColor(.white)
    }

    var body: some View {
        ScrollView(.horizontal) {
            ScrollView(.vertical) {
                Text("Other content")
                    .frame(maxWidth: .infinity, minHeight: 100)
                    .background(Color.yellow)

                LazyVGrid(
                    columns: Array(repeating: GridItem(.fixed(200), spacing: 0, alignment: .center), count: 9),
                    spacing: 16,
                    pinnedViews: [.sectionHeaders]
                ) {
                    Section(header: header) {
                        ForEach(1 ..< 500) {
                            Text("Cell #\($0)")
                        }
                    }
                }

                Text("Other content")
                    .frame(maxWidth: .infinity, minHeight: 100)
                    .background(Color.yellow)
            }
        }
        .ignoresSafeArea(.all, edges: .bottom)
    }
}

struct GridWithSectionHeader_Previews: PreviewProvider {
    static var previews: some View {
        GridWithSectionHeader()
    }
}
