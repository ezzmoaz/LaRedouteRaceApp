//
//  FetchRaceDuration.swift
//  LaRedouteRaceApp
//
//  Created by Moaz Ezz on 23/11/2025.
//

import Foundation

class FetchRaceDurationUseCase {
    private let repository: RaceRepository
    
    init(repository: RaceRepository) {
        self.repository = repository
    }
    
    /// Execute the use case
    /// - Returns: Duration in seconds
    /// - Throws: RaceRepositoryError if operation fails
    func excecute() async throws -> Int {
        let duration = try await repository.fetchRaceDuration()
        
        // Business rule: Duration must be positive
        guard duration > 0 else {
            throw RaceRepositoryError.invalidData
        }
        
        return duration
    }
}
