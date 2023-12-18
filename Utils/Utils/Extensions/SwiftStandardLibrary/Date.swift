//
//  Date.swift
//  Utils
//
//  Created by Jmy on 2023/08/26.
//

import Foundation.NSDate

extension Date {
    func toString(dateFormat: String = "yyyy.MM.dd HH:mm:ss:SSS") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = .current // TimeZone(abbreviation: "GMT")
        dateFormatter.locale = .current
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: self)
    }

    // MARK: - Unix Timestamp

    static var timestamp: Date {
        return Date().millisecondsSince1970.toDate
    }

    var millisecondsSince1970: Int64 {
        return Int64((timeIntervalSince1970 * 1000).rounded())
    }
}
