//
//  HomeView.swift
//  Animated Header
//
//  Created by Jmy on 2023/02/27.
//

import SwiftUI

struct HomeView: View {
    @StateObject var homeData = HomeViewModel()
    @Environment(\.colorScheme) var scheme

    var body: some View {
        // let _ = print("homeData.offset: \(homeData.offset)")

        ScrollView {
            // Since Were Pinning Header View
            LazyVStack(
                alignment: .leading,
                pinnedViews: [.sectionHeaders],
                content: {
                    // Parallax Header
                    GeometryReader { reader -> AnyView in
                        let offset = reader.frame(in: .global).minY

                        if -offset >= 0 {
                            DispatchQueue.main.async {
                                self.homeData.offset = -offset
                            }
                        }

                        return AnyView(
                            AsyncImage(url: URL(string: food.image)) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                        .scaleEffect(1.5)
                                        .frame(
                                            width: UIScreen.main.bounds.width,
                                            height: 200
                                        )

                                case let .success(image):
                                    image.resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(
                                            width: UIScreen.main.bounds.width,
                                            height: 250 + (offset > 0 ? offset : 0)
                                        )
                                        .offset(y: offset > 0 ? -offset : 0)
                                        .overlay(alignment: .top) {
                                            HStack {
                                                Button {
                                                    print("arrow.left")
                                                } label: {
                                                    Image(systemName: "arrow.left")
                                                        .font(.system(size: 20, weight: .bold))
                                                        .foregroundColor(.white)
                                                }

                                                Spacer()

                                                Button {
                                                    print("suit.heart.fill")
                                                } label: {
                                                    Image(systemName: "suit.heart.fill")
                                                        .font(.system(size: 20, weight: .bold))
                                                        .foregroundColor(.white)
                                                }
                                            }
                                            .padding()
                                        }
                                        .onTapGesture {
                                            print(image)
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
                        )
                    }
                    .frame(height: 250)

                    // Cards
                    Section(header: HeaderView()) {
                        ForEach(tabsItems) { tab in
                            VStack(alignment: .leading, spacing: 16) {
                                Text(tab.tab)
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .padding(.bottom)
                                    .padding(.leading)
                                    .onTapGesture {
                                        print(tab.tab)
                                    }

                                ForEach(foods) { food in
                                    CardView(food: food)
                                        .onTapGesture {
                                            print(food.title)
                                        }
                                }

                                Divider()
                                    .padding(.top)
                            }
                            .tag(tab.tab)
                            .overlay {
                                GeometryReader { reader -> Text in
                                    // Calculating which tab
                                    let offset = reader.frame(in: .global).midY

                                    // Top Area + Header Size 100
                                    let height = (UIApplication.shared.mainKeyWindow?.safeAreaInsets.top ?? 0) + 100

                                    if offset < height && offset > 50 && homeData.selectedTab != tab.tab {
                                        print("offset: \(offset)")

                                        DispatchQueue.main.async {
                                            self.homeData.selectedTab = tab.tab
                                        }
                                    }

                                    return Text("")
                                }
                            }
                        }
                    }
                }
            )
        }
        .overlay(
            // Only Safe Area
            Color(UIColor.systemBackground)
                .frame(height: UIApplication.shared.mainKeyWindow?.safeAreaInsets.top)
                .ignoresSafeArea(.all, edges: .top)
                .opacity(homeData.offset > 250 ? 1 : 0),
            alignment: .top
        )
        // Use It Environment Object For Accessing All Sub Objects
        .environmentObject(homeData)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
