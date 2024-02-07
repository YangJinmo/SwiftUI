//
//  ViewModifierBootcamp.swift
//  Utils
//
//  Created by Jmy on 2/7/24.
//

import SwiftUI

struct ViewModifierBootcamp: View {
    var body: some View {
        VStack {
            Text("Hello, world!")
                .font(.headline)
                .foregroundColor(.white)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .cornerRadius(10)
                .shadow(radius: 10)
        }
    }
}

#Preview {
    ViewModifierBootcamp()
}
