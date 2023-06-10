//
//  HTMLWebView.swift
//  Utils
//
//  Created by Jmy on 2023/06/05.
//

import SwiftUI
import WebKit

struct HTMLWebViewRepresentable: UIViewRepresentable {
    let html: String

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.loadHTMLString(html, baseURL: nil)
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
    }
}

struct HTMLWebView: View {
    let title: String
    let html: String

    var body: some View {
        CustomNavigationView(isBack: true) {
            Text(title)
        } content: {
            HTMLWebViewRepresentable(html: html)
                .edgesIgnoringSafeArea(.all)
        }
    }
}

struct HTMLWebView_Previews: PreviewProvider {
    static var previews: some View {
        HTMLWebView(
            title: "Hello, world!",
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
