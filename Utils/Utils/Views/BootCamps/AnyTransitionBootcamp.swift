//
//  AnyTransitionBootcamp.swift
//  Utils
//
//  Created by Jmy on 2/10/24.
//

import SwiftUI

struct RotationViewModifier: ViewModifier {
    let rotation: Double

    func body(content: Content) -> some View {
        content
            .rotationEffect(Angle(degrees: rotation))
            .offset(
                x: rotation != 0 ? UIScreen.main.bounds.width : 0,
                y: rotation != 0 ? UIScreen.main.bounds.height : 0
            )
    }
}

extension AnyTransition {
    static var rotating: AnyTransition {
        return .modifier(
            active: RotationViewModifier(rotation: 180),
            identity: RotationViewModifier(rotation: 0)
        )
    }

    static func rotating(rotation: Double) -> AnyTransition {
        return .modifier(
            active: RotationViewModifier(rotation: rotation),
            identity: RotationViewModifier(rotation: 0)
        )
    }

    static var rotateOn: AnyTransition {
        return .asymmetric(
            insertion: .rotating,
            removal: .move(edge: .leading)
        )
    }
}

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
                    // .transition(AnyTransition.scale.animation(.easeInOut))
                    // .transition(AnyTransition.rotating.animation(.easeInOut))
                    // .transition(.rotating(rotation: 1080))
                    .transition(.rotateOn)
            }

            Spacer()

            Text("Click Me!")
                .withDefaultButtonFommatting()
                .padding(40)
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        showRectangle.toggle()
                    }
                }
        }
    }
}

#Preview {
    AnyTransitionBootcamp()
}
