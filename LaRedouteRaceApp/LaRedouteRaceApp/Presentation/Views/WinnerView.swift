//
//  WinnerView.swift
//  LaRedouteRaceApp
//
//  Created by Moaz Ezz on 23/11/2025.
//

import SwiftUI

struct WinnerView: View {
    let winner: Bee
    let onRestart: () -> Void
    
    @State private var showAnimation = false
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack(spacing: 30) {
                Text("🎉 Winner 🎉")
                    .font(.system(size: 40, weight: .bold))
                    .foregroundColor(.white)
                
                Circle()
                    .fill(Color(hex: winner.color ?? "#ffffff"))
                    .frame(width: 150, height: 150)
                    .overlay(
                        Text("🐝")
                            .font(.system(size: 80))
                    )
                    .shadow(color: Color(hex: winner.color ?? "#ffffff").opacity(0.5), radius: 20, x: 0, y: 10)
                    .scaleEffect(showAnimation ? 1.1 : 1.0)
                    .animation(.easeInOut(duration: 0.6).repeatForever(autoreverses: true), value: showAnimation)
                
                Text("1st")
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundColor(.white)
                
                Text(winner.name ?? "NAN")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.white)
                
                Text("🥇")
                    .font(.system(size: 80))
                
                Button(action: onRestart) {
                    HStack {
                        Image(systemName: "arrow.clockwise")
                        Text("Start New Race")
                    }
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 40)
                    .padding(.vertical, 15)
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.orange, Color.yellow]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .cornerRadius(10)
                    .shadow(color: .orange.opacity(0.5), radius: 10, x: 0, y: 5)
                }
                .padding(.top, 30)
            }
        }
        .onAppear {
            showAnimation = true
        }
    }
}

#Preview {
    WinnerView(winner: Bee(name: "BeeGees", color: "#8d62a1"), onRestart: {})
}
