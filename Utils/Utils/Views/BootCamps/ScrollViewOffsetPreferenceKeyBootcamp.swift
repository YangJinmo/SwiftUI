//
//  ScrollViewOffsetPreferenceKeyBootcamp.swift
//  Utils
//
//  Created by Jmy on 3/3/24.
//

import SwiftUI

struct ScrollViewOffsetPreferenceKeyBootcamp: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Text("Hello, world")

                    ForEach(0 ..< 30) { _ in
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.red.opacity(0.3))
                            .frame(width: 300, height: 200)
                    }
                }
            }
            .navigationTitle("Nav Title Here")
        }
    }
}

#Preview {
    ScrollViewOffsetPreferenceKeyBootcamp()
}
