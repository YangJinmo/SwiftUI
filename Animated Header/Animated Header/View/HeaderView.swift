//
//  HeaderView.swift
//  Animated Header
//
//  Created by Jmy on 2023/02/27.
//

import SwiftUI

struct HeaderView: View {
    @EnvironmentObject var homeData: HomeViewModel
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 0) {
                // Back
                Button {
                    print("arrow.left")
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.primary)
                        .frame(width: getSize(), height: getSize())
                        .opacity(getSize() / 40)
                }

                Text("Kavsoft Backery")
                    .font(.title)
                    .fontWeight(.bold)
            }

            ZStack {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Asiatisch . Koreanisch . Japanisch")
                        .font(.caption)

                    HStack(spacing: 8) {
                        HStack(spacing: 4) {
                            Image(systemName: "clock")
                                .font(.caption)
                            Text("30-40 Min")
                                .font(.caption)
                        }

                        HStack(spacing: 4) {
                            Image(systemName: "star.fill")
                                .font(.caption)

                            Text("4.3")
                                .font(.caption)
                        }

                        HStack(spacing: 4) {
                            Text("$")
                                .font(.caption)

                            Text("6.40 Fee")
                                .font(.caption)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .opacity(
                    homeData.offset > 200 ? 1 - Double(homeData.offset - 200) / 50 : 1
                )

                // Custom ScrollView For Automatic Scrolling
                ScrollViewReader { reader in
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 0) {
                            ForEach(tabsItems, id: \.tab) { tab in
                                Text(tab.tab)
                                    .font(.caption)
                                    .padding(.vertical, 8)
                                    .padding(.horizontal)
                                    .background(
                                        Color.primary.opacity(
                                            homeData.selectedTab == tab.tab ? 1 : 0
                                        )
                                    )
                                    .foregroundColor(
                                        homeData.selectedTab == tab.tab ? Color(UIColor.systemBackground) : Color(UIColor.label)
                                    )
                                    .clipShape(Capsule())
                                    .onTapGesture {
                                        print(tab.tab)

//                                        DispatchQueue.main.async {
//                                            self.homeData.selectedTab = tab.tab
//                                        }
                                    }
                            }
                            .onChange(of: homeData.selectedTab) { _ in
                                withAnimation(.easeInOut) {
                                    reader.scrollTo(homeData.selectedTab, anchor: .leading)
                                }
                            }
                        }
                    }

                    // Visible Only When Scrolls Up
                    .opacity(
                        homeData.offset > 200 ? Double(homeData.offset - 200) / 50 : 0
                    )
                }
            }
            // Default Frame = 60...
            // Top Frame = 40
            // So Total = 100
            .frame(height: 60)

            if homeData.offset > 250 {
                Divider()
            }
        }
        .padding(.horizontal)
        .frame(height: 100)
        .background(.background)
    }

    // Getting Size Of Button And Doing Animation
    func getSize() -> CGFloat {
//        let _ = print(homeData.offset)

        if homeData.offset > 200 {
            let progress = (homeData.offset - 200) / 50

//            let _ = print(progress)

            if progress <= 1.0 {
                return progress * 40
            } else {
                return 40
            }
        } else {
            return 0
        }
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
