//
//  ListView.swift
//  Utils
//
//  Created by Jmy on 2023/07/08.
//

import SwiftUI

struct ListView: View {
    @Binding var items: [String]
    let itemTapped: (String) -> Void

    var body: some View {
        if items.isEmpty {
            Color.clear
        } else {
            List(items, id: \.self) { item in
                Button {
                    itemTapped(item)
                } label: {
                    Text(item)
                }
                .font(.subheadline2)
                .foregroundColor(.gray300)
                .listRowBackground(Color.gray800)
            }
            .listStyle(.plain)
            .backgroundViewModifier()
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(
            items: Binding<[String]>.init(
                get: { ["Apple", "Samsung"] },
                set: { _ in }
            ),
            itemTapped: { item in
                print("Selected item: \(item)")
            }
        )
    }
}
