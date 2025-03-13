# MoodSyncPomoDoro
MoodSync is a comprehensive mood tracking and focus management application that works seamlessly between your iPhone and Apple Watch. Stay in tune with your emotions while maintaining productivity through an intuitive interface and real-time synchronization.
![MoodSync App Banner](screenshots/banner.png)

## Features
### 🎯 Mood Tracking
- Real-time mood synchronization between iPhone and Apple Watch
- Four distinct mood states: Happy, Excited, Calm, and Sad
- Dynamic UI themes that adapt to your current mood
- Visual mood indicators with custom icons and colors
- Confetti celebration animations for mood changes

### ⏱️ Focus Timer (Pomodoro)
- 25-minute Pomodoro timer with elegant circular progress
- Play/Pause and Reset functionality
- Visual feedback with color-coded progress ring
- Perfect for maintaining productivity and focus

### 📊 Stats Dashboard
- Track daily focus time
- Monitor completed tasks
- Maintain streaks
- Energy level monitoring

### ⚙️ Settings & Connectivity
- Apple Watch connectivity status
- Focus mode toggle
- Customizable notifications
- Appearance settings
- Sound effects options

## Screenshots
### iPhone App
<table>
  <tr>
    <td><img src="screenshots/mood_screen.png" width="200" alt="Mood Screen"/></td>
    <td><img src="screenshots/focus_screen.png" width="200" alt="Focus Screen"/></td>
    <td><img src="screenshots/settings_screen.png" width="200" alt="Settings Screen"/></td>
  </tr>
</table>

### Apple Watch App
<table>
  <tr>
    <td><img src="screenshots/watch_mood.png" width="150" alt="Watch Mood Selection"/></td>
    <td><img src="screenshots/watch_settings.png" width="150" alt="Watch Settings"/></td>
  </tr>
</table>

## Technical Implementation
### iPhone App
- Built with SwiftUI
- Uses WatchConnectivity framework for device communication
- Implements ObservableObject pattern for state management
- Features dynamic theming based on mood states
- Includes custom animations and transitions

### Apple Watch App
- Native watchOS app with SwiftUI
- Real-time data synchronization with iPhone
- Haptic feedback for interactions
- Optimized for quick mood logging

## Requirements
- iOS 15.0 or later
- watchOS 8.0 or later
- Xcode 13.0 or later

## Installation
1. Clone the repository
```bash
git clone https://github.com/yourusername/MoodSync.git
```
2. Open the project in Xcode
```bash
cd MoodSync
open MoodSync.xcodeproj
```
3. Build and run the application on your device or simulator

## Demo Video
[![MoodSync Demo](screenshots/demo_thumbnail.png)](screenshots/demo.mov)

## Architecture
The app follows a clean architecture pattern with:
- SwiftUI for the UI layer
- ObservableObject for state management
- WatchConnectivity for device communication
- Custom managers for specific features (MoodThemeManager, PomodoroManager)

## Contributing
Contributions are welcome! Please feel free to submit a Pull Request.

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details

## Contact
Your Name - [@yourhandle](https://twitter.com/yourhandle)
Project Link: [https://github.com/yourusername/MoodSync](https://github.com/yourusername/MoodSync)
