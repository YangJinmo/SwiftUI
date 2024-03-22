//
//  CustomNavBarPreferenceKeys.swift
//  Utils
//
//  Created by Jmy on 3/22/24.
//

import SwiftUI

struct CustomNavBarTitlePreferenceKeys: PreferenceKey {
    static var defaultValue: String = ""

    static func reduce(value: inout String, nextValue: () -> String) {
        value = nextValue()
    }
}

struct CustomNavBarSubtitlePreferenceKeys: PreferenceKey {
    static var defaultValue: String?

    static func reduce(value: inout String?, nextValue: () -> String?) {
        value = nextValue()
    }
}

struct CustomNavBarBackButtonHiddenPreferenceKeys: PreferenceKey {
    static var defaultValue: Bool = false

    static func reduce(value: inout Bool, nextValue: () -> Bool) {
        value = nextValue()
    }
}

extension View {
    func customNavigationTitle(_ title: String) -> some View {
        preference(key: CustomNavBarTitlePreferenceKeys.self, value: title)
    }

    func customNavigationSubtitle(_ subtitle: String?) -> some View {
        preference(key: CustomNavBarSubtitlePreferenceKeys.self, value: subtitle)
    }

    func customNavigationBackButtonHidden(_ hidden: Bool) -> some View {
        preference(key: CustomNavBarBackButtonHiddenPreferenceKeys.self, value: hidden)
    }

    func customNavBarItems(title: String = "", subtitle: String? = nil, backButtonHidden: Bool = false) -> some View {
        customNavigationTitle(title)
            .customNavigationSubtitle(subtitle)
            .customNavigationBackButtonHidden(backButtonHidden)
    }
}
