//
//  GeometryPreferenceKeyBootcamp.swift
//  Utils
//
//  Created by Jmy on 3/1/24.
//

import SwiftUI

struct GeometryPreferenceKeyBootcamp: View {
    var body: some View {
        VStack {
            Text("Hello, World!")
                .background(Color.blue)

            Spacer()

            HStack {
                Rectangle()

                GeometryReader { geo in
                    Rectangle()
                        .overlay(
                            Text("\(geo.size.width)")
                                .foregroundColor(.white)
                        )
                }

                Rectangle()
            }
            .frame(height: 55)
        }
    }
}

#Preview {
    GeometryPreferenceKeyBootcamp()
}
