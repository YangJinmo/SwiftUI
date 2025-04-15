//
//  SideMenuRowView.swift
//  Utils
//
//  Created by Jmy on 3/27/25.
//

import SwiftUI

struct SideMenuRowView: View {
    let option: SideMenuOptionModel
    @Binding var selectedOption: SideMenuOptionModel?

    private var isSelected: Bool {
        return selectedOption == option
    }

    var body: some View {
        HStack {
            Image(systemName: option.imageName)
                .imageScale(.small)

            Text(option.title)
                .font(.subheadline)

            Spacer()
        }
        .padding(.leading)
        .foregroundStyle(isSelected ? .blue : .primary)
        .frame(width: 216, height: 44)
        .background(isSelected ? .blue.opacity(0.15) : .clear)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    SideMenuRowView(option: .dashboard, selectedOption: .constant(.dashboard))
}
