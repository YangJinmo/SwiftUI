//
//  SideMenuHeaderView.swift
//  Utils
//
//  Created by Jmy on 3/27/25.
//

import SwiftUI

struct SideMenuHeaderView: View {
    var body: some View {
        HStack {
            Image(systemName: "person.circle.fill")
                .imageScale(.large)
                .foregroundColor(.white)
                .frame(width: 48, height: 48)
                .background(.blue)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.vertical)

            VStack(alignment: .leading, spacing: 4) {
                Text("zzimss")
                    .font(.headline)

                Text("github.com/YangJinmo")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }

            Spacer()
        }
    }
}

#Preview {
    SideMenuHeaderView()
        .padding()
}
