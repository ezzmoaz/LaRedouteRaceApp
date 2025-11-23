//
//  AppCoordinator.swift
//  LaRedouteRaceApp
//
//  Created by Moaz Ezz on 23/11/2025.
//

import Foundation
import SwiftUI

final class AppCoordinator {
    var factory: AppFactory
    init(factory: AppFactory) {
        self.factory = factory
    }
    func start() -> some View {
        return ContentView(viewModel: self.factory.makeViewModel())
    }
}
