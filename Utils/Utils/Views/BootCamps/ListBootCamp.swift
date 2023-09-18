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

struct ListBootCamp_Previews: PreviewProvider {
    static var previews: some View {
        ListBootCamp()
        ListBootCamp2()
        HorizontalList()
    }
}
