//
//  UtilsApp.swift
//  Utils
//
//  Created by Jmy on 2023/06/04.
//

import SwiftUI

@main
struct UtilsApp: App {
    @Environment(\.scenePhase) var phase

    var body: some Scene {
        WindowGroup {
            AnalogClock()
                .onAppear {
                    "onAppear".log(trait: .app)
                }
                .onDisappear {
                    "onDisappear".log(trait: .app)
                }
        }
        .onChange(of: phase) { newValue in
            if newValue == .active {
                "active".log(trait: .app)
            } else if newValue == .inactive {
                "inactive".log(trait: .app)
            } else if newValue == .background {
                "background".log(trait: .app)
            }
        }
        // inactive 상황에서 앱을 메모리에서 날리면 background
        // background 상황에서 앱을 메모리에서 날리면 onDisappear
    }
}
