//
//  CheckboxToggleStyle.swift
//  Utils
//
//  Created by Jmy on 2023/06/05.
//

import SwiftUI

struct CheckboxToggleStyle: ToggleStyle {
    @Environment(\.isEnabled) var isEnabled
    let style: Style

    func makeBody(configuration: Configuration) -> some View {
        Button {
            configuration.isOn.toggle()
        } label: {
            HStack {
                Image(systemName: "checkmark.\(style.sfSymbolName)")
                    .symbolVariant(.fill)
                    .imageScale(.large)

                configuration.label
                    .font(.callout)
                    .tint(.gray300)
            }
        }
        .tint(configuration.isOn ? .accentColor : .gray500)
        .animation(Animation.easeInOut(duration: 0.3), value: configuration.isOn)
        .disabled(!isEnabled)
    }

    enum Style {
        case square, circle

        var sfSymbolName: String {
            switch self {
            case .square:
                return "square"
            case .circle:
                return "circle"
            }
        }
    }
}

extension ToggleStyle where Self == CheckboxToggleStyle {
    static var checklist: CheckboxToggleStyle { .init(style: .circle) }
    static var squareChecklist: CheckboxToggleStyle { .init(style: .square) }
}

struct CheckboxToggleStylePreview: View {
    @State private var isOn: Bool = false

    var body: some View {
        VStack(spacing: 16) {
            Toggle("CheckboxToggleStyle", isOn: $isOn)
                .toggleStyle(.checklist)

            Toggle("CheckboxToggleStyle", isOn: $isOn)
                .toggleStyle(.squareChecklist)
        }
    }
}

struct CheckboxToggleStyle_Previews: PreviewProvider {
    static var previews: some View {
        CheckboxToggleStylePreview()
    }
}
