# Elapsed Day Widget App – Product Requirements Document (PRD)

## Overview

This app allows users to input a meaningful start date (e.g., sobriety, anniversary, job start), and then displays the number of days that have elapsed since that date. It includes a home screen widget for iOS and macOS (via Catalyst), refreshing daily.

---

## Goals

- Allow the user to pick a date via a date picker.
- Persist the selected date across app launches and platform sessions.
- Display a widget showing the number of days elapsed since the saved date.
- Support both iOS Home Screen and macOS Notification Center via WidgetKit.
- Keep the app simple, private, and fully offline.

---

## Platform Targets

- ✅ iOS (iPhone & iPad)
- ✅ macOS (via Catalyst)
- ✅ WidgetKit for both iOS & macOS

---

## User Stories

- As a user, I want to pick a meaningful date using a calendar interface.
- As a user, I want the app to remember this date permanently.
- As a user, I want to see how many days have passed since that date in a glanceable widget.
- As a user, I want the widget to be available on both my iPhone and Mac.

---

## Features

### App Functionality

- One-screen SwiftUI app
- UIDatePicker to select a start date
- Display of elapsed days in text
- Optional label input (e.g., “Since: Wedding”)
- Persist values in `AppStorage` or `UserDefaults`

### Widget Functionality

- Small-sized WidgetKit extension
- Updates daily using `.atStartOfDay`
- Displays:
  - Day count (e.g., `437 Days`)
  - Optional user-defined label

---

## Data Storage

- Use `@AppStorage` or `UserDefaults(suiteName:)` for persistence
- Shared App Group between app and widget
- No iCloud or external storage

```swift
@AppStorage("startDate", store: UserDefaults(suiteName: "group.com.bunchoftext.ElapsedDayApp")) var startDate: Date
```

---

## Tech Stack

| Area           | Tool/Library                  |
|----------------|-------------------------------|
| UI             | SwiftUI                       |
| Widget         | WidgetKit                     |
| Storage        | UserDefaults (App Group)      |
| Cross-platform | Catalyst                      |
| Date Logic     | Foundation `Calendar` APIs    |

---

## App Group Setup

- Define a shared App Group identifier in Xcode (e.g., `group.com.bunchoftext.ElapsedDayApp`)
- Use it for reading/writing from both widget and main app

---

## Widget Details

- Widget kind: Static configuration
- Timeline: `.atStartOfDay` for daily updates
- Widget family: `.systemSmall` (v1 only)
- Widget content:
  - Large day count (`Text("\(days) Days")`)
  - Optional label (`Text(label)`)

Example SwiftUI layout:
```swift
VStack {
    Text("\(days) Days").font(.largeTitle).bold()
    if let label = label {
        Text("Since \(label)").font(.caption)
    }
}
```

---

## Design

- Minimalist, glanceable widget design
- Dark/light mode compatible
- Optional: Include SF Symbol (e.g., `calendar` or `clock`)
- Padding and scaling for both iOS and macOS widget constraints

---

## Stretch Goals (v2)

- Support for multiple dates (e.g., swipeable widget variants)
- User-defined color themes
- Push/local notifications for milestone counts (e.g., 100 days)
- Apple Watch support

---

## Out of Scope (v1)

- iCloud sync
- User accounts or login
- Android or web versions
- Hour-by-hour countdowns
- Background refresh more than once daily

---

## Next Steps

1. Set up App Group and shared container.
2. Build single-screen app with `DatePicker`, `TextField`, and `Text`.
3. Create WidgetKit extension and configure daily refresh.
4. Share data using `UserDefaults(suiteName:)`.
5. Test across iPhone, iPad, and Mac via Catalyst.
