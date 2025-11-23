//
//  ContentView.swift
//  LaRedouteRaceApp
//
//  Created by Moaz Ezz on 23/11/2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel: RaceViewModel
    
    init(viewModel: RaceViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        Group {
            switch viewModel.raceState {
            case .idle:
                StartView {
                    Task {
                        await viewModel.startRace()
                    }
                }
                
            case .loading:
                LoadingView()
                
            case .running(let timeRemaining):
                RaceView(
                    bees: viewModel.bees,
                    timeRemaining: timeRemaining
                )
                
            case .captchaRequired(let url):
                CaptchaView(url: url) {
                    viewModel.resumeAfterCaptcha()
                }
                
            case .finished(let winner):
                WinnerView(winner: winner) {
                    viewModel.reset()
                }
                
            case .error(let message):
                ErrorView(message: message) {
                    Task {
                        await viewModel.startRace()
                    }
                }
            }
        }
        .animation(.easeInOut, value: viewModel.raceState)
    }
}
