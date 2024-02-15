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

struct RegularRhombus: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.midX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        }
    }
}

struct Rhombus: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            let horizontalOffset: CGFloat = rect.width * 0.2
            path.move(to: CGPoint(x: rect.midX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX - horizontalOffset, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX + horizontalOffset, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        }
    }
}

struct Trapezoid: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            let horizontalOffset: CGFloat = rect.width * 0.2
            path.move(to: CGPoint(x: rect.minX + horizontalOffset, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX - horizontalOffset, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        }
    }
}

struct CustomShapeBootcamp: View {
    var body: some View {
        ZStack {
//            Rectangle()
//                .trim(from: 0, to: 0.5)
//                .frame(width: 300, height: 300)

//            Triangle()
//                .stroke(style: StrokeStyle(lineWidth: 5, lineCap: .round, dash: [10]))
//                .foregroundColor(.blue)
//                .frame(width: 300, height: 300)

//            RegularRhombus()
//                .frame(width: 300, height: 300)

//            Rhombus()
//                .frame(width: 300, height: 300)

            Trapezoid()
                .fill(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .leading, endPoint: .trailing))
                .frame(width: 300, height: 300)

//            Image("")
//                .resizable()
//                .scaledToFill()
//                .frame(width: 300, height: 300)
//                .clipShape(
//                    // Circle()
//                    Triangle()
//                        .rotation(Angle(degrees: 180))
//                )
        }
    }
}

#Preview {
    CustomShapeBootcamp()
}
