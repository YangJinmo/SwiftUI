//
//  ExpandableText.swift
//  Utils
//
//  Created by Jmy on 10/29/24.
//

import SwiftUI

struct ExpandableText: View {
    @State private var expanded: Bool = false
    @State private var truncated: Bool = false
    @State private var shrinkText: String

    private var text: String
    let font: UIFont
    let lineLimit: Int

    init(_ text: String, lineLimit: Int, font: UIFont = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body)) {
        self.text = text
        _shrinkText = State(wrappedValue: text)
        self.lineLimit = lineLimit
        self.font = font
    }

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Group {
                Text(expanded ? text : shrinkText)
                    + Text(dot)
                    + Text(more).foregroundColor(.white)
            }
            .lineLimit(expanded ? nil : lineLimit)
            .background(
                // Render the limited text and measure its size
                Text(text)
                    .lineLimit(lineLimit)
                    .background(
                        GeometryReader { visibleTextGeometry in
                            Color.clear.onAppear {
                                let size = CGSize(width: visibleTextGeometry.size.width, height: .greatestFiniteMagnitude)
                                let attributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: font]

                                /// Binary search until mid == low && mid == high
                                var low = 0
                                var heigh = shrinkText.count
                                var mid = heigh /// start from top so that if text contain we does not need to loop
                                ///
                                while (heigh - low) > 1 {
                                    let attributedText = NSAttributedString(string: shrinkText + dot + more, attributes: attributes)
                                    let boundingRect = attributedText.boundingRect(with: size, options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil)
                                    if boundingRect.size.height > visibleTextGeometry.size.height {
                                        truncated = true
                                        heigh = mid
                                        mid = (heigh + low) / 2

                                    } else {
                                        if mid == text.count {
                                            break
                                        } else {
                                            low = mid
                                            mid = (low + heigh) / 2
                                        }
                                    }
                                    shrinkText = String(text.prefix(mid))
                                }

                                if truncated {
                                    shrinkText = String(shrinkText.prefix(shrinkText.count - 2)) // -2 extra as highlighted text is bold
                                }
                            }
                        }
                    )
                    .hidden() // Hide the background
            )
            .font(Font(font))
            .foregroundColor(.gray)
        }
        .onTapGesture {
            if truncated {
                withAnimation(.easeInOut(duration: 0.25)) {
                    expanded.toggle()
                }
            }
        }
    }

    private var dot: String {
        if !truncated {
            return ""
        } else {
            return expanded ? "" : " ... "
        }
    }

    private var more: String {
        if !truncated {
            return ""
        } else {
            return expanded ? "" : "more"
        }
    }
}
