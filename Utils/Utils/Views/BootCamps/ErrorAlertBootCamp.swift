//
//  ErrorAlertBootCamp.swift
//  Utils
//
//  Created by Jmy on 1/25/24.
//

import SwiftUI

struct ErrorAlertBootCamp: View {
    @State private var errorTitle: String? = nil

    var body: some View {
        Button {
            saveData()
        } label: {
            Text("CLICK ME")
        }
        .alert(errorTitle ?? "Error", isPresented: Binding(value: $errorTitle)) {
            Button(action: {
            }, label: {
                Text("OK")
            })
        }
    }

    private func saveData() {
        let isSuccessful = false

        if isSuccessful {
            // do something
        } else {
            // error

            errorTitle = "An error occured!"
        }
    }
}

#Preview {
    ErrorAlertBootCamp()
}
