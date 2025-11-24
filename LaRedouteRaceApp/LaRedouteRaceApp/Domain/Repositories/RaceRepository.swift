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
    case rateLimitExceeded
    case captchaRequired(URL)
    case serverError(String)
    
    var localizedDescription: String {
        switch self {
        case .networkError:
            return "Network connection failed"
        case .invalidData:
            return "Invalid data received from server"
        case .rateLimitExceeded:
            return "Too many requests. Please wait."
        case .captchaRequired:
            return "Security verification required"
        case .serverError(let message):
            return "Server error: \(message)"
        }
    }
}
