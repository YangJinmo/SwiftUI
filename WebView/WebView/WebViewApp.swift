//
//  WebViewApp.swift
//  WebView
//
//  Created by Jmy on 2023/05/25.
//

import SwiftUI

@main
struct WebViewApp: App {
    var body: some Scene {
        WindowGroup {
            HTMLWebViewRepresentable(html: """
            <html>
            <body>
            <h1>Hello, world!</h1>
            <p>Welcome to my website</p>
            </body>
            </html>
            """)
        }
    }
}
