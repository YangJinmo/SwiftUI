//
//  ProgressBarView.swift
//  Utils
//
//  Created by Jmy on 11/28/24.
//

import SwiftUI

struct ProgressBarView<ShapeType: Shape>: View {
    let value: Double
    let total: Double
    let shape: ShapeType

    private var ratio: Double {
        guard total > 0 else { return 0 }
        return value / total
    }

    var body: some View {
        shape
            .fill(.secondary)
            .overlay(alignment: .leading) {
                GeometryReader { proxy in
                    shape
                        .fill(.tint)
                        .frame(width: proxy.size.width * ratio)
                }
            }
            .clipShape(shape)
    }
}

#Preview {
    VStack(spacing: 32) {
        ProgressBarView(value: 0.5, total: 1, shape: Circle())
            .tint(.red)

        ProgressBarView(value: 0.5, total: 1, shape: Ellipse())
            .tint(.orange)

        ProgressBarView(value: 0.5, total: 1, shape: Capsule())
            .tint(.yellow)

        ProgressBarView(value: 0.5, total: 1, shape: Rectangle())
            .tint(.green)

        ProgressBarView(
            value: 0.5,
            total: 1,
            shape: RoundedRectangle(
                cornerRadius: 32, style: .continuous
            )
        )
        .tint(.blue)

        if #available(iOS 16.0, *) {
            ProgressBarView(
                value: 0.5,
                total: 1,
                shape: UnevenRoundedRectangle(
                    cornerRadii: .init(
                        topLeading: 50.0,
                        bottomLeading: 10.0,
                        bottomTrailing: 50.0,
                        topTrailing: 30.0),
                    style: .continuous
                )
            )
            .tint(.indigo)
        } else {
            // Fallback on earlier versions
        }
    }
    .padding(32)
}
