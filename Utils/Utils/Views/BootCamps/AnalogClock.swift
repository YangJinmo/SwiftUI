//
//  AnalogClock.swift
//  Utils
//
//  Created by Jmy on 2023/10/01.
//

import SwiftUI

struct AnalogClock: View {
    @ObservedObject var time = CurrentTime()

    func tick(at tick: Int) -> some View {
        VStack {
            Rectangle()
                .fill(Color.primary)
                .opacity(tick % 5 == 0 ? 1 : 0.4)
                .frame(width: 2, height: tick % 5 == 0 ? 15 : 7)

            Spacer()
        }
        .rotationEffect(Angle.degrees(Double(tick) / 60 * 360))
    }

    var body: some View {
        ZStack {
            ForEach(0 ..< 60) { tick in
                self.tick(at: tick)
            }

            GeometryReader { geometry in
                ZStack {
                    HStack(spacing: 0) {
                        Text("9")

                        Spacer()

                        Text("3")
                    }

                    VStack(spacing: 0) {
                        Text("12")

                        Spacer()

                        Text("6")
                    }
                }
                .frame(width: geometry.size.width - 36, height: geometry.size.height - 30, alignment: .center)
                .offset(.init(width: 18, height: 15))
            }

            Clock(model: .init(type: .hour, timeInterval: time.seconds, tickScale: 0.4))
                .stroke(Color.primary, style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round))
                .rotationEffect(Angle.degrees(360 / 60))

            Clock(model: .init(type: .minute, timeInterval: time.seconds, tickScale: 0.6))
                .stroke(Color.blue, style: StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round))
                .rotationEffect(Angle.degrees(360 / 60))

            Clock(model: .init(type: .second, timeInterval: time.seconds, tickScale: 0.8))
                .stroke(Color.red, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                .rotationEffect(Angle.degrees(360 / 60))
        }
        .frame(width: 200, height: 200, alignment: .center)
    }
}

struct AnalogClock_Previews: PreviewProvider {
    static var previews: some View {
        AnalogClock()
    }
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

struct Clock: Shape {
    var model: ClockTickerModel

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let length = rect.width / 2
        let center = CGPoint(x: rect.midX, y: rect.midY)

        path.move(to: center)
        let hoursAngle = CGFloat.pi / 2 - .pi * 2 * model.angleMultiplier
        path.addLine(to: CGPoint(x: rect.midX + cos(hoursAngle) * length * model.tickerScale,
                                 y: rect.midY - sin(hoursAngle) * length * model.tickerScale))
        return path
    }
}

struct ClockTickerModel {
    enum TickerType {
        case second
        case hour
        case minute
    }

    let type: TickerType
    let timeInterval: TimeInterval
    let tickScale: CGFloat

    var angleMultiplier: CGFloat {
        switch type {
        case .second:
            return CGFloat(timeInterval.remainder(dividingBy: 60)) / 60
        case .hour:
            return CGFloat(timeInterval / 3600) / 12
        case .minute:
            return CGFloat((timeInterval - Double(Int(timeInterval / 3600) * 3600)) / 60) / 60
        }
    }

    var tickerScale: CGFloat {
        switch type {
        case .second:
            return 0.8
        case .hour:
            return 0.4
        case .minute:
            return 0.6
        }
    }
}
