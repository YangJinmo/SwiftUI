//
//  CustomNavBarView.swift
//  Utils
//
//  Created by Jmy on 3/17/24.
//

import SwiftUI

struct CustomNavBarView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var showBackButton: Bool = true
    @State private var title: String = "Title" // ""
    @State private var subtitle: String? = "Subtitle" // nil

    var body: some View {
        HStack {
            if showBackButton {
                backButton
            }

            Spacer()

            titleSection

            Spacer()

            if showBackButton {
                backButton
                    .opacity(0)
            }
        }
        .padding()
        .accentColor(.white)
        .foregroundColor(.white)
        .font(.headline)
        .background(
            Color.blue // .ignoresSafeArea(edges: .top)
        )
    }
}

#Preview {
    VStack {
        CustomNavBarView()

        Spacer()
    }
}

extension CustomNavBarView {
    private var backButton: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }, label: {
            Image(systemName: "chevron.left")
        })
    }

    private var titleSection: some View {
        VStack(spacing: 4) {
            Text(title)
                .font(.title)
                .fontWeight(.semibold)

            if let subtitle = subtitle {
                Text(subtitle)
            }
        }
    }
}
