//
//  PresentView.swift
//  Utils
//
//  Created by Jmy on 2023/06/24.
//

import SwiftUI

struct PresentView<Content: View>: View {
    @Environment(\.dismiss) private var dismiss

    let title: String
    let content: Content
    let action: (() -> Void)?

    init(
        title: String,
        @ViewBuilder content: () -> Content,
        action: (() -> Void)? = nil
    ) {
        self.title = title
        self.action = action
        self.content = content()
    }

    private let size = 44.0

    var body: some View {
        GeometryReader { geometry in
            let width = abs(geometry.size.width - size * 2)

            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    Button {
                        dismiss()
                    } label: {
                        Image.xmark
                            .frame(width: size, height: size)
                    }

                    Text(title)
                        .frame(width: width, height: size)
                        .font(.callout)

                    Button {
                        action?()
                    } label: {
                        Image.checkmark
                            .frame(width: size, height: size)
                    }
                    .isHidden(action == nil)
                }
                .frame(width: geometry.size.width, height: size)

                Divider()
                    .frame(height: 1)
                    .background(Color.gray700)

                ZStack {
                    Color.clear

                    content
                }
            }
            .foregroundColor(.gray100)
            .background(Color.gray800)
        }
    }
}

struct PresentView_Previews: PreviewProvider {
    static var previews: some View {
        PresentView(title: "title") {
            Text("content")
        } action: {
            print("action")
        }
    }
}
