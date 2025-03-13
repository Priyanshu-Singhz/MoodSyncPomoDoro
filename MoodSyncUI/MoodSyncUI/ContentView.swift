//
//  ContentView.swift
//  MoodSyncUI
//
//  Created by Priyanshu Singh on 13/03/25.
//

import SwiftUI
import WatchConnectivity

class MoodThemeManager: ObservableObject {
    @Published var currentMood: Int = 50
    @Published var isWatchConnected = false
    
    init() {
        // Listen for mood updates from Watch
        NotificationCenter.default.addObserver(forName: .init("MoodUpdated"),
                                            object: nil,
                                            queue: .main) { notification in
            if let mood = notification.object as? Int {
                self.currentMood = mood
                self.isWatchConnected = true
            }
        }
    }
    
    // Theme properties based on mood
    var backgroundGradient: LinearGradient {
        switch currentMood {
        case 0...25:
            return LinearGradient(colors: [.gray.opacity(0.6), .blue.opacity(0.3)],
                                startPoint: .topLeading, endPoint: .bottomTrailing)
        case 26...50:
            return LinearGradient(colors: [.mint.opacity(0.6), .green.opacity(0.3)],
                                startPoint: .topLeading, endPoint: .bottomTrailing)
        case 51...75:
            return LinearGradient(colors: [.orange.opacity(0.6), .yellow.opacity(0.3)],
                                startPoint: .topLeading, endPoint: .bottomTrailing)
        default:
            return LinearGradient(colors: [.pink.opacity(0.6), .purple.opacity(0.3)],
                                startPoint: .topLeading, endPoint: .bottomTrailing)
        }
    }
    
    var moodIcon: String {
        switch currentMood {
        case 0...25: return "cloud.rain"
        case 26...50: return "leaf.fill"
        case 51...75: return "star.fill"
        default: return "face.smiling"
        }
    }
    
    var moodText: String {
        switch currentMood {
        case 0...25: return "Sad"
        case 26...50: return "Calm"
        case 51...75: return "Excited"
        default: return "Happy"
        }
    }
    
    var cardColor: Color {
        switch currentMood {
        case 0...25: return .blue
        case 26...50: return .green
        case 51...75: return .orange
        default: return .purple
        }
    }
    
    var buttonStyle: some ShapeStyle {
        switch currentMood {
        case 0...25: return .blue
        case 26...50: return .teal
        case 51...75: return .orange
        default: return .pink
        }
    }
}

class PomodoroManager: ObservableObject {
    @Published var isRunning = false
    @Published var progress: CGFloat = 0
    @Published var timeRemaining = 25 * 60 // 25 minutes in seconds
    private var timer: Timer?
    
    func toggleTimer() {
        if isRunning {
            stopTimer()
        } else {
            startTimer()
        }
    }
    
    func startTimer() {
        isRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
                self.progress = CGFloat(1500 - self.timeRemaining) / 1500
            } else {
                self.stopTimer()
            }
        }
    }
    
    func stopTimer() {
        isRunning = false
        timer?.invalidate()
        timer = nil
    }
    
    func resetTimer() {
        stopTimer()
        timeRemaining = 25 * 60
        progress = 0
    }
}

struct ContentView: View {
    @StateObject private var themeManager = MoodThemeManager()
    @StateObject private var sessionDelegate = SessionDelegate.shared
    @StateObject private var pomodoroManager = PomodoroManager()
    @State private var showConfetti = false
    private let session: WCSession = .default
    private let confettiColors: [Color] = [.red, .blue, .green, .yellow, .purple, .orange]
    
    init() {
        if WCSession.isSupported() {
            session.delegate = SessionDelegate.shared
            session.activate()
        }
    }
    
    var body: some View {
        TabView {
            // Mood Tab
            moodView
                .tabItem {
                    Label("Mood", systemImage: "heart.fill")
                }
            
            // Pomodoro Tab
            pomodoroView
                .tabItem {
                    Label("Focus", systemImage: "timer")
                }
            
            // Settings Tab
            settingsView
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
        .onChange(of: themeManager.currentMood) { _ in
            showConfetti = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                showConfetti = false
            }
        }
    }
    
