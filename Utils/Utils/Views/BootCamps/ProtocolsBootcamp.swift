//
//  ProtocolsBootcamp.swift
//  Utils
//
//  Created by Jmy on 4/2/24.
//

import SwiftUI

struct DefaultColorTheme: ColorThemeProtocol {
    let primary: Color = .blue
    let secondary: Color = .white
    let tertiary: Color = .gray
}

struct AlternativeColorTheme: ColorThemeProtocol {
    let primary: Color = .red
    let secondary: Color = .white
    let tertiary: Color = .green
}

struct AnotherColorTheme: ColorThemeProtocol {
    var primary: Color = .blue
    var secondary: Color = .red
    var tertiary: Color = .purple
}

protocol ColorThemeProtocol {
    var primary: Color { get }
    var secondary: Color { get }
    var tertiary: Color { get }
}

protocol ButtonTextProtocol {
    var buttonText: String { get }
}

protocol ButtonPressedProtocol {
    func buttonPressed()
}

protocol ButtonDataSourceProtocol: ButtonTextProtocol, ButtonPressedProtocol {
}

class DefaultDataSource: ButtonDataSourceProtocol {
    var buttonText: String = "Protocols are awesome!"

    func buttonPressed() {
        print("Button was pressed!")
    }
}

class AlternativeDataSource: ButtonTextProtocol {
    var buttonText: String = "Protocols are lame."
}

struct ProtocolsBootcamp: View {
    // let colorTheme: DefaultColorTheme = DefaultColorTheme()
    // let colorTheme: AlternativeColorTheme = AlternativeColorTheme()
    let colorTheme: ColorThemeProtocol
    let dataSource: ButtonDataSourceProtocol

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
                .onTapGesture {
                    dataSource.buttonPressed()
                }
        }
    }
}

#Preview {
    ProtocolsBootcamp(colorTheme: AnotherColorTheme(), dataSource: DefaultDataSource())
}
