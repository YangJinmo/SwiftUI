//
//  Int64.swift
//  Utils
//
//  Created by Jmy on 2023/08/28.
//

import Foundation

extension Int64 {
    static var timestamp: Int64 {
        return Date().millisecondsSince1970
    }

    var toDate: Date {
        return Date(timeIntervalSince1970: TimeInterval(self) / 1000)
    }

    var millisecondsToSeconds: Int64 {
        return self / 1000
    }

    var seconds: Int64 {
        return self % 60
    }

    var millisecondsToTimeString: String {
        let seconds = millisecondsToSeconds

        if seconds >= 60 {
            var timeString = ""

            timeString += "\(seconds / 60)분"

            if seconds % 60 > 0 {
                timeString += " \(seconds % 60)초"
            }

            return timeString
        } else {
            return "\(seconds)초"
        }
    }
}
