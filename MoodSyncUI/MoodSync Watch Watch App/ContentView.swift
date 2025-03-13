//
//  ContentView.swift
//  MoodSync Watch Watch App
//
//  Created by Priyanshu Singh on 13/03/25.
//

import SwiftUI
import WatchConnectivity

enum MoodType: String, CaseIterable {
    case happy = "Happy"
    case excited = "Excited"
    case calm = "Calm"
    case sad = "Sad"
    
    var icon: String {
        switch self {
        case .happy: return "face.smiling"
        case .excited: return "star.fill"
        case .calm: return "leaf.fill"
        case .sad: return "cloud.rain"
        }
    }
    
    var value: Int {
        switch self {
        case .happy: return 100
        case .excited: return 75
        case .calm: return 50
        case .sad: return 25
        }
    }
    
    var color: Color {
        switch self {
        case .happy: return .yellow
        case .excited: return .orange
        case .calm: return .green
        case .sad: return .blue
        }
    }
}

class SessionDelegate: NSObject, WCSessionDelegate {
    static let shared = SessionDelegate()
    
    func session(_ session: WCSession,
                 activationDidCompleteWith activationState: WCSessionActivationState,
                 error: Error?) {
        print("Watch Session activated: \(activationState.rawValue)")
    }
    
    func sessionReachabilityDidChange(_ session: WCSession) {
        print("Watch Session reachability changed: \(session.isReachable)")
    }
}

struct ContentView: View {
    @State private var selectedMood: MoodType? = nil
    @State private var isToggleOn = false
    private let session: WCSession = .default
    
    init() {
        // Initialize WCSession
        if WCSession.isSupported() {
            session.delegate = SessionDelegate.shared
            session.activate()
        }
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 15) {
                // Mood Selection Section
                Group {
                    Text("How are you feeling?")
                        .font(.title3)
                        .fontWeight(.bold)
                    
                    ForEach(MoodType.allCases, id: \.self) { mood in
                        Button(action: {
                            selectedMood = mood
                            sendMoodToPhone(mood)
                            WKInterfaceDevice.current().play(.click)
                        }) {
                            HStack {
                                Image(systemName: mood.icon)
                                    .imageScale(.large)
                                Text(mood.rawValue)
                                    .fontWeight(.medium)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 8)
                            .background(selectedMood == mood ? mood.color.opacity(0.3) : Color.clear)
                            .cornerRadius(10)
                        }
                    }
                    
                    Text("Mood: \(selectedMood?.rawValue ?? "Not selected")")
                        .font(.system(.body, design: .rounded))
                }
                
                Divider().padding(.vertical, 5)
                
                // Toggle Section
                Group {
                    Text("Quick Settings")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Toggle("Focus Mode", isOn: $isToggleOn)
                        .onChange(of: isToggleOn) { newValue in
                            do {
                                try session.updateApplicationContext(["toggleState": newValue])
                                print("Watch: Sent toggle: \(newValue)")
                                WKInterfaceDevice.current().play(.click)
                            } catch {
                                print("Watch: Failed to send toggle: \(error)")
                            }
                        }
                    
                    Text("Toggle is: \(isToggleOn ? "On" : "Off")")
                        .font(.caption2)
                }
            }
            .padding()
        }
    }
    
    private func sendMoodToPhone(_ mood: MoodType) {
        do {
            try session.updateApplicationContext(["mood": mood.value])
            print("Watch: Sent mood: \(mood.rawValue)")
        } catch {
            print("Watch: Failed to send mood: \(error)")
        }
    }
}

#Preview {
    ContentView()
}
