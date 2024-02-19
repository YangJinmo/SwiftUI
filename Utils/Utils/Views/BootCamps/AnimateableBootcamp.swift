//
//  AnimateableBootcamp.swift
//  Utils
//
//  Created by Jmy on 2/19/24.
//

import SwiftUI

struct AnimateableBootcamp: View {
    @State private var animate: Bool = false

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: animate ? 60 : 0)
                .frame(width: 250, height: 250)
        }
        .onAppear {
            withAnimation(Animation.linear(duration: 2.0).repeatForever()) {
                animate.toggle()
            }
        }
    }
}

#Preview {
    AnimateableBootcamp()
}
