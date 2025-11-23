//
//  RaceRemoteDataSourceImpl.swift
//  LaRedouteRaceApp
//
//  Created by Moaz Ezz on 23/11/2025.
//

import Foundation

final class RaceRemoteDataSourceImpl: RaceRemoteDataSource {
    private let networkService: NetworkService
    private let baseURL: String
    
    init(
        networkService: NetworkService,
        baseURL: String = "https://rtest.proxy.beeceptor.com"
    ) {
        self.networkService = networkService
        self.baseURL = baseURL
    }
    
    func fetchRaceDuration() async throws -> RaceDurationDTO {
        let endpoint = "\(baseURL)/bees/race/duration"
        return try await networkService.request(endpoint: endpoint)
    }
    
    func fetchBeesList() async throws -> BeeListDTO {
        let endpoint = "\(baseURL)/bees/race/status"
        return try await networkService.request(endpoint: endpoint)
    }
}
