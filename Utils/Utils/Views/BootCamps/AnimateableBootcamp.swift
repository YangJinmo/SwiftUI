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
//            RoundedRectangle(cornerRadius: animate ? 60 : 0)
            RectangleWithSingleCornerAnimation(cornerRadius: animate ? 60 : 0)
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

struct RectangleWithSingleCornerAnimation: Shape {
    var cornerRadius: CGFloat
    var animatableData: CGFloat {
        get {
            cornerRadius
        }
        set {
            cornerRadius = newValue
        }
    }

    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: .zero)
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - cornerRadius))

            path.addArc(
                center: CGPoint(x: rect.maxX - cornerRadius, y: rect.maxY - cornerRadius),
                radius: cornerRadius,
                startAngle: Angle(degrees: 0),
                endAngle: Angle(degrees: 360),
                clockwise: false
            )

            path.addLine(to: CGPoint(x: rect.maxX - cornerRadius, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        }
    }
}
