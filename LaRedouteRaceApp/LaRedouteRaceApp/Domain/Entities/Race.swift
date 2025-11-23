//
//  Race.swift
//  LaRedouteRaceApp
//
//  Created by Moaz Ezz on 23/11/2025.
//
import Foundation

struct Race {
    let id: UUID
    let durationInSeconds: Int
    var participants: [Bee]
}
