//
//  FetchBeesListUseCase.swift
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
        pollingInterval: TimeInterval = 2.5
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
                do {
                    let bees = try await repository.fetchBeeList()
                    DispatchQueue.main.async {
                        onUpdate(bees)
                    }
                    
                } catch let error as RaceRepositoryError {
                    DispatchQueue.main.async {
                        onError(error)
                    }
                    
                } catch {
                    DispatchQueue.main.async {
                        onError(.networkError)
                    }
                }
            }
        }
    }
}
