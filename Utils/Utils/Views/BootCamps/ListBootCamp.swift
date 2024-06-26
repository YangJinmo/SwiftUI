//
//  ListBootCamp.swift
//  Utils
//
//  Created by Jmy on 2023/09/18.
//

import SwiftUI

struct ListBootCamp: View {
    let items = Array(1 ... 10)

    var body: some View {
        GeometryReader { proxy in
            List(items, id: \.self) {
                RowDataView(item: $0)
                    .frame(
                        width: proxy.size.width,
                        height: proxy.size.height
                    )
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.gray400)
            }
            .listStyle(.plain)
        }
        .ignoresSafeArea()
    }
}

struct ListBootCamp2: View {
    let items = (1 ... 10).map { $0 }

    var body: some View {
        ScrollView(.horizontal) {
            List {
                ForEach(items, id: \.self) { item in
                    Text("Item \(item)")
                        .frame(width: 200, height: 200)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
            .frame(width: UIScreen.main.bounds.width * CGFloat(items.count))
        }
        .frame(height: UIScreen.main.bounds.height)
    }
}

struct RowDataView: View {
    let item: Int

    var body: some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(Color.random())
            .overlay(
                Text("\(item)")
            )
    }
}

#Preview {
    Group {
        ListBootCamp()
        ListBootCamp2()
    }
}
