//
//  HorizontalList.swift
//  Utils
//
//  Created by Jmy on 2023/09/30.
//

import SwiftUI

struct HorizontalList: View {
    let items = Array(1 ... 10)

    var body: some View {
        GeometryReader { proxy in
            List(items, id: \.self) {
                RowDataView(item: $0)
                    .frame(
                        width: proxy.size.height,
                        height: proxy.size.width
                    )
                    .rotationEffect(.init(degrees: 90))
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.gray400)
            }
            .listStyle(.plain)
            .frame(height: proxy.size.height)
            .rotationEffect(.init(degrees: -90))
        }
        .ignoresSafeArea()
    }
}

#Preview {
    HorizontalList()
}
