//
//  WebViewModel.swift
//  WebView
//
//  Created by Jmy on 2023/05/27.
//

import Combine
import Foundation

class WebViewModel: ObservableObject {
    var foo = PassthroughSubject<Bool, Never>()
    var bar = PassthroughSubject<Bool, Never>()
}
