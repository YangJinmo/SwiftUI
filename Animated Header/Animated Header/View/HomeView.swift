//
//  HomeView.swift
//  Animated Header
//
//  Created by Jmy on 2023/02/27.
//

import SwiftUI

struct HomeView: View {
    @StateObject var homeData = HomeViewModel()

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
                                self.homeData.offset = offset
                            }
                        }

                        return AnyView(
                            AsyncImage(url: URL(string: food.image)) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                case let .success(image):
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(
                                            width: UIScreen.main.bounds.width,
                                            height: 250 + (offset > 0 ? offset : 0)
                                        )
                                        .offset(y: offset > 0 ? -offset : 0)
                                case .failure:
                                    Image(systemName: "photo")
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

                                ForEach(foods) { food in
                                    CardView(food: food)
                                }

                                Divider()
                                    .padding(.top)
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
                .opacity(homeData.offset <= -250 ? 1 : 0),
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
