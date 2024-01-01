//
//  LongText.swift
//  Utils
//
//  Created by Jmy on 1/1/24.
//

import SwiftUI

struct LongText: View {
    private var text: String

    /* Indicates whether the user want to see all the text or not. */
    @Binding var isExpanded: Bool

    /* Indicates whether the text has been truncated in its display. */
    @Binding var isTruncated: Bool

    var lineLimit = 1

    init(_ text: String, isExpanded: Binding<Bool>, isTruncated: Binding<Bool>) {
        self.text = text
        _isExpanded = isExpanded
        _isTruncated = isTruncated
    }

    var body: some View {
        HStack(spacing: 8) {
            // Render the real text (which might or might not be limited)
            Text(text)
                .lineLimit(isExpanded ? nil : lineLimit)
                .background(
                    // Render the limited text and measure its size
                    Text(text)
                        .lineLimit(lineLimit)
                        .background(
                            GeometryReader { displayedGeometry in

                                // Create a ZStack with unbounded height to allow the inner Text as much
                                // height as it likes, but no extra width.
                                ZStack {
                                    // Render the text without restrictions and measure its size
                                    Text(text)
                                        .background(
                                            GeometryReader { fullGeometry in

                                                // And compare the two
                                                Color.clear.onAppear {
                                                    isTruncated = fullGeometry.size.height > displayedGeometry.size.height

//                                                    text.description.log("text height: ")
//                                                    isExpanded.description.log("isExpanded height: ")
//                                                    isTruncated.description.log("isTruncated height: ")
//
//                                                    fullGeometry.size.height.description.log("fullGeometry.size.height: ")
//                                                    displayedGeometry.size.height.description.log("displayedGeometry.size.height: ")
                                                }
                                            })
                                }
                                .frame(height: .greatestFiniteMagnitude)
                            })
                        .hidden() // Hide the background
                )

            if isTruncated {
                showMoreButton
            }
        }
        .onTapGesture {
            if isTruncated {
                withAnimation {
                    isExpanded.toggle()
                }
            }
        }
        .font(.footnote)
        .foregroundColor(Color.gray100)
    }

    var showMoreButton: some View {
        Text(isExpanded ? "" : "더보기")
            .foregroundColor(Color.gray300)
    }
}
