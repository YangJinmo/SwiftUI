//
//  CircularProgressView.swift
//  Utils
//
//  Created by Jmy on 9/24/24.
//

import SwiftUI

struct CircularProgressView: View {
    var body: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: .accentColor))
    }
}

#Preview {
    CircularProgressView()
}
