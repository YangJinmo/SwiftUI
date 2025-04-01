//
//  JMNavigationBarViewModifier.swift
//  Utils
//
//  Created by Jmy on 10/29/24.
//

import SwiftUI

struct JMNavigationBarViewModifier<R>: ViewModifier where R: View {
    @Environment(\.dismiss) var dismiss

    enum DismissType {
        case none
        case push
        case present

        var iconImage: Image {
            switch self {
            case .none: return Image("")
            case .push: return Image(systemName: "chevron.backward")
            case .present: return Image(systemName: "xmark")
            }
        }
    }

    let dismissType: DismissType
    let title: String
    private let value = 44.0
    let rightView: (() -> R)?

    init(dismissType: DismissType, title: String, rightView: (() -> R)? = nil) {
        self.dismissType = dismissType
        self.title = title
        self.rightView = rightView
    }

    func body(content: Content) -> some View {
        VStack(spacing: 0) {
            ZStack {
                Text(title)
                    .font(.headline)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)

                HStack {
                    Button {
                        dismiss()
                    } label: {
                        dismissType.iconImage
                            .frame(width: value)
                            .frame(maxHeight: .infinity)
                    }

                    Spacer()

                    self.rightView?()
                        .frame(width: value)
                        .frame(maxHeight: .infinity)
                }
            }
            .frame(height: value)

            ZStack {
                Color.clear

                content
            }
            .navigationBarHidden(true)
        }
        .foregroundColor(.white)
        .background(Color.black)
        .lazyView()
    }
}

extension View {
    func push<R>(
        title: String,
        rightView: @escaping (() -> R) = { EmptyView() }
    ) -> some View where R: View {
        modifier(JMNavigationBarViewModifier(dismissType: .push, title: title, rightView: rightView))
    }

    func present<R>(
        title: String,
        rightView: @escaping (() -> R) = { EmptyView() }
    ) -> some View where R: View {
        modifier(JMNavigationBarViewModifier(dismissType: .present, title: title, rightView: rightView))
    }
}

#Preview {
    NavigationViewPreview()
}

struct NavigationViewPreview: View {
    @State private var isPresenting: Bool = false

    var body: some View {
        NavigationView {
            VStack {
                NavigationLink {
                    Text("Destination View")
                        .push(title: "Title") {
                            Button {
                                print("Right")
                            } label: {
                                Text("Right")
                            }
                        }
                } label: {
                    Text("Push")
                }

                Button {
                    isPresenting.toggle()
                } label: {
                    Text("Present")
                }
            }
        }
        .sheet(isPresented: $isPresenting) {
            print("onDismiss")
        } content: {
            Text("Destination View")
                .present(title: "Title") {
                    Button {
                        print("Right")
                    } label: {
                        Text("Right")
                    }
                }
        }
    }
}
