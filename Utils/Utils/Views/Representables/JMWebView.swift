//
//  JMWebView.swift
//  Utils
//
//  Created by Jmy on 2023/06/05.
//

import SwiftUI
import WebKit

final class JMWebView: WKWebView {
    override init(frame: CGRect, configuration: WKWebViewConfiguration) {
        super.init(frame: frame, configuration: configuration)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    init(url: URL) {
        let configuration = WKWebViewConfiguration()
        super.init(frame: .zero, configuration: configuration)

        isOpaque = false

        let urlRequest = URLRequest(url: url)
        load(urlRequest)
    }

    init(htmlString: String) {
        let configuration = WKWebViewConfiguration()
        super.init(frame: .zero, configuration: configuration)

        isOpaque = false

        loadHTMLString(htmlString, baseURL: nil)
    }
}

struct HTMLWebNavigationView: View {
    @Binding var isActiving: Bool

    let title: String
    let html: String

    var body: some View {
        JMView(.navigation, $isActiving) {
            Text(title)
        } content: {
            ViewRepresentable {
                JMWebView(htmlString: html)
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

#Preview {
    JMView {
        Text("https://www.naver.com")
    } content: {
        ViewRepresentable {
            JMWebView(url: "https://www.naver.com".toURL!)
        }
    }
    .edgesIgnoringSafeArea(.bottom)
}

#Preview {
    JMView {
        Text("Hello, world!")
    } content: {
        ViewRepresentable {
            JMWebView(htmlString: """
                <html>
                <body>
                <h1>Hello, world!</h1>
                <p>Welcome to my website</p>
                <h1>Hello, world!</h1>
                <p>Welcome to my website</p>
                <h1>Hello, world!</h1>
                <p>Welcome to my website</p>
                <h1>Hello, world!</h1>
                <p>Welcome to my website</p>
                <h1>Hello, world!</h1>
                <p>Welcome to my website</p>
                <h1>Hello, world!</h1>
                <p>Welcome to my website</p>
                <h1>Hello, world!</h1>
                <p>Welcome to my website</p>
                <h1>Hello, world!</h1>
                <p>Welcome to my website</p>
                <h1>Hello, world!</h1>
                <p>Welcome to my website</p>
                <h1>Hello, world!</h1>
                <p>Welcome to my website</p>
                <h1>Hello, world!</h1>
                <p>Welcome to my website</p>
                <h1>Hello, world!</h1>
                <p>Welcome to my website</p>
                <h1>Hello, world!</h1>
                <p>Welcome to my website</p>
                <h1>Hello, world!</h1>
                <p>Welcome to my website</p>
                <h1>Hello, world!</h1>
                <p>Welcome to my website</p>
                <h1>Hello, world!</h1>
                <p>Welcome to my website</p>
                <h1>Hello, world!</h1>
                <p>Welcome to my website</p>
                <h1>Hello, world!</h1>
                <p>Welcome to my website</p>
                <h1>Hello, world!</h1>
                <p>Welcome to my website</p>
                <h1>Hello, world!</h1>
                <p>Welcome to my website</p>
                <h1>Hello, world!</h1>
                <p>Welcome to my website</p>
                <h1>Hello, world!</h1>
                <p>Welcome to my website</p>
                </body>
                </html>
                """
            )
        }
    }
    .edgesIgnoringSafeArea(.bottom)
}
