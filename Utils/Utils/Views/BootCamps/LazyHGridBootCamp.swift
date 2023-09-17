//
//  LazyHGridBootCamp.swift
//  Utils
//
//  Created by Jmy on 2023/09/15.
//

import SwiftUI

struct LazyHGridBootCamp: View {
    let items = Array(1 ... 100).map { $0.description }
    let rows = [
        GridItem(.fixed(40)),
        GridItem(.flexible(maximum: 40)),
        GridItem(.adaptive(minimum: 40)),
    ]

    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: rows, spacing: 20) {
                ForEach(items, id: \.self) { item in
                    Text(item)
                        .foregroundColor(.white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(Color.accentColor)
                        .clipShape(Capsule())
                }
            }
            .padding(.horizontal)
        }
    }
}

struct LazyHGridBootCamp_Previews: PreviewProvider {
    static var previews: some View {
        LazyHGridBootCamp()
    }
}
