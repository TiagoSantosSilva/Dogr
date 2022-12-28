//
//  MockBreedListLoader.swift
//  DogrTests
//
//  Created by Tiago Silva on 28/12/2022.
//

import Foundation
@testable import Dogr

final class MockBreedListLoader: BreedListLoadable {

    // MARK: Properties

    var loadBreedsHandler: (() -> BreedListResult)?

    // MARK: Functions

    func loadBreeds() async throws -> BreedListResult {
        guard let handler = loadBreedsHandler else {
            throw NetworkError.noData
        }

        return handler()
    }
}
