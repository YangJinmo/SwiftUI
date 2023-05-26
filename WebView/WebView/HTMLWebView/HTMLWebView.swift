//
//  HTMLWebView.swift
//  WebView
//
//  Created by Jmy on 2023/05/25.
//

import SwiftUI

struct HTMLWebView: View {
    let html: String

    var body: some View {
        HTMLWebViewRepresentable(
            html: """
            <html>
            <body>
            <h1>Hello, world!</h1>
            <p>Welcome to my website</p>
            </body>
            </html>
            """
        )
    }
}

struct HTMLWebView_Previews: PreviewProvider {
    static var previews: some View {
        HTMLWebView(
            html: """
            <html>
            <body>
            <h1>Hello, world!</h1>
            <p>Welcome to my website</p>
            </body>
            </html>
            """
        )
    }
}
