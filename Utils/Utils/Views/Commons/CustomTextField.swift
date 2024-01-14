//
//  CustomTextField.swift
//  Utils
//
//  Created by Jmy on 2023/06/14.
//

import SwiftUI

struct CustomTextField: View {
    let placeholder: String
    @Binding var text: String

    @State private var width = CGFloat.zero
    @State private var labelWidth = CGFloat.zero

    var body: some View {
        TextField(placeholder, text: $text)
            .foregroundColor(.gray)
            .font(.system(size: 20))
            .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))
            .background {
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .trim(from: 0, to: 0.545)
                        .stroke(.gray, lineWidth: 1)

                    RoundedRectangle(cornerRadius: 5)
                        .trim(from: 0.560 + (0.44 * (labelWidth / width)), to: 1)
                        .stroke(.gray, lineWidth: 1)

                    Text(placeholder)
                        .foregroundColor(.gray)
                        .overlay(
                            GeometryReader { geo in
                                Color.clear
                                    .onAppear {
                                        labelWidth = geo.size.width
                                    }
                            }
                        )
                        .padding(2)
                        .font(.caption)
                        .frame(
                            maxWidth: .infinity,
                            maxHeight: .infinity,
                            alignment: .topLeading
                        )
                        .offset(x: 20, y: -10)
                }
            }
            .overlay(
                GeometryReader { geo in
                    Color.clear
                        .onAppear {
                            width = geo.size.width
                        }
                }
            )
            .onChange(of: width) { _ in
                print("Width: ", width)
            }
            .onChange(of: labelWidth) { _ in
                print("labelWidth: ", labelWidth)
            }
    }
}

#Preview {
        CustomTextField(placeholder: "가나다라", text: .constant(""))
            .padding(16)
    
}
