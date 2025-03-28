//
//  JMView.swift
//  Utils
//
//  Created by Jmy on 2023/07/17.
//

import SwiftUI

struct JMView<Title: View, Right: View, Content: View>: View {
    enum ViewType {
        case none
        case presentation
        case navigation

        var leftIconImage: Image {
            switch self {
            case .none: return Image("")
            case .presentation: return .xmark
            case .navigation: return .chevron_backward
            }
        }
    }

    let viewType: ViewType
    @Binding var isPresented: Bool
    let isDivider: Bool

    let title: Title
    let right: Right
    let content: Content

    init(
        isDivider: Bool = true,
        @ViewBuilder title: () -> Title,
        @ViewBuilder right: () -> Right = { EmptyView() },
        @ViewBuilder content: () -> Content
    ) {
        viewType = .none
        _isPresented = .constant(false)
        self.isDivider = isDivider
        self.title = title()
        self.right = right()
        self.content = content()
    }

    init(
        _ viewType: ViewType,
        _ isPresented: Binding<Bool>,
        isDivider: Bool = true,
        @ViewBuilder title: () -> Title,
        @ViewBuilder right: () -> Right = { EmptyView() },
        @ViewBuilder content: () -> Content
    ) {
        self.viewType = viewType
        _isPresented = isPresented
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
                    Button {
                        endEditing()
                        isPresented = false
                    } label: {
                        viewType.leftIconImage
                            .renderingMode(.template)
                            .frame(width: size, height: size)
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
                    .background(Color.gray.opacity(0.5))
            }

            ZStack {
                Color.clear

                content
            }
            .navigationBarHidden(true)
        }
        .foregroundColor(Color(uiColor: .label))
    }
}

#Preview {
    JMView_Previews_View()
}

struct JMView_Previews_View: View {
    @State private var isActiving = false
    @State private var isShowingSheet = false
    @State private var isPresenting = false

    var body: some View {
        NavigationView {
            JMView {
                Text("JMView")
                    .onAppear {
                        print("JMView - onAppear")
                    }
                    .onDisappear {
                        print("JMView - onDisappear")
                    }
            } content: {
                VStack {
                    NavigationLink(isActive: $isActiving) {
                        JMView(.navigation, $isActiving) {
                            Text("Navigation")
                                .onAppear {
                                    print("Navigation - onAppear")
                                }
                                .onDisappear {
                                    print("Navigation - onDisappear")
                                }
                        } content: {
                            Text("This is navigation")
                        }
                    } label: {
                        Text("Navigation")
                            .padding(16)
                            .background(Color.gray)
                            .cornerRadius(16)
                    }

                    Button {
                        isShowingSheet = true
                    } label: {
                        Text("Sheet")
                            .padding(16)
                            .background(Color.gray)
                            .cornerRadius(16)
                    }

                    Button {
                        isPresenting = true
                    } label: {
                        Text("Full Screen Cover")
                            .padding(16)
                            .background(Color.gray)
                            .cornerRadius(16)
                    }
                }
                .sheet(isPresented: $isShowingSheet) {
                    isShowingSheet = false
                } content: {
                    JMView(.presentation, $isShowingSheet) {
                        Text("Sheet")
                            .onAppear {
                                print("Sheet - onAppear")
                            }
                            .onDisappear {
                                print("Sheet - onDisappear")
                            }
                    } right: {
                        Button {
                            print("checkmark button touched")
                        } label: {
                            Image.checkmark
                        }
                    } content: {
                        Text("This is sheet")
                    }
                }
                .fullScreenCover(isPresented: $isPresenting) {
                    isPresenting = false
                } content: {
                    JMView(.presentation, $isPresenting) {
                        Text("Full Screen Cover")
                            .onAppear {
                                print("Full Screen Cover - onAppear")
                            }
                            .onDisappear {
                                print("Full Screen Cover - onDisappear")
                            }
                    } right: {
                        Button {
                            print("checkmark button touched")
                        } label: {
                            Image.checkmark
                        }
                    } content: {
                        Text("This is fullScreenCover")
                    }
                }
            }
        }
        .navigationBarHidden(true)
        .navigationViewStyle(.stack)
    }
}

#Preview {
    PresentationView()
}

struct PresentationView: View {
    @State private var showInfo = false
    @State private var showSettings = false
    @State private var presentInfo = false
    @State private var selectedFlavor: Flavor = .chocolate

    var body: some View {
        VStack {
            Button("View Info") {
                showInfo = true
            }

            Button("View Settings") {
                showSettings = true
            }

            Button("Present Info") {
                presentInfo = true
            }
        }
        .popover(isPresented: $showInfo) {
            if #available(iOS 16.4, *) {
                InfoView()
                    .presentationCompactAdaptation(
                        horizontal: .popover,
                        vertical: .sheet)
            } else {
                // Fallback on earlier versions
            }
        }
        .sheet(isPresented: $showSettings) {
            if #available(iOS 16.4, *) {
                InfoView()
                    .presentationDetents([.medium, .large])
                    .presentationCompactAdaptation(.none)
            } else {
                // Fallback on earlier versions
            }
        }
        .sheet(isPresented: $presentInfo) {
            if #available(iOS 18.0, *) {
                VStack {
                    Picker("Flower Species", selection: $selectedFlavor) {
                        ForEach(Flavor.allCases) {
                            Text($0.rawValue.uppercased()).tag($0)
                        }
                    }

                    Text(selectedFlavor.rawValue)
                        .font(.largeTitle)

                    Text(selectedFlavor.rawValue)
                }
                .frame(maxHeight: .infinity, alignment: .top)
                .padding()
                .presentationSizing(
                    .page
                        .fitted(horizontal: false, vertical: true)
                        .sticky(horizontal: false, vertical: true)
                )
            } else {
                // Fallback on earlier versions
            }
        }
    }
}
