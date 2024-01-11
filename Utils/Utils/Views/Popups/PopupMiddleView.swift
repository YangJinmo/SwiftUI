//
//  PopupMiddleView.swift
//  Utils
//
//  Created by Jmy on 2024/01/11.
//

import SwiftUI

struct PopupMiddleView: View {
    let alignment: HorizontalAlignment = .center
    let title: String?
    let content: String?
    let cancelTitle: String?
    let confirmTitle: String?
    let buttonTapped: ((TwoOptions) -> Void)?

    var body: some View {
        VStack(alignment: alignment, spacing: 16) {
            if let title = title {
                Text(title)
                    .foregroundColor(.gray100)
                    .font(.headline)
            }

            if let content = content {
                Text(content)
                    .foregroundColor(.gray100)
                    .font(.subheadline)
                    .multilineTextAlignment(.leading)
            }

            HStack(spacing: 16) {
                if let cancelTitle = cancelTitle {
                    Button {
                        buttonTapped?(.cancel)
                    } label: {
                        Text(cancelTitle)
                            .buttonStyle(.plain)
                            .font(.subheadline.bold())
                            .foregroundColor(.gray300)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .padding(.horizontal, 20)
                            .background(Color.gray500)
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .strokeBorder(Color.gray100.opacity(0.2), lineWidth: 1)
                            )
                    }
                }

                Button {
                    buttonTapped?(.confirm)
                } label: {
                    Text(confirmTitle ?? "확인")
                        .buttonStyle(.plain)
                        .font(.subheadline.bold())
                        .foregroundColor(.gray800)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .padding(.horizontal, 20)
                        .background(Color.accentColor)
                        .cornerRadius(8)
                }
            }
        }
        .padding(24)
        .background(Color.gray700.cornerRadius(20))
        .shadowedStyle()
        .padding(32)
    }
}

struct PopupMiddleView_Previews: PreviewProvider {
    static var previews: some View {
        PopupMiddleView(
            title: "제목",
            content: "내용",
            cancelTitle: nil,
            confirmTitle: nil
        ) { action in
            print("\(action)")
        }
    }
}

enum TwoOptions {
    case confirm
    case cancel
}
