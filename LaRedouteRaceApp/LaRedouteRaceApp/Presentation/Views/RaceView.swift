//
//  RaceView.swift
//  LaRedouteRaceApp
//
//  Created by Moaz Ezz on 23/11/2025.
//


import SwiftUI

struct RaceView: View {
    let bees: [Bee]
    let timeRemaining: Int
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Color.black
                
                VStack(spacing: 8) {
                    Text("Time remaining")
                        .foregroundColor(.white.opacity(0.8))
                        .font(.system(size: 14))
                    
                    Text(formatTime(timeRemaining))
                        .foregroundColor(.white)
                        .font(.system(size: 48, weight: .bold, design: .monospaced))
                    
                    ProgressView(value: Double(timeRemaining), total: 100)
                        .progressViewStyle(LinearProgressViewStyle(tint: .orange))
                        .padding(.horizontal, 40)
                }
                .padding(.vertical, 30)
            }
            .frame(height: 150)
            
            ScrollView {
                LazyVStack(spacing: 1) {
                    if bees.isEmpty {
                        VStack(spacing: 20) {
                            ProgressView()
                                .scaleEffect(1.5)
                            Text("Fetching race positions...")
                                .foregroundColor(.secondary)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.top, 60)
                    } else {
                        ForEach(Array(bees.enumerated()), id: \.element.id) { index, bee in
                            BeeRowView(bee: bee, position: index + 1)
                                .transition(.slide)
                        }
                    }
                }
            }
            .background(Color(UIColor.systemGroupedBackground))
        }
    }
    
    private func formatTime(_ seconds: Int) -> String {
        let mins = seconds / 60
        let secs = seconds % 60
        return String(format: "%02d:%02d", mins, secs)
    }
}

#Preview {
    RaceView(
        bees: [
            Bee(name: "BeeWare", color: "#ff6b6b"),
            Bee(name: "BeeCome", color: "#feca57"),
            Bee(name: "BeeGees", color: "#48dbfb")
        ],
        timeRemaining: 45
    )
}
