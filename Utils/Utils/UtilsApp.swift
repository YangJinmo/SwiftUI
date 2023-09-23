//
//  UtilsApp.swift
//  Utils
//
//  Created by Jmy on 2023/06/04.
//

import SwiftUI

@main
struct UtilsApp: App {
    var body: some Scene {
        WindowGroup {
            ViewControllerRepresentable {
                CollectionViewBootCamp()
            }
        }
    }
}
