//
//  FeaturedItem.swift
//  CustomTransitionBetweenScreens
//
//  Created by Jmy on 2023/05/16.
//

import SwiftUI

struct FeaturedItem: View {
    var course: Course

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Spacer()

            Image(course.logo)
                .resizable(resizingMode: .stretch)
                .aspectRatio(contentMode: .fit)
                .frame(width: 26, height: 26)
                .cornerRadius(10)
                .padding(9)
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16, style: .continuous))

            Text(course.title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(
                    .linearGradient(
                        colors: [.primary, .primary.opacity(0.5)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .lineLimit(1)

            Text(course.subtitle.uppercased())
                .font(.footnote)
                .fontWeight(.semibold)
                .foregroundStyle(.secondary)

            Text(course.text)
                .font(.footnote)
                .multilineTextAlignment(.leading)
                .lineLimit(2)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.secondary)
        }
        .padding(20)
        .padding(.vertical, 20)
        .frame(height: 350)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
//        .shadow(color: Color("Shadow").opacity(0.3), radius: 10, x: 0, y: 10)
        .padding(.horizontal, 20)
        .overlay(
            Image(course.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 250, maxHeight: 250)
                .offset(x: 32, y: -100)
        )
    }
}

struct FeaturedItem_Previews: PreviewProvider {
    static var previews: some View {
        TabView {
            ForEach(courses) { item in
                FeaturedItem(course: item)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .frame(height: 430)
        .background(
            Image("COMINGSOON")
                .offset(x: 250, y: -100)
                .opacity(0.5)
        )
    }
}
