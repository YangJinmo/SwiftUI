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

    private let size = 44.0

    @Environment(\.presentationMode) private var mode: Binding<PresentationMode>
    @StateObject private var keyboardObserver = KeyboardObserver()

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
        NavigationView {
            VStack(spacing: 0) {
                ZStack {
                    title

                    HStack(spacing: 0) {
                        if isBack {
                            Button {
                                /// End Editing
                                if keyboardObserver.keyboardIsVisible {
                                    endEditing()
                                }

                                /// Dismiss
                                if mode.wrappedValue.isPresented {
                                    mode.wrappedValue.dismiss()
                                }
                            } label: {
                                Image(systemName: "chevron.left")
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
                        .background(Color.gray700)
                }

                ZStack {
                    Color.clear

                    content
                }
            }
            .foregroundColor(.gray100)
            .background(Color.gray800)
            .navigationBarHidden(true)
        }
        .navigationBarHidden(true)
    }
}

struct CustomNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}

struct RootView: View {
    var body: some View {
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
}

struct FirstView: View {
    var body: some View {
        CustomNavigationView(isBack: true) {
            Text("FirstView")
        } content: {
            Text("This is the First View")
        }
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
