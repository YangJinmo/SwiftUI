//
//  NavigationApp.swift
//  Navigation
//
//  Created by Jmy on 2023/04/17.
//

import SwiftUI

@main
struct NavigationApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)

            CustomNavigationView(isRight: true) {
                Text("RootView")
            } content: {
                Text("This is the Root View")
            } destination: {
                FirstView()
            }
        }
    }
}

import SwiftUI

struct CustomNavigationView<Center: View, Content: View, Destination: View>: View {
    let isLeft: Bool
    let isRight: Bool

    let center: Center?
    let content: Content
    let destination: Destination

    private let size = 44.0

    @State private var isShowRight = false
    @Environment(\.presentationMode) private var mode: Binding<PresentationMode>

    init(
        isLeft: Bool = false,
        isRight: Bool = false,
        @ViewBuilder center: () -> Center?,
        @ViewBuilder content: () -> Content,
        @ViewBuilder destination: () -> Destination
    ) {
        self.isLeft = isLeft
        self.isRight = isRight

        self.center = center()
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

                        center

                        Spacer()

                        Image(systemName: "line.3.horizontal")
                            .frame(width: size, height: size)
                            .opacity(isRight ? 1 : 0)
                            .onTapGesture(count: 1, perform: {
                                self.isShowRight.toggle()
                            })
                    }
                    .frame(width: geometry.size.width, height: size)

                    ZStack {
                        Color.clear

                        content
                    }
                }
                .foregroundColor(.white)
                .background(Color.black)
            }
            .navigationDestination(isPresented: $isShowRight) {
                destination
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

extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()

        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
