//
//  LoadingView.swift
//  LaRedouteRaceApp
//
//  Created by Moaz Ezz on 23/11/2025.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack(spacing: 20) {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .scaleEffect(2)
                
                Text("Preparing race...")
                    .foregroundColor(.white)
                    .font(.system(size: 18))
            }
        }
    }
}

#Preview {
    LoadingView()
}
