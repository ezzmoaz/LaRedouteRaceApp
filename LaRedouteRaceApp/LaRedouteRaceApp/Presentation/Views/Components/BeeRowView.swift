//
//  BeeRowView.swift
//  LaRedouteRaceApp
//
//  Created by Moaz Ezz on 23/11/2025.
//

import SwiftUI

struct BeeRowView: View {
    let bee: Bee
    let position: Int
    
    var body: some View {
        HStack(spacing: 15) {
            Circle()
                .fill(Color(hex: bee.color ?? "#ffffff"))
                .frame(width: 50, height: 50)
                .overlay(
                    Text("🐝")
                        .font(.system(size: 30))
                )
            
            VStack(alignment: .leading, spacing: 4) {
                Text(positionText)
                    .font(.system(size: 16, weight: .semibold))
                
                Text(bee.name ?? "NAN")
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            if position <= 3 {
                Text(medalEmoji)
                    .font(.system(size: 30))
            }
        }
        .padding()
        .background(Color.white)
    }
    
    private var positionText: String {
        switch position {
        case 1: return "1st"
        case 2: return "2nd"
        case 3: return "3rd"
        default: return "\(position)th"
        }
    }
    
    private var medalEmoji: String {
        switch position {
        case 1: return "🥇"
        case 2: return "🥈"
        case 3: return "🥉"
        default: return ""
        }
    }
}

#Preview {
    BeeRowView(bee: Bee(name: "BeeGees", color: "#8d62a1"), position: 1)
}
