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

#Preview {
    JMView {
        Text("Naver")
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
            JMWebView(htmlString: sampleHTML)
        }
    }
    .edgesIgnoringSafeArea(.bottom)
}

struct JMWebNavigationLink<Label>: View where Label: View {
    let title: String
    let url: URL
    @ViewBuilder var label: () -> Label
    @State private var isPresented: Bool = false

    init(
        title: String,
        url: URL,
        @ViewBuilder label: @escaping () -> Label
    ) {
        self.title = title
        self.url = url
        self.label = label
    }

    var body: some View {
        NavigationLink(isActive: $isPresented) {
            JMView(.navigation, $isPresented) {
                Text(title)
            } content: {
                LazyView(
                    ViewRepresentable {
                        JMWebView(url: url)
                    }
                )
            }
            .edgesIgnoringSafeArea(.bottom)
        } label: {
            label()
        }
    }
}

#Preview {
    NavigationView {
        JMWebNavigationLink(title: "Naver", url: "https://www.naver.com".toURL!) {
            Text("Naver")
        }
    }
}

struct JMHTMLWebNavigationLink<Label>: View where Label: View {
    let title: String
    let html: String
    @ViewBuilder var label: () -> Label

    @State private var isActiving: Bool = false

    init(
        title: String,
        html: String,
        @ViewBuilder label: @escaping () -> Label
    ) {
        self.title = title
        self.html = html
        self.label = label
    }

    var body: some View {
        NavigationLink(isActive: $isActiving) {
            JMView(.navigation, $isActiving) {
                Text(title)
            } content: {
                ViewRepresentable {
                    JMWebView(htmlString: html)
                }
            }
            .edgesIgnoringSafeArea(.bottom)
        } label: {
            label()
        }
    }
}

#Preview {
    NavigationView {
        JMHTMLWebNavigationLink(
            title: "Hello, world!",
            html: sampleHTML
        ) {
            Text("HTML")
        }
    }
}

let sampleHTML = """
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

struct NavigationSheet<Destination: View, Label: View>: View {
    @State private var isPresented: Bool = false

    @ViewBuilder var destination: () -> Destination
    @ViewBuilder var label: () -> Label
    private var onDismiss: (() -> Void)?

    init(
        @ViewBuilder destination: @escaping () -> Destination,
        @ViewBuilder label: @escaping () -> Label,
        onDismiss: (() -> Void)? = nil
    ) {
        self.destination = destination
        self.label = label
        self.onDismiss = onDismiss
    }

    var body: some View {
        Button {
            isPresented.toggle()
        } label: {
            label()
        }
        .sheet(isPresented: $isPresented, onDismiss: onDismiss) {
            destination()
        }
    }
}

@available(iOS 16.0, *)
struct NavigationPush<Destination: View, Label: View>: View {
    @State private var isPresented: Bool = false

    @ViewBuilder var destination: () -> Destination
    @ViewBuilder var label: () -> Label
    private var onDismiss: (() -> Void)?

    init(
        @ViewBuilder destination: @escaping () -> Destination,
        @ViewBuilder label: @escaping () -> Label,
        onDismiss: (() -> Void)? = nil
    ) {
        self.destination = destination
        self.label = label
        self.onDismiss = onDismiss
    }

    var body: some View {
        Button {
            isPresented.toggle()
        } label: {
            label()
        }
        .navigationDestination(isPresented: $isPresented) {
            destination()
        }
    }
}
