//
//  CustomShapeBootcamp.swift
//  Utils
//
//  Created by Jmy on 2/13/24.
//

import SwiftUI

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.midX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        }
    }
}

struct CustomShapeBootcamp: View {
    var body: some View {
        ZStack {
//            Rectangle()
//                .trim(from: 0, to: 0.5)
//                .frame(width: 300, height: 300)

            Triangle()
                .stroke(style: StrokeStyle(lineWidth: 5, lineCap: .round, dash: [10]))
                .foregroundColor(.blue)
                .frame(width: 300, height: 300)
        }
    }
}

#Preview {
    CustomShapeBootcamp()
}
