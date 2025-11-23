//
//  BeeDTO.swift
//  LaRedouteRaceApp
//
//  Created by Moaz Ezz on 23/11/2025.
//

import Foundation

struct BeeDTO: Codable {
    let name: String
    let color: String
}

struct BeeListDTO: Codable {
    let list: [BeeDTO]
}

extension BeeDTO {
    func toDomain() -> Bee {
        Bee(name: name, color: color)
    }
}
