//
//  GaugeProgressStyle.swift
//  Utils
//
//  Created by Jmy on 2023/06/04.
//

import SwiftUI

struct GaugeProgressStyle: ProgressViewStyle {
    var strokeColor = Color.blue
    var strokeWidth = 25.0

    func makeBody(configuration: Configuration) -> some View {
        let fractionCompleted = configuration.fractionCompleted ?? 0

        return ZStack {
            Circle()
                .trim(from: 0, to: fractionCompleted)
                .stroke(strokeColor, style: StrokeStyle(lineWidth: strokeWidth, lineCap: .round))
                .rotationEffect(.degrees(-90))
        }
    }
}

struct GaugeProgressStyleView: View {
    @State private var progress = 0.2

    var body: some View {
        ProgressView(value: progress, total: 1.0)
            .progressViewStyle(
                GaugeProgressStyle(
                    strokeColor: .orange,
                    strokeWidth: 25
                )
            )
            .frame(width: 200, height: 200)
            .contentShape(Rectangle())
            .onTapGesture {
                if progress < 1.0 {
                    withAnimation {
                        progress += 0.2
                    }
                }
            }
    }
}

#Preview {
    GaugeProgressStyleView()
}
