//
//  TopToastViewModifier.swift
//  Utils
//
//  Created by Jmy on 12/7/24.
//

import SwiftUI

struct TopToastView: View {
    var style: ToastStyle
    var message: String
    var width = CGFloat.infinity
    var onCancelTapped: () -> Void

    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            Image(systemName: style.iconFileName)
                .foregroundColor(style.themeColor)

            Text(message)
                .font(.caption)
                .foregroundColor(.white)
        }
        .padding()
        // .frame(minWidth: 0, maxWidth: width)
        .background(Color.gray.opacity(0.9))
        .clipShape(Capsule())
        .padding(.horizontal, 16)
    }
}

import SwiftUI

struct TopToastViewModifier: ViewModifier {
    @Binding var toast: Toast?
    let offsetY: CGFloat
    @State private var workItem: DispatchWorkItem?

    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay(
                ZStack {
                    mainToastView()
                        .offset(y: offsetY)
                }
                .animation(.spring(), value: toast)
            )
            .onChange(of: toast) { _ in
                showToast()
            }
    }

    @ViewBuilder func mainToastView() -> some View {
        if let toast = toast {
            VStack {
                BottomToastView(
                    style: toast.style,
                    message: toast.message,
                    width: toast.width
                ) {
                    dismissToast()
                }

                Spacer()
            }
        }
    }

    private func showToast() {
        guard let toast = toast else { return }

        UIImpactFeedbackGenerator(style: .light)
            .impactOccurred()

        if toast.duration > 0 {
            workItem?.cancel()

            let task = DispatchWorkItem {
                dismissToast()
            }

            workItem = task
            DispatchQueue.main.asyncAfter(deadline: .now() + toast.duration, execute: task)
        }
    }

    private func dismissToast() {
        withAnimation {
            toast = nil
        }

        workItem?.cancel()
        workItem = nil
    }
}

import SwiftUI

extension View {
    func topToastView(toast: Binding<Toast?>, offsetY: CGFloat = 80) -> some View {
        modifier(TopToastViewModifier(toast: toast, offsetY: offsetY))
    }
}

import SwiftUI

struct TopToastViewPreview: View {
    @State private var toast: Toast? = nil

    var body: some View {
        VStack(spacing: 32) {
            Button {
                toast = Toast(style: .success, message: "Saved.", width: 160)
            } label: {
                Text("Run (Success)")
            }

            Button {
                toast = Toast(style: .info, message: "Btw, you are a good person.")
            } label: {
                Text("Run (Info)")
            }

            Button {
                toast = Toast(style: .warning, message: "Beware of a dog!")
            } label: {
                Text("Run (Warning)")
            }

            Button {
                toast = Toast(style: .error, message: "Fatal error, blue screen level.")
            } label: {
                Text("Run (Error)")
            }
        }
        .topToastView(toast: $toast)
    }
}

#Preview {
    TopToastViewPreview()
}

import SwiftUI

struct FloatTopView: View {
    var style: ToastStyle
    let message: String

    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: style.iconFileName)
                .resizable()
                .frame(width: 24, height: 24)

            Text(message)
                .foregroundColor(.gray)
                .font(.callout)
        }
        .padding(16)
        .padding(.trailing, 8)
        .background(Color.black.opacity(0.8))
        .cornerRadius(8)
        .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
    }
}

#Preview {
    FloatTopView(style: .error, message: "안녕하세요! 반갑습니다!")
}
