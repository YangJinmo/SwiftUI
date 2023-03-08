//
//  FloatBottomView.swift
//  VerticalPageTabViewCarouselListOverSlidingView
//
//  Created by Jmy on 2023/03/08.
//

import SwiftUI

struct FloatBottomView: View {
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: "photo")
                .foregroundColor(Color(hex: "FDFDFD"))
                .frame(width: 24, height: 24)

            Text("Downloading Image...")
                .foregroundColor(Color(hex: "FDFDFD"))
                .font(.system(size: 14))
        }
        .padding(16)
        .background(Color(hex: "2E363A"))
        .cornerRadius(8)
        .padding(.horizontal, 16)
    }
}

struct FloatBottomView_Previews: PreviewProvider {
    static var previews: some View {
        FloatBottomView()
    }
}
