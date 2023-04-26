//
//  UrlWebView.swift
//  InifiniteList
//
//  Created by Jmy on 2023/04/26.
//

import SwiftUI
import WebKit

struct UrlWebView: UIViewRepresentable {
    var urlToDisplay: URL

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.load(URLRequest(url: urlToDisplay))
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
    }
}
