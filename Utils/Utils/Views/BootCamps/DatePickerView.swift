//
//  DatePickerView.swift
//  Utils
//
//  Created by Jmy on 12/30/23.
//

import SwiftUI

struct DatePickerView: View {
    @State private var selectedDate: Date = Date()

    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short // 12/30/23
        formatter.dateStyle = .long // December 30, 2023
        formatter.dateStyle = .medium // Dec 30, 2023
        formatter.dateStyle = .full // Saturday, December 30, 2023
        return formatter
    }()

    var body: some View {
        VStack(spacing: 30) {
            DatePicker(
                "Select a Date",
                selection: $selectedDate,
                displayedComponents: .date // hourAndMinute
            )

            Text("Selected Date: \(selectedDate, formatter: dateFormatter)")
        }
        .padding()
    }
}

#Preview {
    DatePickerView()
}
