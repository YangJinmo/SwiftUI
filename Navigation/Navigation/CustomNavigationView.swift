//
//  CustomNavigationView.swift
//  Navigation
//
//  Created by Jmy on 2023/04/17.
//

import SwiftUI

struct CustomNavigationView<Title: View, Content: View, Destination: View>: View {
    let isLeft: Bool
    let isRight: Bool

    let title: Title
    let content: Content
    let destination: Destination

    private let size = 44.0

    @State private var isShowRight = false
    @Environment(\.presentationMode) private var mode: Binding<PresentationMode>

    init(
        isLeft: Bool = false,
        isRight: Bool = false,
        @ViewBuilder title: () -> Title,
        @ViewBuilder content: () -> Content,
        @ViewBuilder destination: () -> Destination
    ) {
        self.isLeft = isLeft
        self.isRight = isRight

        self.title = title()
        self.content = content()
        self.destination = destination()
    }

    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                VStack(spacing: 0) {
                    HStack {
                        Image(systemName: "chevron.left")
                            .frame(width: size, height: size)
                            .opacity(isLeft ? 1 : 0)
                            .onTapGesture(count: 1, perform: {
                                self.mode.wrappedValue.dismiss()
                            })

                        Spacer()

                        title
                            .frame(height: size)
                            .font(.callout)

                        Spacer()

                        Image(systemName: "line.3.horizontal")
                            .frame(width: size, height: size)
                            .opacity(isRight ? 1 : 0)
                            .onTapGesture(count: 1, perform: {
                                self.isShowRight.toggle()
                            })
                            .navigationDestination(isPresented: $isShowRight) {
                                destination.navigationBarHidden(true)
                            }
                    }
                    .frame(width: geometry.size.width, height: size)

                    Divider()
                        .frame(height: 1)

                    ZStack {
                        Color.clear

                        content
                    }
                }
                .foregroundColor(Color(UIColor.label))
                .background(Color(UIColor.systemBackground))
            }
        }
        .navigationBarHidden(true)
    }
}

struct CustomNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavigationView(isRight: true) {
            Text("RootView")
        } content: {
            Text("This is the Root View")
        } destination: {
            FirstView()
        }
    }
}

struct FirstView: View {
    var body: some View {
        CustomNavigationView(isLeft: true) {
            Text("FirstView")
        } content: {
            Text("This is the First View")
        } destination: {
            EmptyView()
        }
    }
}
