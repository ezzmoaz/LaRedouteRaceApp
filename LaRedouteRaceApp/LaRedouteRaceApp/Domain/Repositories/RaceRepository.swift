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

