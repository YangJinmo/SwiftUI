//
//  ContentView.swift
//  VerticalPageTabViewCarouselListOverSlidingView
//
//  Created by Jmy on 2023/03/06.
//

import PopupView
import SwiftUI

struct ContentView: View {
    // It disables all scroll bounces in whole app
//    init() {
//        UIScrollView.appearance().bounces = false
//    }

    @Environment(\.colorScheme) var colorScheme

    @State var currentPage = 0
    @State var showingPopup = false

    var body: some View {
        // Ignore Top Edge
        ScrollView(.init()) {
            TabView {
                GeometryReader { proxy in
                    let screen = proxy.frame(in: .global)
                    let offset = screen.minX
                    let scale = 1 + (offset / screen.width)

                    TabView(selection: $currentPage) {
                        ForEach(verticalProfiles) { profile in
                            AsyncImage(url: URL(string: profile.image)) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()

                                case let .success(image):
                                    image.resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: UIScreen.main.bounds.width)

                                        // Setting the ContentMode to Fill and a solution to the problem with the size of the IMAGE
                                        .cornerRadius(1)

                                        .overlay {
                                            VStack {
                                                Spacer()
                                                Text(profile.name)
                                                    .padding()
                                                    .background()
                                                    .clipShape(Capsule())
                                                    .padding()
                                            }
                                        }

                                        // Rotate Content
                                        .rotationEffect(.degrees(-90))
                                        .frame(
                                            width: proxy.size.width,
                                            height: proxy.size.height
                                        )

//                                        .scaleEffect(scale >= 0.88 ? scale : 0.88, anchor: .center)
//                                        .offset(y: -offset)
                                        .blur(radius: (1 - scale) * 20)

                                        .tag(profile.id)

                                case .failure:
                                    Color.gray
                                        .opacity(0.75)
                                        .overlay {
                                            Image(systemName: "photo")
                                                .rotationEffect(.degrees(-90))
                                                .font(.system(size: 24, weight: .bold))
                                                .transition(.opacity.combined(with: .scale))
                                        }

                                @unknown default:
                                    EmptyView()
                                }
                            }
                        }
                    }
                    // Swap Height and width
                    .frame(
                        width: proxy.size.height,
                        height: proxy.size.width
                    )
                    // Rotate TabView
                    .rotationEffect(.degrees(90), anchor: .topLeading)

                    // Offset back into screens bounds
                    .offset(x: proxy.size.width)

                    // Page Tab Bar
                    .tabViewStyle(
                        PageTabViewStyle(indexDisplayMode: .never)
                    )
                }

                DatailView(
                    currentPage: $currentPage,
                    showingPopup: $showingPopup
                )
            }
            // Page Tab Bar
            .tabViewStyle(
                PageTabViewStyle(indexDisplayMode: .never)
            )
        }
        .background(Color(UIColor.systemBackground).ignoresSafeArea())
        .ignoresSafeArea()
        .popup(isPresented: $showingPopup) {
            FloatBottomView()
        } customize: {
            $0
                .type(.floater())
                .position(.bottom)
                .animation(.spring())
                .autohideIn(2)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        ContentView()
            .preferredColorScheme(.dark)
    }
}

struct DatailView: View {
    @Environment(\.colorScheme) var colorScheme

    @Binding var currentPage: Int
    @Binding var showingPopup: Bool

    var body: some View {
        let currentProfile = verticalProfiles[currentPage]
        let safeAreaInsets = UIApplication.sharedKeyWindow?.safeAreaInsets
        let _ = print("safeAreaInsets?.top: \(safeAreaInsets?.top ?? 0)")

        VStack(spacing: 16) {
            Text("Details")
                .font(.title)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, safeAreaInsets?.top ?? 16)

            AsyncImage(url: URL(string: currentProfile.image)) { phase in
                switch phase {
                case .empty:
                    ProgressView()

                case let .success(image):
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(24)
                        .padding()

                case .failure:
                    Color.gray
                        .opacity(0.75)
                        .overlay {
                            Image(systemName: "photo")
                                .rotationEffect(.degrees(-90))
                                .font(.system(size: 24, weight: .bold))
                                .transition(.opacity.combined(with: .scale))
                        }

                @unknown default:
                    EmptyView()
                }
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(currentProfile.name)
                    .font(.title)
                    .fontWeight(.bold)

                Text("\(currentProfile.id)")
                    .fontWeight(.semibold)
                    .foregroundColor(Color(UIColor.secondaryLabel))
            }

            Button {
                showingPopup.toggle()
            } label: {
                Text("Download Image")
                    .fontWeight(.semibold)
                    .foregroundColor(.red)
                    .padding(.vertical, 8)
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.red, lineWidth: 1.5)
                    )
                    .padding()
            }

            Spacer()
        }
        .padding()
        .background(
            (colorScheme == .light
                ? Color(UIColor.tertiarySystemBackground)
                : Color(hex: "171B1C")
            )
            .ignoresSafeArea()
        )
    }
}
