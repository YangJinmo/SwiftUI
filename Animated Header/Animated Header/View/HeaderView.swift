//
//  HeaderView.swift
//  Animated Header
//
//  Created by Jmy on 2023/02/27.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Kavsoft Backery")
                .font(.title)
                .fontWeight(.bold)

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

            Spacer(minLength: 0)
        }
        .padding(.horizontal)
        .frame(height: 100)
        .background(.background)
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
