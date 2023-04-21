//
//  CustomNavigationView.swift
//  Navigation
//
//  Created by Jmy on 2023/04/17.
//

import SwiftUI

struct CustomNavigationView<Title: View, Content: View>: View {
    let isBack: Bool
    let isExpandRight: Bool
    let isDivider: Bool

    let title: Title
    let content: Content

    private let size = 44.0

    @Environment(\.presentationMode) private var mode: Binding<PresentationMode>

    init(
        isBack: Bool = false,
        isExpandRight: Bool = true,
        isDivider: Bool = true,
        @ViewBuilder title: () -> Title,
        @ViewBuilder content: () -> Content
    ) {
        self.isBack = isBack
        self.isDivider = isDivider
        self.isExpandRight = isExpandRight
        self.title = title()
        self.content = content()
    }

    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack(spacing: 0) {
                    HStack(spacing: 0) {
                        if isBack {
                            Button {
                                /// Remove Focus
                                endEditing()

                                /// Dismiss
                                mode.wrappedValue.dismiss()
                            } label: {
                                Image(systemName: "chevron.backward")
                                    .frame(width: size, height: size)
                                    .opacity(isBack ? 1 : 0)
                            }
                        }

                        title
                            .frame(
                                width: geometry.size.width - (isBack ? size : 0) - (isExpandRight ? size : 0),
                                height: size
                            )
                            .font(.callout)

                        if isBack, isExpandRight {
                            Spacer(minLength: size)
                        }
                    }
                    .frame(width: geometry.size.width, height: size)

                    if isDivider {
                        Divider()
                            .frame(height: 1)
                    }

                    ZStack {
                        Color.clear

                        content
                    }
                }
                .foregroundColor(Color(UIColor.label))
                .background(Color(UIColor.systemBackground))
            }
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
