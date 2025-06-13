# ElapsedDayApp

A minimalist iOS app with widget that displays the number of days elapsed since a user-selected date. Built with SwiftUI and WidgetKit.

## Overview

This app allows users to input a meaningful start date (e.g., sobriety, anniversary, job start), and then displays the number of days that have elapsed since that date. It includes a home screen widget for iOS and macOS (via Catalyst), refreshing daily.

## Features

### Main App
- **SwiftUI Interface**: Clean, minimalist design with DatePicker, TextField, and elapsed days display
- **Date Selection**: Choose any meaningful start date using the native date picker
- **Custom Labels**: Add a personal label (e.g., "Since Wedding", "Days Sober")
- **Live Updates**: See real-time calculation of elapsed days
- **Dark/Light Mode**: Full support for system appearance preferences

### Widget Extension  
- **Multiple Sizes**: Support for both Small and Medium widget sizes
- **Daily Refresh**: Automatically updates at midnight using `.atStartOfDay` timeline
- **Shared Data**: Uses App Group storage to sync between app and widget
- **Cross-Platform**: Works on both iOS and macOS (via Catalyst)

## Technical Details

### Tech Stack
- **UI Framework**: SwiftUI
- **Widget Framework**: WidgetKit  
- **Storage**: UserDefaults with App Group (`group.com.bunchoftext.ElapsedDayApp`)
- **Cross-Platform**: Mac Catalyst support
- **Date Logic**: Foundation `Calendar` APIs for accurate day calculations

### Architecture
- **Modular Design**: Separate shared data model for app and widget
- **App Group Storage**: Secure data sharing between main app and widget extension
- **Widget Sizes**: 
  - Small: Compact vertical layout with large day count
  - Medium: Horizontal layout with enhanced spacing

### Key Components
- `ElapsedDayModel`: Shared data model with App Group storage
- `MainView`: Main app interface with modular subviews
- `ElapsedDayWidget`: WidgetKit extension with size-adaptive layouts

## Platform Support

- ✅ iOS (iPhone & iPad)
- ✅ macOS (via Catalyst) 
- ✅ WidgetKit for both platforms

## Privacy & Storage

- **Fully Offline**: No internet connection required
- **Local Storage**: All data stored locally using UserDefaults
- **No Tracking**: No analytics, ads, or data collection
- **App Group**: Secure sharing between app and widget only

## Installation

1. Clone this repository
2. Open `ElapsedDayApp.xcodeproj` in Xcode
3. Build and run on your preferred simulator or device
4. Add the widget to your home screen via the widget gallery

## Usage

1. **Set Your Date**: Use the date picker to select your meaningful start date
2. **Add a Label**: Enter a personal label to remember what you're tracking
3. **View Progress**: See the elapsed days calculated in real-time
4. **Add Widget**: Long press on home screen → "+" → Search "ElapsedDayApp" → Choose size

## Development

### Build Requirements
- Xcode 15+
- iOS 17+ / macOS 14+
- Swift 5.9+

### Build Command
```bash
xcodebuild -project ElapsedDayApp.xcodeproj -scheme ElapsedDayApp -destination 'platform=iOS Simulator,name=iPhone 16' build
```

## Future Enhancements (v2)

- Support for multiple tracked dates
- Milestone notifications (e.g., 100 days, 1 year)
- Custom widget themes and colors
- Apple Watch complication support
- Export/share functionality

## License

This project is open source. Feel free to use, modify, and distribute as needed.
