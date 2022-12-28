//
//  MockDependencyContainer.swift
//  DogrTests
//
//  Created by Tiago Silva on 27/12/2022.
//

import Foundation
@testable import Dogr

final class MockDependencyContainer: DependencyContainable {

    // MARK: - Properties

    let networkEngine: NetworkEnginable
    let favoritesRepository: FavoritesRepositoriable

    // MARK: - Initialization

    init(networkEngine: NetworkEnginable = MockNetworkEngine(),
         favoritesRepository: FavoritesRepositoriable = MockFavoritesRepository()) {
        self.networkEngine = networkEngine
        self.favoritesRepository = favoritesRepository
    }
}
