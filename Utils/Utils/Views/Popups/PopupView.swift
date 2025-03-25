//
//  PopupView.swift
//  Utils
//
//  Created by Jmy on 2024/01/11.
//

import SwiftUI

struct PopupView: View {
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

// #Preview {
//    VStack {
//        PopupView(
//            title: "Title",
//            content: "Content",
//            cancelTitle: nil,
//            confirmTitle: nil
//        ) { action in
//            print("\(action)")
//        }
//
//        PopupView(
//            title: "Title",
//            content: "Content",
//            cancelTitle: "Cancel",
//            confirmTitle: "Confirm"
//        ) { action in
//            print("\(action)")
//        }
//    }
// }

enum TwoOptions {
    case confirm
    case cancel
}

// #Preview {
//    if #available(iOS 16.0, *) {
//        ContentView3()
//    } else {
//        // Fallback on earlier versions
//    }
// }
//
// import SwiftUI
//
// @available(iOS 16.0, *)
// struct ContentView3: View {
//    @State private var showPopup = false
//    @State private var showAlert = false
//    @State private var isWrongPassword = false
//    @State private var isTryingAgain = false
//
//    var body: some View {
//        NavigationStack {
//            Button("Show Popup") {
//                withAnimation(.easeInOut) {
//                    showAlert = true
//                }
//            }
//            .navigationTitle("Documents")
//        }
//        .popView(isPresented: $showAlert) {
//            showAlert = isWrongPassword
//            isWrongPassword = false
//        } content: {
//            CustomAlertWithTextField(show: $showPopup)
//        }
//    }
// }

@available(iOS 17.0, *)
extension View {
    @ViewBuilder
    func popView<Content: View>(
        isPresented: Binding<Bool>,
        onDismiss: @escaping () -> Void,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View {
        modifier(PopupViewHelper(isPresented: isPresented, onDismiss: onDismiss, viewContent: content))
    }
}

@available(iOS 17.0, *)
fileprivate struct PopupViewHelper<ViewContent: View>: ViewModifier {
    @Binding var isPresented: Bool
    var onDismiss: () -> Void
    @ViewBuilder var viewContent: ViewContent

    // Local View Properties
    @State private var presentFullScreenCover = false
    @State private var animateView = false

    func body(content: Content) -> some View {
        // UnMutable Properties
        let screenHeight = screenSize.height
        let animateView = animateView

        content
            .fullScreenCover(isPresented: $presentFullScreenCover, onDismiss: onDismiss) {
                viewContent
                    .visualEffect { content, proxy in
                        content
                            .offset(y: offset(proxy, screenHeight: screenHeight, animateView: animateView))
                    }
                    .presentationBackground(.clear)
                    .task {
                        guard !animateView else { return }
                        withAnimation(.bouncy(duration: 0.4, extraBounce: 0.05)) {
                            self.animateView = true
                        }
                    }
            }
            .onChange(of: isPresented) { newValue in
                if newValue {
                    var transaction = Transaction()
                    transaction.disablesAnimations = true

                    withTransaction(transaction) {
                        presentFullScreenCover = newValue
                    }
                } else {
                    Task {
                        withAnimation(.snappy(duration: 0.45, extraBounce: 0)) {
                            self.animateView = false
                        }

                        try? await Task.sleep(for: .seconds(0.45))
                    }
                }
            }
    }

    nonisolated func offset(_ proxy: GeometryProxy, screenHeight: CGFloat, animateView: Bool) -> CGFloat {
        let viewHeight = proxy.size.height
        return animateView ? 0 : (screenHeight + viewHeight) / 2
    }

    var screenSize: CGSize {
        if let screenSize = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.screen.bounds.size {
            return screenSize
        }
        return .zero
    }
}

@available(iOS 17.0, *)
struct ContentView4: View {
    @State private var showPopup = false

    var body: some View {
        NavigationStack {
            Button {
                showPopup.toggle()
            } label: {
                Text("Unlock File")
            }
            .navigationTitle("Documents")
        }
        .popView(isPresented: $showPopup) {
        } content: {
            Text("Dummy View")
        }
    }
}

#Preview {
    if #available(iOS 17.0, *) {
        ContentView4()
    } else {
        // Fallback on earlier versions
    }
}
