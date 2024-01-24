//
//  CustomPopupBootCamp.swift
//  Utils
//
//  Created by Jmy on 1/24/24.
//

import SwiftUI

struct CustomPopupBootCamp: View {
    @State private var isShow = false
    @State private var title = ""
    @State private var message = ""

    var body: some View {
        VStack {
            Button("Show Popup") {
                title = "Title"
                message = "lorem ipsum is simply dummy text of the printing and typesetting industry"

                withAnimation {
                    isShow.toggle()
                }
            }
            .padding()
        }
        .popup(isShow: $isShow, title: title, message: message)
    }
}

#Preview {
    CustomPopupBootCamp()
}

import SwiftUI

struct CustomPopupModifier: ViewModifier {
    @Binding var isShow: Bool
    var title: String
    var message: String

    func body(content: Content) -> some View {
        ZStack {
            content

            if isShow {
                VStack(spacing: 16) {
                    Text(title)
                        .font(.headline)

                    Text(message)
                        .font(.subheadline)

                    Button {
                        withAnimation {
                            isShow.toggle()
                        }
                    } label: {
                        Text("OK")
                            .buttonStyle(.plain)
                            .font(.headline)
                            .foregroundColor(.gray800)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .padding(.horizontal, 20)
                            .background(Color.accentColor)
                            .cornerRadius(8)
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(16)
                .padding(24)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.black.opacity(0.5))
                .edgesIgnoringSafeArea(.all)
            }
        }
    }
}

extension View {
    func popup(isShow: Binding<Bool>, title: String, message: String) -> some View {
        modifier(CustomPopupModifier(isShow: isShow, title: title, message: message))
    }
}
