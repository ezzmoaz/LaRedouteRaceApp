//
//  StartView.swift
//  LaRedouteRaceApp
//
//  Created by Moaz Ezz on 23/11/2025.
//
import SwiftUI

struct StartView: View {
    let onStartPressed: (() -> Void)?
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack(spacing: 30) {
                Text("🐝")
                    .font(.system(size: 100))
                
                Text("Bee Race")
                    .font(.system(size: 40, weight: .bold))
                    .foregroundColor(.white)
                
                Text("Watch bees compete in real-time!")
                    .font(.system(size: 16))
                    .foregroundColor(.white.opacity(0.8))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
                Button {
                    self.onStartPressed?()
                } label: {
                    Text("Start Bee Race")
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
                .padding(.top, 20)
            }
        }
    }
}

#Preview {
    StartView(onStartPressed: {})
}
