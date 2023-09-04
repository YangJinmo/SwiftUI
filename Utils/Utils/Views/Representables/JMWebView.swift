//
//  JMWebView.swift
//  Utils
//
//  Created by Jmy on 2023/09/01.
//

import SwiftUI
import WebKit

struct JMWebView: UIViewRepresentable {
    var url: URL

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        let urlRequest = URLRequest(url: url)
        webView.load(urlRequest)
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
    }
}

struct JMWebView_Previews: PreviewProvider {
    static var previews: some View {
        JMWebView(url: "https://www.naver.com".toURL!)
            .ignoresSafeArea()
    }
}
