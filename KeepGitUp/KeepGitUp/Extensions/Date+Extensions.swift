//
//  Date+Extensions.swift
//  KeepGitUp
//
//  Created by Jmy on 2023/11/23.
//

import Foundation

extension Date {
    func dayOfWeek() -> String {
        let dateFormatter = DateFormatter()
        let prefLanguage = Locale.preferredLanguages[0]

        dateFormatter.locale = NSLocale(localeIdentifier: prefLanguage) as Locale
        dateFormatter.dateFormat = "E"
        return dateFormatter.string(from: self).capitalized
    }

    func timeAgoSince() -> String {
        let calendar = Calendar.current
        let now = Date()

        let unitFlags: NSCalendar.Unit = [.day]
        let components = (calendar as NSCalendar).components(unitFlags, from: self, to: now, options: [])

        guard let day = components.day else { return "0" }

        return "\(day)"
    }
}
