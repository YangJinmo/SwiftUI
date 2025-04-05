//
//  LazyVGridBootCamp.swift
//  Utils
//
//  Created by Jmy on 12/5/24.
//

import SwiftUI

struct LazyVGridBootCamp: View {
    let items = Array(1 ... 100).map { $0.description }
    let columns = [GridItem(.adaptive(minimum: 56))]

    var body: some View {
        ScrollView(.vertical) {
            LazyVGrid(columns: columns, spacing: 20) {
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

#Preview {
    LazyVGridBootCamp()
}
