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

    var milliseconds: Int {
        return Int(truncatingRemainder(dividingBy: 1) * 1000)
    }

    var seconds: Int {
        return Int(self) % 60
    }

    var minutes: Int {
        return (Int(self) / 60) % 60
    }

    var hours: Int {
        return Int(self) / 3600
    }
}
