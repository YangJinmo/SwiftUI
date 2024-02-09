//
//  AnyTransitionBootcamp.swift
//  Utils
//
//  Created by Jmy on 2/10/24.
//

import SwiftUI

struct AnyTransitionBootcamp: View {
    @State private var showRectangle: Bool = false

    var body: some View {
        VStack {
            Spacer()

            if showRectangle {
                RoundedRectangle(cornerRadius: 25)
                    .frame(width: 250, height: 350)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    // .transition(.move(edge: .leading))
                    .transition(AnyTransition.scale.animation(.easeInOut))
            }

            Spacer()

            Text("Click Me!")
                .withDefaultButtonFommatting()
                .padding(40)
                .onTapGesture {
                    withAnimation {
                        showRectangle.toggle()
                    }
                }
        }
    }
}

#Preview {
    AnyTransitionBootcamp()
}
