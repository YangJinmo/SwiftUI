//
//  CustomCurvesBootcamp.swift
//  Utils
//
//  Created by Jmy on 2/16/24.
//

import SwiftUI

struct CustomCurvesBootcamp: View {
    var body: some View {
        ArcSample()
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
                startAngle: Angle(degrees: 0),
                endAngle: Angle(degrees: 360),
                clockwise: true
            )
        }
    }
}
