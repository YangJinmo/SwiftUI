//
//  ContributeData.swift
//  KeepGitUp
//
//  Created by Jmy on 2023/11/23.
//

import Foundation

class ContributeData {
    let count: Int
    let weekend: String
    let date: String
    private var friendContributeData: ContributeData?

    init(count: Int, weekend: String, date: String) {
        self.count = count
        self.weekend = weekend
        self.date = date
    }

    private func getGoalCountString(_ goal: Int) -> String {
        return String(goal - count)
    }

    public func merge(contributeData: ContributeData) {
        friendContributeData = contributeData
    }
}
