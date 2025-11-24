//
//  RaceRepositoryImpl.swift
//  LaRedouteRaceApp
//
//  Created by Moaz Ezz on 23/11/2025.
//

import Foundation

class RaceRepositoryImpl: RaceRepository {
    private let remoteDataSource: RaceRemoteDataSource
    
    init(remoteDataSource: RaceRemoteDataSource) {
        self.remoteDataSource = remoteDataSource
    }
    func fetchRaceDuration() async throws -> Int {
        do {
            let dto = try await remoteDataSource.fetchRaceDuration()
            return dto.timeInSeconds
        } catch let error as NetworkServiceError {
            throw mapError(error)
        } catch {
            throw RaceRepositoryError.networkError
        }
    }
    
    func fetchBeeList() async throws -> [Bee] {
        do {
            let dto = try await remoteDataSource.fetchBeesList()
            return dto.beeList.map { $0.toDomain() }
        } catch let error as NetworkServiceError {
            throw mapError(error)
        } catch {
            throw RaceRepositoryError.networkError
        }
    }
    
    private func mapError(_ error: NetworkServiceError) -> RaceRepositoryError {
        switch error {
        case .networkError:
            return .networkError
        case .decodingError, .invalidURL:
            return .invalidData
        case .rateLimitExceeded:
            return .rateLimitExceeded
        case .captchaRequired(let url):
            return .captchaRequired(url)
        case .serverError(_, let message):
            return .serverError(message)
        }
    }
}
