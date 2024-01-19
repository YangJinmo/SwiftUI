//
//  MonthlyWidget.swift
//  MonthlyWidget
//
//  Created by Jmy on 2023/12/05.
//

import SwiftUI
import WidgetKit

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> DayEntry {
        DayEntry(date: .now)
    }

    func getSnapshot(in context: Context, completion: @escaping (DayEntry) -> Void) {
        let entry = DayEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> Void) {
        var entries: [DayEntry] = []

        // Generate a timeline consisting of seven entries an day apart, starting from the current date.
        let currentDate = Date()
        for dayOffset in 0 ..< 7 {
            let entryDate = Calendar.current.date(byAdding: .day, value: dayOffset, to: currentDate)!
            let startOfDate = Calendar.current.startOfDay(for: entryDate)
            let entry = DayEntry(date: startOfDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct DayEntry: TimelineEntry {
    let date: Date
}

struct MonthlyWidgetEntryView: View {
    var entry: Provider.Entry
    var config: MonthConfig

    init(entry: Provider.Entry) {
        self.entry = entry
        config = MonthConfig.determineConfig(from: entry.date)
    }

    var body: some View {
        VStack {
            HStack {
                Text(config.emojiText)
                    .font(.title)

                Text(entry.date.weekdayDisplayFormat)
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .minimumScaleFactor(0.6)
                    .foregroundColor(config.weekdayTextColor)

                Spacer()
            }

            Text(entry.date.dayDisplayFormat)
                .font(.system(size: 80, weight: .heavy))
                .foregroundColor(config.dayTextColor)

            // Text(entry.date, style: .time)
        }
        .containerBackground(for: .widget) {
            ContainerRelativeShape()
                .fill(config.backgroundColor.gradient)
        }
    }
}

struct MonthlyWidget: Widget {
    let kind: String = "MonthlyWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            MonthlyWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Monthly Style Widget")
        .description("The theme of the widget changes based on month.")
        .supportedFamilies([.systemSmall])
        .containerBackgroundRemovable(false)
    }
}

#Preview(as: .systemSmall) {
    MonthlyWidget()
} timeline: {
    // DayEntry(date: .now)
    DayEntry(date: .dateToDisplay(month: 5, day: 22))
}

extension Date {
    var weekdayDisplayFormat: String {
        formatted(.dateTime.weekday(.wide))
    }

    var dayDisplayFormat: String {
        formatted(.dateTime.day())
    }

    static func dateToDisplay(month: Int, day: Int) -> Date {
        let components = DateComponents(
            calendar: Calendar.current,
            year: 2024,
            month: month,
            day: day
        )

        return Calendar.current.date(from: components)!
    }
}
