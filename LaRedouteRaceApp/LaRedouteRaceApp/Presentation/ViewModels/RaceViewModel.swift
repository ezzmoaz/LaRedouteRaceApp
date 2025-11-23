//
//  RaceViewModel.swift
//  LaRedouteRaceApp
//
//  Created by Moaz Ezz on 23/11/2025.
//

import Foundation
import Combine

final class RaceViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var raceState: RaceViewState = .idle
    @Published var bees: [Bee] = []
    
    private let fetchRaceDurationUseCase: FetchRaceDurationUseCase
    private let monitorBeesListUseCase: MonitorBeesListUseCase
    
    init(fetchRaceDurationUseCase: FetchRaceDurationUseCase, monitorBeesListUseCase: MonitorBeesListUseCase) {
        self.fetchRaceDurationUseCase = fetchRaceDurationUseCase
        self.monitorBeesListUseCase = monitorBeesListUseCase
    }
}

// MARK: - View State

enum RaceViewState: Equatable {
    case idle
    case loading
    case running(timeRemaining: Int)
    case captchaRequired(url: URL)
    case finished(winner: Bee)
    case error(message: String)
}
