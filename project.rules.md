# Project Rules – Elapsed Day Widget App

## 🧭 Scope & Purpose
- The app displays the number of days elapsed since a user-selected date.
- Users can optionally label the date (e.g., "Since Wedding").
- It must run on both iOS and macOS (via Catalyst).
- No login, no sync, no cloud — local-only data storage.
- A WidgetKit widget must reflect the current elapsed day count.

## 📱 Platform Rules
- The app is an **iOS project**, with **Mac Catalyst** enabled.
- A **WidgetKit extension** must be included and target both iOS and macOS.
- Do **not** use Multiplatform SwiftUI template (macOS must be Catalyst-based).

## 📦 Features
- One screen with:
  - DatePicker to select the starting date.
  - TextField to enter a short label.
  - Text showing the number of days since that date.
- Values must persist across launches using UserDefaults or @AppStorage.

## 📆 Widget
- Widget size: `.systemSmall` only.
- Displays:
  - Elapsed days in large font.
  - Optional label in smaller font.
- Uses `.atStartOfDay` for daily timeline refresh.
- Uses VStack with adaptive layout for both platforms.

## 🔒 Storage
- Use a shared App Group: `group.com.bunchoftext.ElapsedDayApp`.
- Persist `startDate` and `label` using:

    @AppStorage("startDate", store: UserDefaults(suiteName: "group.com.yourcompany.elapsed"))
    var startDate: Date

- No iCloud, no Keychain, no syncing.

## 🧱 Architecture
- SwiftUI for all views and widgets.
- No third-party libraries.
- Code should be modular: widget and app logic clearly separated.
- All functionality must run offline.

## 🎨 Design
- Minimalist UI with no images, gradients, or animations.
- SF Symbols allowed (e.g., `calendar`, `clock`).
- Support light and dark mode.

## ❌ Out of Scope (v1)
- iCloud or multi-device sync.
- Multiple tracked dates.
- Notifications or reminders.
- Apple Watch version.
- Background refresh more than once daily.
- Any internet connectivity features.

## ✅ Stretch Goals for v2 (Document Only)
- Milestone alerts (e.g., 100 days).
- Multiple dates.
- Widget theming.
- Apple Watch support.
