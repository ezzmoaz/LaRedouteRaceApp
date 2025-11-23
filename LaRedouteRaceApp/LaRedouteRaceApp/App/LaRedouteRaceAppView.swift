//
//  BeeRaceApp.swift
//  LaRedouteRaceApp
//
//  Created by Moaz Ezz on 23/11/2025.
//

import SwiftUI

@main
struct LaRedouteRaceAppView: App {
    var body: some Scene {
        WindowGroup {
            AppCoordinator(factory: createAppFactory()).start()
        }
    }
    
    private func createAppFactory() -> AppFactory {
        let networjSerivce = NetworkServiceImpl()
        let raceRemoteDataSource = RaceRemoteDataSourceImpl(networkService: networjSerivce)
        let raceRepository = RaceRepositoryImpl(remoteDataSource: raceRemoteDataSource)
        let fetchRaceDurationUseCase = FetchRaceDurationUseCase(repository: raceRepository)
        let monitorBeesListUseCase = MonitorBeesListUseCase(repository: raceRepository)
        return .init(fetchRaceDurationUseCase: fetchRaceDurationUseCase,
                     monitorBeesListUseCase: monitorBeesListUseCase)
    }
}
