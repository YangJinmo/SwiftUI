//
//  NavigationModifier.swift
//  Utils
//
//  Created by Jmy on 10/23/24.
//

import SwiftUI

struct NavigationModifier: ViewModifier {
    @Environment(\.dismiss) var dismiss

    func body(content: Content) -> some View {
        content
            .navigationTitle("")
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.backward")
                    }
                    .border(.green)
                }
            }
    }
}

extension View {
    func navigationModifier() -> some View {
        modifier(NavigationModifier())
    }
}

#Preview {
    if #available(iOS 16.0, *) {
        NavigationStack {
            NavigationLink {
                Text("Destination View")
                    .navigationModifier()
            } label: {
                Text("NavigationLink")
            }
        }
    } else {
        // Fallback on earlier versions
    }
}
