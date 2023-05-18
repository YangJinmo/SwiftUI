//
//  HomeView.swift
//  CustomTransitionBetweenScreens
//
//  Created by Jmy on 2023/05/15.
//

import SwiftUI

struct HomeView: View {
    @State var hasScrolled = false
    @Namespace var namespace
    @State var show = false

    var body: some View {
        ZStack {
            Color("Background").ignoresSafeArea()

            ScrollView {
//                scrollDetection

//                featured

                FeaturedItem()

                Text("Courses".uppercased())
                    .font(.footnote.weight(.semibold))
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)

                if !show {
                    CourseItem(namespace: namespace, show: $show)
                        .onTapGesture {
                            withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                                show.toggle()
                            }
                        }
                }
            }
            .coordinateSpace(name: "scroll")
            .safeAreaInset(edge: .top) {
                Color.clear.frame(height: 70)
            }
            .overlay {
                NavigationBar(title: "Featured", hasScrolled: $hasScrolled)
            }

            if show {
                CourseView(namespace: namespace, show: $show)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
