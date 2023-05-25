//
//  WebViewLoadHTML.swift
//  WebView
//
//  Created by Jmy on 2023/05/25.
//

import SwiftUI
import WebKit

struct WebViewLoadHTML: UIViewRepresentable {
    let html: String

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.loadHTMLString(html, baseURL: nil)
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
    }
}

struct WebViewLoadHTMLView: View {
    var body: some View {
        WebViewLoadHTML(html: """
        <html>
        <body>
        <h1>Hello, world!</h1>
        <p>Welcome to my website</p>
        </body>
        </html>
        """)
    }
}

struct WebViewLoadHTMLView_Previews: PreviewProvider {
    static var previews: some View {
        WebViewLoadHTMLView()
    }
}
