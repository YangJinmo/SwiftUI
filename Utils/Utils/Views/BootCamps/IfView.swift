//
//  IfView.swift
//  Utils
//
//  Created by Jmy on 1/16/24.
//

import SwiftUI

struct IfView: View {
    @State private var colored = true

    var body: some View {
        VStack(spacing: 8) {
            Text("Hello, SwiftUI!")
                .padding()
                .if(colored) { view in
                    view.background(Color.blue)
                }

            Button {
                colored.toggle()
            } label: {
                Text("colored.toggle()")
                    .padding()
                    .if(colored) { view in
                        view.foregroundColor(.white)
                            .background(Color.blue)
                    }
            }
        }
    }
}

#Preview {
    IfView()
}
