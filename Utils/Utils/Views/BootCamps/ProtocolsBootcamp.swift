//
//  ProtocolsBootcamp.swift
//  Utils
//
//  Created by Jmy on 4/2/24.
//

import SwiftUI

struct DefaultColorTheme {
    let primary: Color = .blue
    let secondary: Color = .white
    let tertiary: Color = .gray
}

struct ProtocolsBootcamp: View {
    let colorTheme: DefaultColorTheme = DefaultColorTheme()

    var body: some View {
        ZStack {
            colorTheme.tertiary
                .ignoresSafeArea()

            Text("Protocols are awesome!")
                .font(.headline)
                .foregroundColor(colorTheme.secondary)
                .padding()
                .background(
                    colorTheme.primary
                )
                .cornerRadius(10)
        }
    }
}

#Preview {
    ProtocolsBootcamp()
}
