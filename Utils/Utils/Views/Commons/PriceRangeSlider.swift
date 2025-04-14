//
//  PriceRangeSlider.swift
//  Utils
//
//  Created by Jmy on 3/20/25.
//

import SwiftUI

struct PriceRangeSlider: View {
    @Binding var priceRange: ClosedRange<Int32>
    let totalRange: ClosedRange<Int32>
    let step: Int32 = 1000
    @State private var isDragging = false
    var onEditingChanged: (Bool) -> Void

    private var lowerBoundPercentage: CGFloat {
        CGFloat(priceRange.lowerBound - totalRange.lowerBound) / CGFloat(totalRange.upperBound - totalRange.lowerBound)
    }

    private var upperBoundPercentage: CGFloat {
        CGFloat(priceRange.upperBound - totalRange.lowerBound) / CGFloat(totalRange.upperBound - totalRange.lowerBound)
    }

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
                    .offset(x: lowerBoundPercentage * geometry.size.width)
                    .frame(width: (upperBoundPercentage - lowerBoundPercentage) * geometry.size.width)

                // 최소값 thumb
                Circle()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.blue)
                    .shadow(radius: 3)
                    .offset(x: lowerBoundPercentage * geometry.size.width - 12)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                isDragging = true
                                onEditingChanged(true)
                                let newValue = max(Int32((value.location.x / geometry.size.width) * CGFloat(totalRange.upperBound - totalRange.lowerBound)) + totalRange.lowerBound, 0)
                                let steppedValue = (newValue / step) * step
                                let newLowerBound = max(min(steppedValue, totalRange.upperBound - step), totalRange.lowerBound)
                                priceRange = newLowerBound ... max(priceRange.upperBound, newLowerBound + step)
                            }
                            .onEnded { _ in
                                isDragging = false
                                onEditingChanged(false)
                            }
                    )

                // 최대값 thumb
                Circle()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.blue)
                    .shadow(radius: 3)
                    .offset(x: upperBoundPercentage * geometry.size.width - 12)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                isDragging = true
                                onEditingChanged(true)
                                let newValue = max(Int32((value.location.x / geometry.size.width) * CGFloat(totalRange.upperBound - totalRange.lowerBound)) + totalRange.lowerBound, 0)
                                let steppedValue = (newValue / step) * step
                                let newUpperBound = max(min(steppedValue, totalRange.upperBound), max(priceRange.lowerBound + step, step))
                                priceRange = min(priceRange.lowerBound, newUpperBound - step) ... newUpperBound
                            }
                            .onEnded { _ in
                                isDragging = false
                                onEditingChanged(false)
                            }
                    )
            }
        }
        .frame(height: 24)
    }
}

struct PriceRangeSliderPreview: View {
    @State private var priceRange: ClosedRange<Int32> = 3000 ... 92000
    let totalRange: ClosedRange<Int32> = 0 ... 100000
    @State private var isEditing = false

    var body: some View {
        VStack {
            PriceRangeSlider(priceRange: $priceRange, totalRange: totalRange) { editing in
                isEditing = editing
                if !editing {
                    print("가격 범위 선택 완료: \(priceRange)")
                }
            }
            .padding()

            Text("선택된 가격 범위: \(priceRange.lowerBound) - \(priceRange.upperBound)")
            
            Text(isEditing ? "조정 중..." : "조정 완료")
        }
    }
}

#Preview {
    PriceRangeSliderPreview()
}
