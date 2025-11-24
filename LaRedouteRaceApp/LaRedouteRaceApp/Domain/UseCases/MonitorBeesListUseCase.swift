//
//  MonitorBeesListUseCase.swift
//  LaRedouteRaceApp
//
//  Created by Moaz Ezz on 23/11/2025.
//

import Foundation

class MonitorBeesListUseCase {
    private let repository: RaceRepository
    private let pollingInterval: TimeInterval
    
    init(
        repository: RaceRepository,
        pollingInterval: TimeInterval = 0
    ) {
        self.repository = repository
        self.pollingInterval = pollingInterval
    }
    
    /// Execute the use case with continuous updates
    /// - Parameters:
    ///   - onUpdate: Callback with updated bee standings
    ///   - onError: Callback when errors occur
    /// - Returns: Task that can be cancelled
    func execute(
        onUpdate: @escaping ([Bee]) -> Void,
        onError: @escaping (RaceRepositoryError) -> Void
    ) -> Task<Void, Never> {
        Task {
            while !Task.isCancelled {
                print("MonitorBeesListUseCase: execute")
                do {
                    let bees = try await repository.fetchBeeList()
                    
                    // Check if cancelled after await
                    guard !Task.isCancelled else {
                        print("MonitorBeesListUseCase: Task cancelled after fetching")
                        break
                    }
                    
                    DispatchQueue.main.async {
                        onUpdate(bees)
                    }
                    // Wait before next poll
                    try await Task.sleep(nanoseconds: UInt64(pollingInterval * 1_000_000_000))
                    
                } catch let error as RaceRepositoryError {
                    // Check if cancelled during error
                    guard !Task.isCancelled else {
                        break
                    }
                    
                    DispatchQueue.main.async {
                        onError(error)
                    }
                    
                    // Handle rate limiting with backoff
                    if error == .rateLimitExceeded {
                        try? await Task.sleep(nanoseconds: 3_000_000_000)
                    }
                } catch {
                    // Check if this is a cancellation
                    if Task.isCancelled {
                        print("MonitorBeesListUseCase: Task cancelled (generic catch)")
                        break
                    }
                    
                    print("MonitorBeesListUseCase: Unexpected error: \(error)")
                    DispatchQueue.main.async {
                        onError(.networkError)
                    }
                }
            }
            print("MonitorBeesListUseCase: Polling loop exited cleanly")
        }
    }
}
