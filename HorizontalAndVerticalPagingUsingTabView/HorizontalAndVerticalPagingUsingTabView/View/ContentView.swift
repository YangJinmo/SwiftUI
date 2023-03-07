//
//  ContentView.swift
//  HorizontalAndVerticalPagingUsingTabView
//
//  Created by Jmy on 2023/03/06.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ScrollView(.init()) {
            GeometryReader { proxy in
                TabView {
                    ForEach(verticalProfiles) { profile in
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
                                    .overlay {
                                        VStack {
                                            Spacer()
                                            Text(profile.name)
                                                .padding()
                                        }
                                    }

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
                    // Rotate Content
                    .rotationEffect(.degrees(-90))
                    .frame(
                        width: proxy.size.width,
                        height: proxy.size.height
                    )
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
                .tabViewStyle(
                    PageTabViewStyle(indexDisplayMode: .never)
                )
            }
        }
        .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
