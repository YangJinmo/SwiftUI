//
//  CustomCurvesBootcamp.swift
//  Utils
//
//  Created by Jmy on 2/16/24.
//

import SwiftUI

struct CustomCurvesBootcamp: View {
    var body: some View {
//        ArcSample()
        ShapeWithArc()
            .stroke(lineWidth: 5)
            .frame(width: 200, height: 200)
    }
}

#Preview {
    CustomCurvesBootcamp()
}

struct ArcSample: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.midX, y: rect.midY))
            path.addArc(
                center: CGPoint(x: rect.midX, y: rect.midY),
                radius: rect.height / 2,
//                startAngle: Angle(degrees: 0),
//                endAngle: Angle(degrees: 360),
                startAngle: Angle(degrees: -20),
                endAngle: Angle(degrees: 20),
                clockwise: true
            )
        }
    }
}

struct ShapeWithArc: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            // top left
            path.move(to: CGPoint(x: rect.minX, y: rect.minY))

            // top right
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))

            // mid right
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))

            // bottom
            // path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
            path.addArc(
                center: CGPoint(x: rect.midX, y: rect.midY - 65),
                radius: rect.height / 2,
                startAngle: Angle(degrees: 0),
                endAngle: Angle(degrees: 180),
                clockwise: false,
                transform: .identity
            )

            // mid left
            path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
        }
    }
}
