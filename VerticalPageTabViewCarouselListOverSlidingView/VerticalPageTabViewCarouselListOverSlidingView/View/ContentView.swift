//
//  ContentView.swift
//  VerticalPageTabViewCarouselListOverSlidingView
//
//  Created by Jmy on 2023/03/06.
//

import SwiftUI

struct ContentView: View {
    // It disables all scroll bounces in whole app
//    init() {
//        UIScrollView.appearance().bounces = false
//    }

    var body: some View {
        // Ignore Top Edge
        ScrollView(.init()) {
            TabView {
                GeometryReader { proxy in
                    let screen = proxy.frame(in: .global)
                    let offset = screen.minX
                    let scale = 1 + (offset / screen.width)

                    TabView {
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

                                case .failure:
                                    Color.gray
                                        .opacity(0.75)
                                        .overlay {
                                            Image(systemName: "photo")
                                                .foregroundColor(.white)
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

                Color.gray
            }
            // Page Tab Bar
            .tabViewStyle(
                PageTabViewStyle(indexDisplayMode: .never)
            )
        }
        .background(Color(UIColor.systemBackground).ignoresSafeArea())
        .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
