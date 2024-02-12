//
//  MatchedGeometryEffectBootcamp.swift
//  Utils
//
//  Created by Jmy on 2/12/24.
//

import SwiftUI

struct MatchedGeometryEffectBootcamp: View {
    @State private var isClicked: Bool = false

    var body: some View {
        VStack {
            if !isClicked {
                RoundedRectangle(cornerRadius: 25.0)
                    .frame(width: 100, height: 100)
            }

            Spacer()

            if isClicked {
                RoundedRectangle(cornerRadius: 25.0)
                    .frame(width: 100, height: 100)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.red)
        .onTapGesture {
            withAnimation(.easeInOut) {
                isClicked.toggle()
            }
        }
    }
}

#Preview {
    MatchedGeometryEffectBootcamp()
}
