//
//  FontWithLineHeightViewModifier.swift
//  Utils
//
//  Created by Jmy on 2023/06/18.
//

import SwiftUI

struct FontWithLineHeightViewModifier: ViewModifier {
    let font: UIFont
    let lineHeight: CGFloat

    func body(content: Content) -> some View {
        content
            .font(Font(font))
            .lineSpacing(lineHeight - font.lineHeight)
            .padding(.vertical, (lineHeight - font.lineHeight) / 2)
    }
}

extension View {
    func fontWithLineHeight(font: UIFont, lineHeight: CGFloat) -> some View {
        ModifiedContent(content: self, modifier: FontWithLineHeightViewModifier(font: font, lineHeight: lineHeight))
    }
}
