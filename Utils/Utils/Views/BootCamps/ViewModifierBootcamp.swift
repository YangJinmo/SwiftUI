//
//  ViewModifierBootcamp.swift
//  Utils
//
//  Created by Jmy on 2/7/24.
//

import SwiftUI

struct DefaultButtonViewModifier: ViewModifier {
    let backgroundColor: Color

    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(backgroundColor)
            .cornerRadius(10)
            .shadow(radius: 10)
    }
}

extension View {
    func withDefaultButtonFommatting(backgroundColor: Color = .blue) -> some View {
        modifier(DefaultButtonViewModifier(backgroundColor: backgroundColor))
    }
}

struct ViewModifierBootcamp: View {
    var body: some View {
        VStack(spacing: 10) {
            Text("Hello, world!")
                .font(.headline)
                .withDefaultButtonFommatting()

            Text("Hello, everyone!")
                .font(.subheadline)
                .withDefaultButtonFommatting(backgroundColor: .orange)

            Text("Hello!!!")
                .font(.title)
                .withDefaultButtonFommatting(backgroundColor: .pink)
        }
        .padding()
    }
}

#Preview {
    ViewModifierBootcamp()
}
