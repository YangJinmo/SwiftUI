//
//  SettingsToggleStyle.swift
//  Utils
//
//  Created by Jmy on 2023/08/18.
//

import SwiftUI

struct SettingsToggleStyle: ToggleStyle {
    @Environment(\.isEnabled) var isEnabled
    private let onStyle: AnyShapeStyle = AnyShapeStyle(.tint)
    private let offStyle: AnyShapeStyle = AnyShapeStyle(.gray)

    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label

            Spacer()

            Button {
                withAnimation {
                    configuration.isOn.toggle()
                }
            } label: {
                Image(systemName: configuration.isOn ? "checkmark.square.fill" : "square")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundStyle(configuration.isOn ? onStyle : offStyle)
            }
            .disabled(!isEnabled)
        }
    }
}

extension ToggleStyle where Self == SettingsToggleStyle {
    static var settings: SettingsToggleStyle {
        .init()
    }
}

struct SettingsToggleStyle_Previews: PreviewProvider {
    static var previews: some View {
        SettingsToggleStylePreview()
    }
}

struct SettingsToggleStylePreview: View {
    @State var sync = true
    @State var detectDates = false
    @State var sendReminders = false

    var body: some View {
        NavigationView {
            Form {
                Toggle(isOn: $sync) {
                    Text("Sync tasks in real-time")
                }
                Toggle(isOn: $detectDates) {
                    Text("Detect due dates in tasks automatically")
                }
                Toggle(isOn: $sendReminders) {
                    Text("Send daily reminder")
                }
            }
            .toggleStyle(.settings)
            .tint(.accentColor)
            .navigationTitle("Settings")
        }
    }
}
