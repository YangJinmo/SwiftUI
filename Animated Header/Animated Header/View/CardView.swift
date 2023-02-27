//
//  CardView.swift
//  Animated Header
//
//  Created by Jmy on 2023/02/27.
//

import SwiftUI

struct CardView: View {
    var food: Food
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(food.title)
                    .font(.title2)
                    .fontWeight(.bold)

                Text(food.description)
                    .font(.caption)
                    .lineLimit(3)

                Text(food.price)
                    .fontWeight(.bold)
            }

            Spacer(minLength: 8)

            AsyncImage(url: URL(string: food.image)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case let .success(image):
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: 120, maxHeight: 120)
                case .failure:
                    Image(systemName: "photo")
                @unknown default:
                    // Since the AsyncImagePhase enum isn't frozen,
                    // we need to add this currently unused fallback
                    // to handle any new cases that might be added
                    // in the future:
                    EmptyView()
                }
            }
            .frame(maxWidth: 120, maxHeight: 120)
            .cornerRadius(10)
        }
        .padding(.horizontal)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
