//
//  DarkModeToggleStyle.swift
//  Utils
//
//  Created by Jmy on 2023/08/13.
//

import SwiftUI

struct DarkModeToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Rectangle()
            .fill(configuration.isOn ? .blue : .gray)
            // .animation(.easeInOut(duration: 0.3), value: configuration.isOn)
            .frame(width: 160, height: 80)
            .cornerRadius(40)
            .overlay(
                Image(systemName: configuration.isOn ? "sun.max" : "moon")
                    .resizable()
                    .symbolVariant(.fill)
                    .frame(width: configuration.isOn ? 60 : 50, height: configuration.isOn ? 60 : 50)
                    .foregroundColor(configuration.isOn ? .yellow : .orange)
                    .padding(.all, 8)
                    .offset(x: configuration.isOn ? 40 : -40, y: 0)
                // .animation(Animation.easeInOut(duration: 0.3), value: configuration.isOn)
            )
            .onTapGesture { configuration.isOn.toggle() }
    }
}

extension ToggleStyle where Self == DarkModeToggleStyle {
    static var darkMode: DarkModeToggleStyle { .init() }
}

struct DarkModeToggleStylePreview: View {
    @State private var lightModeEnabled = true

    var body: some View {
        Toggle("Enable light mode", isOn: $lightModeEnabled)
            .toggleStyle(.darkMode)
    }
}

#Preview {
    DarkModeToggleStylePreview()
}
