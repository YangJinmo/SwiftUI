//
//  CustomNavBarContainerView.swift
//  Utils
//
//  Created by Jmy on 3/17/24.
//

import SwiftUI

struct CustomNavBarContainerView<Content: View>: View {
    let content: Content
    @State private var showBackButton: Bool = true
    @State private var title: String = ""
    @State private var subtitle: String? = nil

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        VStack(spacing: 0) {
            CustomNavBarView(showBackButton: showBackButton, title: title, subtitle: subtitle)

            content
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .onPreferenceChange(CustomNavBarTitlePreferenceKeys.self, perform: { value in
            title = value
        })
        .onPreferenceChange(CustomNavBarSubtitlePreferenceKeys.self, perform: { value in
            subtitle = value
        })
        .onPreferenceChange(CustomNavBarBackButtonHiddenPreferenceKeys.self, perform: { value in
            showBackButton = !value
        })
    }
}

#Preview {
    CustomNavBarContainerView {
        ZStack {
            Color.green.ignoresSafeArea()

            Text("Hello world!")
                .foregroundColor(.white)
                .customNavigationTitle("New Title")
                .customNavigationSubtitle("Subtitle")
                .customNavigationBackButtonHidden(true)
        }
    }
}
