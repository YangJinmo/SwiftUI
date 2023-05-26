//
//  HTMLWebViewRepresentable.swift
//  WebView
//
//  Created by Jmy on 2023/05/25.
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
