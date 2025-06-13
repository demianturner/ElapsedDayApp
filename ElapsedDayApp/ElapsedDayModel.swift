import Foundation
import SwiftUI

struct ElapsedDayModel {
    static let appGroupID = "group.com.bunchoftext.ElapsedDayApp"
    static let defaultLabel = "Since..."
    static let defaultStartDate = Date()

    @AppStorage("startDate", store: UserDefaults(suiteName: appGroupID))
    static var startDate: Date = defaultStartDate

    @AppStorage("label", store: UserDefaults(suiteName: appGroupID))
    static var label: String = defaultLabel

    /// Returns the number of full days elapsed from startDate to now (ignoring time of day)
    static func daysElapsed(from date: Date = startDate, to now: Date = Date()) -> Int {
        let calendar = Calendar.current
        let startOfStartDate = calendar.startOfDay(for: date)
        let startOfNow = calendar.startOfDay(for: now)
        let components = calendar.dateComponents([.day], from: startOfStartDate, to: startOfNow)
        return components.day ?? 0
    }

    /// Ensures label is never empty
    static func validatedLabel(_ label: String) -> String {
        label.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? defaultLabel : label
    }
} 