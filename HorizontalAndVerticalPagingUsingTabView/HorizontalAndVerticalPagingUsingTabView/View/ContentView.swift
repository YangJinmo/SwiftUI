//
//  ContentView.swift
//  HorizontalAndVerticalPagingUsingTabView
//
//  Created by Jmy on 2023/03/06.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        GeometryReader { proxy in
            TabView {
                ForEach(data) { profile in
                    AsyncImage(url: URL(string: profile.image)) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .scaleEffect(1.5)

                        case let .success(image):
                            image.resizable()
                                .clipped()
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
                .rotationEffect(.degrees(-90)) // Rotate Content
                .frame(
                    width: proxy.size.width,
                    height: proxy.size.height
                )
            }
            .frame(
                width: proxy.size.height, // Swap Height and width
                height: proxy.size.width
            )
            .rotationEffect(.degrees(90), anchor: .topLeading) // Rotate TabView
            .offset(x: proxy.size.width) // Offset back into screens bounds
            .tabViewStyle(
                PageTabViewStyle(indexDisplayMode: .never)
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
