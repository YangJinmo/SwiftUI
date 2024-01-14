//
//  CustomNavigationView.swift
//  Utils
//
//  Created by Jmy on 2023/06/05.
//

import SwiftUI

struct CustomNavigationView<Title: View, Right: View, Content: View>: View {
    let isBack: Bool
    let isDivider: Bool

    let title: Title
    let right: Right
    let content: Content

    @Environment(\.dismiss) private var dismiss

    init(
        isBack: Bool = false,
        isDivider: Bool = true,
        @ViewBuilder title: () -> Title,
        @ViewBuilder right: () -> Right = { EmptyView() },
        @ViewBuilder content: () -> Content
    ) {
        self.isBack = isBack
        self.isDivider = isDivider
        self.title = title()
        self.right = right()
        self.content = content()
    }

    var body: some View {
        let size = 44.0

        VStack(spacing: 0) {
            ZStack {
                title

                HStack(spacing: 0) {
                    if isBack {
                        Button {
                            endEditing()
                            dismiss()
                        } label: {
                            Image.chevron_backward
                                .frame(width: size, height: size)
                        }
                    }

                    Spacer()

                    right
                        .frame(width: size, height: size)
                }
            }
            .frame(height: size)
            .font(.callout)

            if isDivider {
                Divider()
                    .frame(height: 1)
                    .overlay(Color.gray700)
            }

            ZStack {
                Color.clear

                content
            }
            .navigationBarHidden(true)
        }
        .foregroundColor(.gray100)
        .background(Color.gray800)
    }
}

#Preview {
    RootView()
}

struct RootView: View {
    var body: some View {
        NavigationView {
            CustomNavigationView {
                Text("RootView")
            } content: {
                NavigationLink {
                    FirstView()
                } label: {
                    Text("Go to FirstView")
                        .padding(16)
                        .background(Color.gray)
                        .cornerRadius(16)
                }
            }
        }
        .navigationBarHidden(true)
    }
}

struct FirstView: View {
    var body: some View {
        NavigationView {
            CustomNavigationView(isBack: true) {
                Text("FirstView")
            } content: {
                Text("This is the First View")
            }
        }
        .navigationBarHidden(true)
    }
}

extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()

        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}

extension View {
    func endEditing() {
        #if os(iOS)
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        #elseif os(macOS)
            DispatchQueue.main.async {
                NSApp.keyWindow?.makeFirstResponder(nil)
            }
        #endif
    }
}
