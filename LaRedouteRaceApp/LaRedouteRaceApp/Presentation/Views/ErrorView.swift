//
//  ErrorView.swift
//  LaRedouteRaceApp
//
//  Created by Moaz Ezz on 23/11/2025.
//

import SwiftUI

struct ErrorView: View {
    let message: String
    let onRetry: () -> Void
    
    var body: some View {
        ZStack {
            Color(UIColor.systemGroupedBackground).ignoresSafeArea()
            
            VStack(spacing: 30) {
                Text("Oops !!")
                    .font(.system(size: 36, weight: .bold))
                    .foregroundColor(.primary)
                
                Text("Something went wrong.")
                    .font(.system(size: 18))
                    .foregroundColor(.secondary)
                
                Image(systemName: "exclamationmark.triangle.fill")
                    .font(.system(size: 80))
                    .foregroundColor(.orange)
                
                Text("Don't worry\nwe are\non it")
                    .font(.system(size: 16))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
                    .padding(.bottom, 10)
                
                if !message.isEmpty {
                    Text(message)
                        .font(.system(size: 12))
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)
                        .padding(.vertical, 10)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                }
                
                Button(action: onRetry) {
                    HStack {
                        Image(systemName: "arrow.clockwise")
                        Text("Retry")
                    }
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 40)
                    .padding(.vertical, 15)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .shadow(color: .blue.opacity(0.3), radius: 10, x: 0, y: 5)
                }
                .padding(.top, 20)
            }
            .padding()
        }
    }
}

#Preview {
    ErrorView(message: "Network connection failed", onRetry: {})
}
