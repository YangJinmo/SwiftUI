//
//  SelectedButtonView.swift
//  Utils
//
//  Created by Jmy on 8/7/24.
//

import SwiftUI

struct SelectedButtonView: View {
    enum Sort: String, CaseIterable, Identifiable {
        case all, nearest, recommendation

        var id: Self { self }
    }

    @State private var selectedSort = Sort.all

    var body: some View {
        HStack(spacing: 12) {
            Spacer()

            ForEach(Sort.allCases) { sort in
                Button {
                    selectedSort = sort
                } label: {
                    Text(sort.rawValue.capitalized)
                }
                .buttonStyle(.roundedRectangle(isOn: .constant(selectedSort == sort)))
            }
        }
        .padding()
    }
}

#Preview {
    SelectedButtonView()
}
