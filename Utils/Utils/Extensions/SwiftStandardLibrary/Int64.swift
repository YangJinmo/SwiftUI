//
//  Int64.swift
//  Utils
//
//  Created by Jmy on 2023/08/28.
//

import Foundation

extension Int64 {
    var millisecondsToSeconds: Int64 {
        return self / 1000
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
