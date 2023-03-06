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
                ForEach(data) { profile in
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
                                .onTapGesture {
                                    print(profile.image)
                                }

                        case .failure:
                            Color
                                .gray
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
            // Page Tab Bar
            .tabViewStyle(
                PageTabViewStyle(indexDisplayMode: .never)
            )
        }
        .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
