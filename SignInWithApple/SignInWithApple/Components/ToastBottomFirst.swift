//
//  ToastBottomFirst.swift
//  SignInWithApple
//
//  Created by Jmy on 2023/05/22.
//

import SwiftUI

struct ToastBottomFirst: View {
    @Binding var isShowing: Bool

    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            Image("fitness")
                .frame(width: 48, height: 48)
                .cornerRadius(8)

            VStack(alignment: .leading, spacing: 8) {
                Text("Log In to Fitness First")
                    .font(.system(size: 16, weight: .bold))
                Text("To continue training, you need to Log in or Sign up")
                    .font(.system(size: 16))
                    .opacity(0.8)
            }

            Spacer()

            VStack(alignment: .leading, spacing: 4) {
                Button {
                    self.isShowing = false
                } label: {
                    Text("Log in")
                        .frame(width: 112, height: 40)
                }
                .customButtonStyle(foreground: .white, background: Color(hex: "87B9FF"))
                .cornerRadius(8)

                Button {
                    self.isShowing = false
                } label: {
                    Text("Sign up")
                        .frame(width: 112, height: 40)
                }
                .customButtonStyle()
            }
        }
        .foregroundColor(.black)
        .padding(EdgeInsets(top: 24, leading: 16, bottom: 42, trailing: 16))
        .frame(maxWidth: .infinity)
        .background(Color.white)
    }
}
