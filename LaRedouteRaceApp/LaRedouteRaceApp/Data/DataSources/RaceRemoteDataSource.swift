//
//  RaceRemoteDataSource.swift
//  LaRedouteRaceApp
//
//  Created by Moaz Ezz on 23/11/2025.
//

import Foundation

protocol RaceRemoteDataSource {
    func fetchRaceDuration() async throws -> RaceDurationDTO
    func fetchBeesList() async throws -> BeeListDTO
}
