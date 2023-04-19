//
//  NavigationApp.swift
//  Navigation
//
//  Created by Jmy on 2023/04/17.
//

import SwiftUI

@main
struct NavigationApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)

            RootView()
        }
    }
}
