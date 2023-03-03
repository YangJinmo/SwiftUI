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
                    .fontWeight(.bold)

                Text(food.description)
                    .font(.caption)
                    .lineLimit(3)

                Text(food.price)
                    .fontWeight(.bold)
            }

            Spacer(minLength: 8)

            AsyncImage(
                url: URL(string: food.image),
                transaction: .init(animation: .spring())
            ) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .transition(.opacity.combined(with: .scale))

                case let .success(image):
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: 120, maxHeight: 120)
                        .transition(.opacity.combined(with: .scale))

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
                    // Since the AsyncImagePhase enum isn't frozen,
                    // we need to add this currently unused fallback
                    // to handle any new cases that might be added
                    // in the future:
                    EmptyView()
                }
            }
            .frame(maxWidth: 120, maxHeight: 120)
            .cornerRadius(8)
        }
        .padding(.horizontal)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
