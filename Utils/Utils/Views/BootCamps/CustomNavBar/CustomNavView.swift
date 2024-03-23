//
//  CustomNavView.swift
//  Utils
//
//  Created by Jmy on 3/18/24.
//

import SwiftUI

struct CustomNavView<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        NavigationView {
            CustomNavBarContainerView {
                content
            }
            .navigationBarHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview {
    CustomNavView {
        Color.red // .ignoresSafeArea()
    }
}

extension UINavigationController {
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        interactivePopGestureRecognizer?.delegate = nil
    }
}
