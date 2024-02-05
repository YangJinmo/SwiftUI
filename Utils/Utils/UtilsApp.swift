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
    @State private var oldScenePhase = ScenePhase.active
    /// State Object, Contains Whole App Data And Passes it VIA Enviroment Object
    @StateObject private var appData: AppData = .init()

    var body: some Scene {
        WindowGroup {
            Home()
                .onAppear {
                    "onAppear".log(trait: .app)
                }
                .onDisappear {
                    "onDisappear".log(trait: .app)
                }
                .onOpenURL { url in
                    print("URL: \(url)")
                }
                .onContinueUserActivity("what") { userActivity in
                    if let thing = userActivity.userInfo?["something"] as? String {
                        print("Get \(thing)")
                    }
                }
                .environmentObject(appData)
                /// Called When Deep Link was Triggered
                .onOpenURL { url in
                    let string = url.absoluteString.replacingOccurrences(of: "deeplink://", with: "")
                    print(string)

                    /// Spliting URL Component's
                    let components = string.components(separatedBy: "?")

                    for component in components {
                        if component.contains("tab=") {
                            /// Tab Change Request
                            let tabRawValue = component.replacingOccurrences(of: "tab=", with: "")
                            print(tabRawValue)

                            if let requestedTab = Tab.convert(from: tabRawValue) {
                                appData.activeTab = requestedTab
                            }
                        }

                        /// Navigation will only be updated if the link contains or specifies which tab navigation needs to be changed.
                        if component.contains("nav=") && string.contains("tab") {
                            /// Nav Change Request
                            let requestedNavPath = component
                                .replacingOccurrences(of: "nav=", with: "")
                                .replacingOccurrences(of: "_", with: " ")

                            print(requestedNavPath)

                            switch appData.activeTab {
                            case .home:
                                if let navPath = HomeStack.convert(from: requestedNavPath) {
                                    appData.homeNavStack.append(navPath)
                                }
                            case .favourites:
                                // deeplink://tab=favourites?nav=jenna29
                                if let navPath = FavouriteStack.convert(from: requestedNavPath) {
                                    appData.favouriteNavStack.append(navPath)
                                }
                            case .settings:
                                // deeplink://tab=settings?nav=terms_of_service
                                if let navPath = SettingStack.convert(from: requestedNavPath) {
                                    appData.settingNavStack.append(navPath)
                                }
                            }
                        }
                    }
                }
        }
        .onChange(of: phase) { newScenePhase in
            if newScenePhase == .active {
                "active".log(trait: .app)
                "Start app usage".log(trait: .app)
            } else if newScenePhase == .inactive {
                "inactive".log(trait: .app)
            } else if newScenePhase == .background {
                "background".log(trait: .app)
            }

            if oldScenePhase == .active, newScenePhase == .inactive {
                "End app usage".log(trait: .app)
            }

            oldScenePhase = newScenePhase
        }

        // MARK: Scene Phase

        // 앱 사용 시간
        // 유저가 앱을 시작한 시간부터 앱을 사용하지 않는 시간을 찾으면 우리는 유저가 앱을 사용한 시간을 찾을 수 있다.
        // inactive는 active에서 background로 이동 시, background에서 active로 이동 시 두 경우 모두 호출되기 때문에
        // 우리에게 필요한 앱 사용 종료를 의미하는 값은 active에서 inactive가 될 경우이다.
        // 앱 사용 시작: active
        // 앱 사용 종료: active -> inactive (이전 상태가 active일 때, inactive가 호출된 시점)
        // 현재 scenePhase를 저장하고 inactive 호출 시, 만약 저장된 scenePhase가 active일 경우를
        // 유저의 앱 사용 종료로 볼 수 있다.

        // 앱 메모리 해제
        // background 상태에서 앱을 메모리에서 날리면 onDisappear가 정상적으로 불리고
        // inactive 상태에서 앱을 메모리에서 날리면 background까지는 불리지만 onDisappear까지는 불리지 않는다.
        // 따라서, 첫번째 경우를 제외하면, 앱이 메모리에서 날아가는 상황을 감지하기 위해서는 추가 작업이 필요할 것으로 보인다.
    }
}
