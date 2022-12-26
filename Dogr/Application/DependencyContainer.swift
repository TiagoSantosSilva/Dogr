//
//  DependencyContainer.swift
//  Dogr
//
//  Created by Tiago Silva on 25/12/2022.
//

import Foundation

protocol DependencyContainable: AnyObject {
    var favoritesRepository: FavoritesRepositoriable { get }
    var networkEngine: NetworkEnginable { get }
}

final class DependencyContainer: DependencyContainable {

    // MARK: Dependencies

    let favoritesRepository: FavoritesRepositoriable
    let networkEngine: NetworkEnginable

    // MARK: Initialization

    init() {
        self.favoritesRepository = FavoritesRepository()

        let networkBuilder = NetworkRequestBuilder()
        let networkParser = NetworkResponseParser()
        self.networkEngine = NetworkEngine(builder: networkBuilder, parser: networkParser)
    }
}
