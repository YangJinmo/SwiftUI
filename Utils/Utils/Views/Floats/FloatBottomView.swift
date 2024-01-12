//
//  FloatBottomView.swift
//  Utils
//
//  Created by Jmy on 2024/01/12.
//

import SwiftUI

struct FloatBottomView: View {
    let message: String

    var body: some View {
        HStack(spacing: 4) {
            Image.multiply_circle_fill
                .resizable()
                .frame(width: 24, height: 24)

            Text(message)
                .foregroundColor(.gray100)
                .font(.callout)
        }
        .padding(16)
        .padding(.trailing, 8)
        .background(Color.black.opacity(0.8))
        .cornerRadius(8)
        .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
    }
}

struct FloatBottomView_Previews: PreviewProvider {
    static var previews: some View {
        FloatBottomView(message: "안녕하세요! 후기입니다! 반갑습니다!")
    }
}
