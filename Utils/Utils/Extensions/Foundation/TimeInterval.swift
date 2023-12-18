//
//  TimeInterval.swift
//  Utils
//
//  Created by Jmy on 2023/12/19.
//

import Foundation.NSDate

extension TimeInterval {
    static var unixTime: TimeInterval {
        return Date().timeIntervalSince1970
    }

    var toDate: Date {
        return Date(timeIntervalSince1970: self)
    }
}
