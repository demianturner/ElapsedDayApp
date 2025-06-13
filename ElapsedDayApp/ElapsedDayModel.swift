import Foundation
import SwiftUI
import WidgetKit

struct ElapsedDayModel {
    static let defaultLabel = "Since..."
    static let defaultStartDate = Date()
    
    // Shared UserDefaults for communication between app and widget
    private static let appGroupID = "group.com.seagullsystems.ElapsedDayApp"
    private static let sharedDefaults = UserDefaults(suiteName: appGroupID) ?? UserDefaults.standard
    
    // Keys for storing data
    private static let startDateKey = "startDate"
    private static let labelKey = "label"
    
    static var startDate: Date {
        get {
            sharedDefaults.object(forKey: startDateKey) as? Date ?? defaultStartDate
        }
        set {
            sharedDefaults.set(newValue, forKey: startDateKey)
            refreshWidget()
        }
    }
    
    static var label: String {
        get {
            sharedDefaults.string(forKey: labelKey) ?? defaultLabel
        }
        set {
            sharedDefaults.set(newValue, forKey: labelKey)
            refreshWidget()
        }
    }
    
    /// Triggers widget refresh when data changes
    private static func refreshWidget() {
        WidgetCenter.shared.reloadTimelines(ofKind: "ElapsedDayWidget")
    }

    /// Returns the number of full days elapsed from startDate to now (ignoring time of day)
    static func daysElapsed(from date: Date = startDate, to now: Date = Date()) -> Int {
        let calendar = Calendar.current
        let startOfStartDate = calendar.startOfDay(for: date)
        let startOfNow = calendar.startOfDay(for: now)
        
        let components = calendar.dateComponents([.day], from: startOfStartDate, to: startOfNow)
        return max(0, components.day ?? 0)
    }
    
    /// Ensures the label is never empty
    static func effectiveLabel() -> String {
        return label.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? defaultLabel : label
    }
} 
