//
//  BreedListLoader.swift
//  Dogr
//
//  Created by Tiago Silva on 25/12/2022.
//

import Foundation

protocol BreedListLoadable {
    func loadBreeds() async throws -> BreedListResult
}

struct BreedListLoader: BreedListLoadable {

    // MARK: Properties

    private let networkEngine: NetworkEnginable

    // MARK: Initialization

    init(dependencies: DependencyContainable) {
        self.networkEngine = dependencies.networkEngine
    }

    // MARK: Functions

    func loadBreeds() async throws -> BreedListResult {
        try await networkEngine.request(endpoint: BreedEndpoint.list) as BreedListResult
    }
}
