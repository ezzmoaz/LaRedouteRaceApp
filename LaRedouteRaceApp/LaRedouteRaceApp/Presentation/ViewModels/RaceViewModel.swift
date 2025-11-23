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
    @Published var timeRemaining: Int = 0
    
    // MARK: - Use Cases
    private let fetchRaceDurationUseCase: FetchRaceDurationUseCase
    private let monitorBeesListUseCase: MonitorBeesListUseCase
    
    // MARK: - Private Properties
    private var currentRace: Race?
    private var timer: Timer?
    private var monitoringTask: Task<Void, Never>?
    
    // MARK: - Initialization
    init(
        fetchRaceDurationUseCase: FetchRaceDurationUseCase,
        monitorBeesListUseCase: MonitorBeesListUseCase
    ) {
        self.fetchRaceDurationUseCase = fetchRaceDurationUseCase
        self.monitorBeesListUseCase = monitorBeesListUseCase
    }
    
    // MARK: - Public Methods
    
    func startRace() async {
        DispatchQueue.main.async { self.raceState = .loading }
        
        do {

            let raceDuration = try await fetchRaceDurationUseCase.excecute()
            
            DispatchQueue.main.async {
                self.currentRace = Race(durationInSeconds: raceDuration)
                self.timeRemaining = raceDuration
            }
            
            // Start countdown timer
            startTimer()
            
            // Start monitoring race with MonitorRaceUseCase
            startMonitoring()
            
            DispatchQueue.main.async {
                self.raceState = .running(timeRemaining: self.timeRemaining)
            }
            
        } catch let error as RaceRepositoryError {
            handleError(error)
        } catch {
            DispatchQueue.main.async {
                self.raceState = .error(message: "Failed to start race")
            }
        }
    }
    
    func resumeAfterCaptcha() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            if self.timeRemaining > 0 {
                self.startTimer()
                self.startMonitoring()
                self.raceState = .running(timeRemaining: self.timeRemaining)
            } else {
                self.finishRace()
            }
        }
    }
    
    func reset() {
        stopRace()
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.currentRace = nil
            self.bees = []
            self.timeRemaining = 0
            self.raceState = .idle
        }
    }
    
    // MARK: - Private Methods
    
//    private func updateOnMain(_ block: @escaping () -> Void) async {
//        await withCheckedContinuation { continuation in
//            DispatchQueue.main.async {
//                block()
//                continuation.resume()
//            }
//        }
//    }
    
    private func startTimer() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            self.timer?.invalidate()
            self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
                guard let self = self else { return }
                
                DispatchQueue.main.async {
                    if self.timeRemaining > 0 {
                        self.timeRemaining -= 1
                        if case .running = self.raceState {
                            self.raceState = .running(timeRemaining: self.timeRemaining)
                        }
                    } else {
                        self.finishRace()
                    }
                }
            }
        }
    }
    
    private func startMonitoring() {
        monitoringTask?.cancel()
        
        // Use MonitorRaceUseCase
        monitoringTask = monitorBeesListUseCase.execute(
            onUpdate: { [weak self] bees in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    self.bees = bees
                }
            },
            onError: { [weak self] error in
                guard let self = self else { return }
                self.handleError(error)
            }
        )
    }
    
    private func finishRace() {
        stopRace()
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            if let winner = self.bees.first {
                self.raceState = .finished(winner: winner)
            } else {
                self.raceState = .error(message: "Race finished but no winner found")
            }
        }
    }
    
    private func stopRace() {
        DispatchQueue.main.async { [weak self] in
            self?.timer?.invalidate()
            self?.timer = nil
        }
        monitoringTask?.cancel()
        monitoringTask = nil
    }
    
    private func handleError(_ error: RaceRepositoryError) {
        DispatchQueue.main.async {
            self.raceState = .error(message: error.localizedDescription)
        }
    }
    
    deinit {
        stopRace()
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