    private var moodView: some View {
        ZStack {
            themeManager.backgroundGradient.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 20) {
                    // Watch connection status remains the same
                    
                    // Mood Card
                    VStack(spacing: 15) {
                        Image(systemName: themeManager.moodIcon)
                            .font(.system(size: 80))
                            .foregroundColor(.white)
                        
                        Text(themeManager.moodText)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 40)
                    .background(
                        RoundedRectangle(cornerRadius: 25)
                            .fill(themeManager.cardColor.opacity(0.3))
                            .shadow(radius: 10)
                    )
                    .padding(.horizontal)
                    
                    // Mood Stats
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                        statsCard(title: "Focus Time", value: "2h 30m", icon: "brain.head.profile")
                        statsCard(title: "Tasks Done", value: "12", icon: "checkmark.circle")
                        statsCard(title: "Streak", value: "5 days", icon: "flame.fill")
                        statsCard(title: "Energy", value: "High", icon: "bolt.fill")
                    }
                    .padding()
                }
            }
            
            // Confetti overlay
            if showConfetti {
                Canvas { context, size in
                    // Add simple confetti animation
                    for _ in 0..<50 {
                        let x = CGFloat.random(in: 0...size.width)
                        let y = CGFloat.random(in: 0...size.height)
                        context.fill(
                            Path(ellipseIn: CGRect(x: x, y: y, width: 8, height: 8)),
                            with: .color(confettiColors.randomElement() ?? .red)
                        )
                    }
                }
                .ignoresSafeArea()
            }
        }
    }
    
    private var pomodoroView: some View {
        ZStack {
            themeManager.backgroundGradient.ignoresSafeArea()
            
            VStack(spacing: 30) {
                // Timer Display
                ZStack {
                    Circle()
                        .stroke(lineWidth: 20)
                        .opacity(0.3)
                        .foregroundColor(Color.gray)
                    
                    Circle()
                        .trim(from: 0, to: pomodoroManager.progress)
                        .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                        .foregroundColor(themeManager.cardColor)
                        .rotationEffect(Angle(degrees: -90))
                    
                    VStack {
                        Text("\(pomodoroManager.timeRemaining / 60):\(String(format: "%02d", pomodoroManager.timeRemaining % 60))")
                            .font(.system(size: 50, weight: .bold, design: .rounded))
                        Text(pomodoroManager.isRunning ? "Focus Time" : "Take a Break")
                            .font(.title3)
                    }
                    .foregroundColor(.white)
                }
                .frame(width: 300, height: 300)
                
                // Controls
                HStack(spacing: 30) {
                    Button(action: pomodoroManager.resetTimer) {
                        Image(systemName: "arrow.clockwise")
                            .font(.title)
                    }
                    
                    Button(action: pomodoroManager.toggleTimer) {
                        Image(systemName: pomodoroManager.isRunning ? "pause.fill" : "play.fill")
                            .font(.title)
                    }
                }
                .foregroundColor(.white)
            }
        }
    }
    
    private var settingsView: some View {
        ZStack {
            themeManager.backgroundGradient.ignoresSafeArea()
            
            VStack(spacing: 20) {
                // Watch Connection
                connectionCard
                
                // Focus Mode Toggle
                toggleCard
                
                // Other settings...
                Group {
                    settingsRow(title: "Notifications", icon: "bell.fill")
                    settingsRow(title: "Appearance", icon: "paintbrush.fill")
                    settingsRow(title: "Sound Effects", icon: "speaker.wave.2.fill")
                    settingsRow(title: "About", icon: "info.circle.fill")
                }
            }
            .padding()
        }
    }
    
    private func statsCard(title: String, value: String, icon: String) -> some View {
        VStack(spacing: 10) {
            Image(systemName: icon)
                .font(.title2)
            Text(value)
                .font(.title3)
                .fontWeight(.bold)
            Text(title)
                .font(.caption)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.white.opacity(0.2))
        .cornerRadius(15)
    }
    
    private func settingsRow(title: String, icon: String) -> some View {
        HStack {
            Image(systemName: icon)
            Text(title)
            Spacer()
            Image(systemName: "chevron.right")
        }
        .padding()
        .background(Color.white.opacity(0.2))
        .cornerRadius(10)
    }
    
    private var connectionCard: some View {
        HStack {
            Image(systemName: sessionDelegate.isReachable ? "applewatch.circle.fill" : "applewatch.circle")
                .imageScale(.large)
                .foregroundColor(sessionDelegate.isReachable ? .green : .red)
            Text(sessionDelegate.isReachable ? "Watch Connected" : "Watch Disconnected")
                .font(.headline)
            Spacer()
        }
        .padding()
        .background(Color.white.opacity(0.2))
        .cornerRadius(15)
    }
    
    private var toggleCard: some View {
        VStack(spacing: 10) {
            Toggle("Focus Mode", isOn: .init(
                get: { sessionDelegate.toggleState },
                set: { _ in }
            ))
            Text("Toggle State: \(sessionDelegate.toggleState ? "On" : "Off")")
                .font(.caption)
        }
        .padding()
        .background(Color.white.opacity(0.2))
        .cornerRadius(15)
    }
}

class SessionDelegate: NSObject, WCSessionDelegate, ObservableObject {
    static let shared = SessionDelegate()
    @Published var isReachable = false
    @Published var toggleState = false
    @Published var receivedData: [String: Any] = [:]
    
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        print("Phone: Received data: \(applicationContext)")
        DispatchQueue.main.async {
            self.receivedData = applicationContext
            
            if let toggleState = applicationContext["toggleState"] as? Bool {
                self.toggleState = toggleState
            }
            
            if let mood = applicationContext["mood"] as? Int {
                NotificationCenter.default.post(name: .init("MoodUpdated"), object: mood)
            }
        }
    }
    
    func session(_ session: WCSession,
                 activationDidCompleteWith activationState: WCSessionActivationState,
                 error: Error?) {
        print("Phone: Session activated: \(activationState.rawValue)")
        DispatchQueue.main.async {
            self.isReachable = session.isReachable
        }
    }
    
    func sessionReachabilityDidChange(_ session: WCSession) {
        DispatchQueue.main.async {
            self.isReachable = session.isReachable
        }
    }
    
    #if os(iOS)
    func sessionDidBecomeInactive(_ session: WCSession) {}
    func sessionDidDeactivate(_ session: WCSession) {
        session.activate()
    }
    #endif
}

#Preview {
    ContentView()
}
