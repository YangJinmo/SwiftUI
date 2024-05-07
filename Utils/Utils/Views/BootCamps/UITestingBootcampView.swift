//
//  UITestingBootcampView.swift
//  Utils
//
//  Created by Jmy on 5/7/24.
//

import SwiftUI

struct UITestingBootcampView: View {
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.blue, Color.black]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack {
                // TextField()
            }
        }
    }
}

#Preview {
    UITestingBootcampView()
}
