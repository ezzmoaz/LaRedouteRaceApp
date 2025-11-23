//
//  AppFactory.swift
//  LaRedouteRaceApp
//
//  Created by Moaz Ezz on 23/11/2025.
//


struct AppFactory {
    private let fetchRaceDurationUseCase: FetchRaceDurationUseCase
    
    private let monitorBeesListUseCase: MonitorBeesListUseCase
    
    
    init(fetchRaceDurationUseCase: FetchRaceDurationUseCase,
         monitorBeesListUseCase: MonitorBeesListUseCase) {
        self.fetchRaceDurationUseCase = fetchRaceDurationUseCase
        self.monitorBeesListUseCase = monitorBeesListUseCase
    }
    
    func makeViewModel() -> RaceViewModel {
        return RaceViewModel(fetchRaceDurationUseCase: fetchRaceDurationUseCase,
                             monitorBeesListUseCase: monitorBeesListUseCase)
    }
}
