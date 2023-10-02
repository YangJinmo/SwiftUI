//
//  AnalogClock.swift
//  Utils
//
//  Created by Jmy on 2023/10/01.
//

import SwiftUI

struct AnalogClock: View {
    @ObservedObject var time = CurrentTime()

    var body: some View {
        return ZStack {
            Text("\(time.seconds)")
        }
        .frame(width: 200, height: 200, alignment: .center)
    }
}

#Preview {
    AnalogClock()
}

import Combine
import SwiftUI

final class CurrentTime: ObservableObject {
    @Published var seconds: TimeInterval = CurrentTime.currentSecond(date: Date())

    private let timer = Timer.publish(every: 0.2, on: .main, in: .default).autoconnect()
    private var store = Set<AnyCancellable>()

    init() {
        timer.map(Self.currentSecond).assign(to: \.seconds, on: self).store(in: &store)
    }

    private static func currentSecond(date: Date) -> TimeInterval {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: date)
        let referenceDate = Calendar.current.date(from: DateComponents(year: components.year!, month: components.month!, day: components.day!))!
        return Date().timeIntervalSince(referenceDate)
    }
}
