//
//  RaceRepository.swift
//  LaRedouteRaceApp
//
//  Created by Moaz Ezz on 23/11/2025.
//

import Foundation
protocol RaceRepository {
    func fetchRaceDuration() async throws -> Int
    func fetchBeeList() async throws -> [Bee]
}

enum RaceRepositoryError: Error, Equatable {
    case networkError
    case invalidData
    case serverError(String)
    
    var localizedDescription: String {
        switch self {
        case .networkError:
            return "Network connection failed"
        case .invalidData:
            return "Invalid data received from server"
        case .serverError(let message):
            return "Server error: \(message)"
        }
    }
}
