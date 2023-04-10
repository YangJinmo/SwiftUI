//
//  GridApp.swift
//  Grid
//
//  Created by Jmy on 2023/03/29.
//

import SwiftUI

@main
struct GridApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            LazyVStackView()
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
