//
//  PercentageRangeSlider.swift
//  Utils
//
//  Created by Jmy on 3/20/25.
//

import SwiftUI

struct PercentageRangeSlider: View {
    @Binding var minValue: CGFloat
    @Binding var maxValue: CGFloat
    let totalRange: ClosedRange<CGFloat>

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                // 배경 트랙
                Capsule()
                    .foregroundColor(.gray.opacity(0.2))
                    .frame(height: 4)

                // 활성 범위 표시
                Capsule()
                    .foregroundColor(.blue)
                    .frame(height: 4)
                    .offset(x: minValue * geometry.size.width)
                    .frame(width: (maxValue - minValue) * geometry.size.width)

                // 최소값 thumb
                Circle()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.white)
                    .shadow(radius: 3)
                    .offset(x: minValue * geometry.size.width - 12)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                let newValue = (value.location.x / geometry.size.width)
                                    .clamped(to: 0 ... maxValue)
                                minValue = newValue
                            }
                    )

                // 최대값 thumb
                Circle()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.white)
                    .shadow(radius: 3)
                    .offset(x: maxValue * geometry.size.width - 12)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                let newValue = (value.location.x / geometry.size.width)
                                    .clamped(to: minValue ... 1)
                                maxValue = newValue
                            }
                    )
            }
        }
        .frame(height: 24)
    }
}

struct RangeSliderPreview: View {
    @State private var minVal: CGFloat = 0.2
    @State private var maxVal: CGFloat = 0.8

    var body: some View {
        VStack {
            PercentageRangeSlider(minValue: $minVal,
                                  maxValue: $maxVal,
                                  totalRange: 0 ... 1)
                .padding()

            Text("범위: \(Int(minVal * 100))% - \(Int(maxVal * 100))%")
        }
    }
}

#Preview {
    RangeSliderPreview()
}

extension Comparable {
    func clamped(to range: ClosedRange<Self>) -> Self {
        if self < range.lowerBound {
            return range.lowerBound
        } else if self > range.upperBound {
            return range.upperBound
        } else {
            return self
        }
    }
}
