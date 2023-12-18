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
        dateFormatter.locale = .current // Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: self)
    }
}
