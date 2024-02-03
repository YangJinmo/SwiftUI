//
//  TabViewBootCamp.swift
//  Utils
//
//  Created by Jmy on 2/3/24.
//

import SwiftUI

struct TabViewBootCamp: View {
    @State private var selectedTab = TabIdentifier.todos

    var body: some View {
        TabView(
            selection: $selectedTab,
            content: {
                TodosView()
                    .tabItem {
                        VStack {
                            Image(systemName: "list.bullet")
                            Text("할일목록")
                        }
                    }
                    .tag(TabIdentifier.todos)
                ProfileView()
                    .tabItem {
                        VStack {
                            Image(systemName: "person.circle.fill")
                            Text("프로필")
                        }
                    }
                    .tag(TabIdentifier.profile)
            }
        )
        .onOpenURL(perform: { url in
            // 열려야 하는 URL 처리
            guard let tabID = url.tabIdentifier else { return }
            selectedTab = tabID
        })
    }
}

#Preview {
    TabViewBootCamp()
}

// 어떤 탭이 선택되었는지 여부
enum TabIdentifier: Hashable {
    case todos
    case profile
}

// 어떤 페이지를 보여줘야 하는지
enum PageIdentifier: Hashable {
    case todoItem(id: UUID)
}

extension URL {
    // info에서 추가한 딥링크가 들어왔는지 여부
    var isDeeplink: Bool {
        return scheme == "deeplink"
    }

    // url 들어오는 것으로 어떤 타입의 탭을 보여줘야 하는지 가져오기
    var tabIdentifier: TabIdentifier? {
        guard isDeeplink else { return nil }

        // deeplink://gogogo
        switch host {
        case "todos":
            return .todos
        case "profile":
            return .profile
        default:
            return nil
        }
    }

    var detailPage: PageIdentifier? {
        print("pathComponents: \(pathComponents)")

        // deeplink://gogogo/great
        guard
            let tabIdentifier = tabIdentifier,
            pathComponents.count > 1,
            let uuid = UUID(uuidString: pathComponents[1])
        else {
            return nil
        }

        switch tabIdentifier {
        case .todos:
            return .todoItem(id: uuid)
        default:
            return nil
        }
    }
}
