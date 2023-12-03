//
//  AppIntent.swift
//  KeepGitUpWidget
//
//  Created by Jmy on 2023/12/01.
//

import WidgetKit
import AppIntents

struct ConfigurationAppIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "Configuration"
    static var description = IntentDescription("This is an example widget.")

    // An example configurable parameter.
    @Parameter(title: "Favorite Emoji", default: "😃🐲🐇")
    var favoriteEmoji: String
}
