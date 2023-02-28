//
//  HeaderView.swift
//  Animated Header
//
//  Created by Jmy on 2023/02/27.
//

import SwiftUI

struct HeaderView: View {
    @EnvironmentObject var homeData: HomeViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 0) {
                // Back
                Button {
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
                VStack(alignment: .leading, spacing: 8) {
                    Text("Asiatisch . Koreanisch . Japanisch")
                        .font(.caption)

                    HStack(spacing: 4) {
                        Image(systemName: "clock")
                            .font(.caption)

                        Text("30-40 Min")
                            .font(.caption)

                        Text("4.3")
                            .font(.caption)

                        Image(systemName: "star.fill")
                            .font(.caption)

                        Text("$6.40 Fee")
                            .font(.caption)
                            .padding(.leading, 8)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            // Default Frame = 60...
            // Top Frame = 40
            // So Total = 100
            .frame(height: 60)

            if homeData.offset <= -250 {
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

        if homeData.offset < -200 {
            let progress = -(homeData.offset + 200) / 50

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
