//
//  ElapsedDayWidget.swift
//  ElapsedDayWidget
//
//  Created by Demian Turner on 13/06/2025.
//

import WidgetKit
import SwiftUI

struct ElapsedDayProvider: TimelineProvider {
    func placeholder(in context: Context) -> ElapsedDayEntry {
        ElapsedDayEntry(date: Date(), daysElapsed: 0, label: "Since...")
    }

    func getSnapshot(in context: Context, completion: @escaping (ElapsedDayEntry) -> ()) {
        let entry = createEntry()
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<ElapsedDayEntry>) -> ()) {
        let entry = createEntry()
        
        // Refresh at start of next day
        let calendar = Calendar.current
        let tomorrow = calendar.date(byAdding: .day, value: 1, to: Date())!
        let startOfTomorrow = calendar.startOfDay(for: tomorrow)
        
        let timeline = Timeline(entries: [entry], policy: .after(startOfTomorrow))
        completion(timeline)
    }
    
    private func createEntry() -> ElapsedDayEntry {
        let userDefaults = UserDefaults(suiteName: ElapsedDayModel.appGroupID)
        
        let startDate = userDefaults?.object(forKey: "startDate") as? Date ?? ElapsedDayModel.defaultStartDate
        let label = userDefaults?.string(forKey: "label") ?? ElapsedDayModel.defaultLabel
        
        let daysElapsed = ElapsedDayModel.daysElapsed(from: startDate)
        
        return ElapsedDayEntry(
            date: Date(),
            daysElapsed: daysElapsed,
            label: ElapsedDayModel.validatedLabel(label)
        )
    }
}

struct ElapsedDayEntry: TimelineEntry {
    let date: Date
    let daysElapsed: Int
    let label: String
}

struct ElapsedDayWidgetView: View {
    var entry: ElapsedDayProvider.Entry
    @Environment(\.widgetFamily) var family

    var body: some View {
        switch family {
        case .systemSmall:
            SmallWidgetView(entry: entry)
        case .systemMedium:
            MediumWidgetView(entry: entry)
        default:
            SmallWidgetView(entry: entry)
        }
    }
}

private struct SmallWidgetView: View {
    let entry: ElapsedDayEntry
    
    var body: some View {
        VStack(spacing: 8) {
            Text(entry.label)
                .font(.caption)
                .fontWeight(.medium)
                .foregroundStyle(.secondary)
                .lineLimit(2)
                .multilineTextAlignment(.center)
            
            Spacer()
            
            VStack(spacing: 4) {
                Text("\(entry.daysElapsed)")
                    .font(.system(size: 36, weight: .bold, design: .rounded))
                    .foregroundStyle(.primary)
                
                Text(entry.daysElapsed == 1 ? "day" : "days")
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

private struct MediumWidgetView: View {
    let entry: ElapsedDayEntry
    
    var body: some View {
        HStack(spacing: 16) {
            VStack(alignment: .leading, spacing: 8) {
                Text(entry.label)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.primary)
                    .lineLimit(2)
                
                Text("Days elapsed")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            VStack(spacing: 4) {
                Text("\(entry.daysElapsed)")
                    .font(.system(size: 48, weight: .bold, design: .rounded))
                    .foregroundStyle(.primary)
                
                Text(entry.daysElapsed == 1 ? "day" : "days")
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundStyle(.secondary)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct ElapsedDayWidget: Widget {
    let kind: String = "ElapsedDayWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: ElapsedDayProvider()) { entry in
            ElapsedDayWidgetView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .configurationDisplayName("Elapsed Days")
        .description("Shows the number of days elapsed since your chosen date.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

#Preview(as: .systemSmall) {
    ElapsedDayWidget()
} timeline: {
    ElapsedDayEntry(date: .now, daysElapsed: 42, label: "Since Wedding")
    ElapsedDayEntry(date: .now, daysElapsed: 100, label: "Since...")
    ElapsedDayEntry(date: .now, daysElapsed: 1, label: "Since New Job")
}

#Preview(as: .systemMedium) {
    ElapsedDayWidget()
} timeline: {
    ElapsedDayEntry(date: .now, daysElapsed: 42, label: "Since Wedding")
    ElapsedDayEntry(date: .now, daysElapsed: 100, label: "Since...")
    ElapsedDayEntry(date: .now, daysElapsed: 1, label: "Since New Job")
}
