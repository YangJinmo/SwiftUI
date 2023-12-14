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
        DayEntry(date: Date(), emoji: "😀")
    }

    func getSnapshot(in context: Context, completion: @escaping (DayEntry) -> Void) {
        let entry = DayEntry(date: Date(), emoji: "😀")
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> Void) {
        var entries: [DayEntry] = []

        // Generate a timeline consisting of seven entries an day apart, starting from the current date.
        let currentDate = Date()
        for dayOffset in 0 ..< 7 {
            let entryDate = Calendar.current.date(byAdding: .day, value: dayOffset, to: currentDate)!
            let entry = DayEntry(date: entryDate, emoji: "😀")
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct DayEntry: TimelineEntry {
    let date: Date
    let emoji: String
}

struct MonthlyWidgetEntryView: View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            HStack {
//                Text(entry.emoji)
//                    .font(.title)

                Text(entry.date.weekdayDisplayFormat)
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .minimumScaleFactor(0.6)
                    .foregroundColor(.black.opacity(0.6))

//                Spacer()
            }

            Text(entry.date.dayDisplayFormat)
                .font(.system(size: 80, weight: .heavy))
                .foregroundColor(.white.opacity(0.8))

//            Text(entry.date, style: .time)
        }
    }
}

struct MonthlyWidget: Widget {
    let kind: String = "MonthlyWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                MonthlyWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                MonthlyWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

#Preview(as: .systemSmall) {
    MonthlyWidget()
} timeline: {
    DayEntry(date: .now, emoji: "😀")
    DayEntry(date: .now, emoji: "🤩")
}

extension Date {
    var weekdayDisplayFormat: String {
        formatted(.dateTime.weekday(.wide))
    }

    var dayDisplayFormat: String {
        formatted(.dateTime.day())
    }
}