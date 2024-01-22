//
//  DateTextField.swift
//  Utils
//
//  Created by Jmy on 1/18/24.
//

import SwiftUI

struct DateTextField: View {
    @FocusState private var isFocused: Bool
    @State private var oldDateString: String = ""
    @State private var dateString: String = ""
    @State private var isValidDateUpToToday: Bool = false

    let today = Date().toString(dateFormat: "yyyy.MM.dd")
    let max = 10
    let separator = "."

    var body: some View {
        VStack {
            TextField(today, text: $dateString.max(max), onEditingChanged: onEditingChanged, onCommit: onCommit)
                .font(.headline)
                .onChange(of: dateString) { newValue in
                    if newValue.count > oldDateString.count {
                        addDotAtEnd()
                    } else if newValue.last?.description == separator {
                        dropLast(2)
                    }

                    oldDateString = newValue

                    updateValidDateUpToToday()
                }
                .keyboardType(.decimalPad)
                .focused($isFocused)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .overlay(
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .strokeBorder(strokeBorderColor, lineWidth: 1)
                )
                .padding()

            Text("isValidDateUpToToday: \(String(isValidDateUpToToday))")
                .font(.headline)
                .foregroundColor(isValidDateUpToToday ? Color.green : Color.red)
        }
    }

    private func onEditingChanged(editing: Bool) {
        print("onEditingChanged: \(editing)")

        if !editing {
            updateValidDateUpToToday()
        }
    }

    private func onCommit() {
        print("onCommit")

        updateValidDateUpToToday()
    }

    private func addDotAtEnd() {
        if dateString.count == 4 || (dateString.count == 7 && dateString.last?.description != separator) {
            dateString.append(separator)
        }
    }

    private func dropLast(_ k: Int) {
        DispatchQueue.main.async {
            dateString = String(dateString.dropLast(k))
        }
    }

    private func updateValidDateUpToToday() {
        isValidDateUpToToday = dateString.isValidDateUpToToday()
    }

    private var strokeBorderColor: Color {
        return isFocused
            ? Color.accentColor
            : Color.clear
    }
}

#Preview {
    DateTextField()
}
