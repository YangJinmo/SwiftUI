//
//  CustomNavLink.swift
//  Utils
//
//  Created by Jmy on 3/20/24.
//

import SwiftUI

struct CustomNavLink<Label: View, Destination: View>: View {
    let destination: Destination
    let label: Label

    init(destination: Destination, @ViewBuilder label: () -> Label) {
        self.destination = destination
        self.label = label()
    }

    var body: some View {
        NavigationLink {
            CustomNavBarContainerView {
                destination
            }
            .navigationBarHidden(true)
        } label: {
            label
        }
    }
}

#Preview {
    CustomNavView {
        CustomNavLink(
            destination: Text("Destination")
        ) {
            Text("CLICK ME")
        }
    }
}
