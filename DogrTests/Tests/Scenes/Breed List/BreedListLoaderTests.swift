//
//  BreedListLoaderTests.swift
//  DogrTests
//
//  Created by Tiago Silva on 28/12/2022.
//

import XCTest
@testable import Dogr

final class BreedListLoaderTests: XCTestCase {

    // MARK: Properties

    private var dependencies: DependencyContainable!
    private var loader: BreedListLoader!
    private var networkEngine: MockNetworkEngine!

    // MARK: Set Up & Tear Down

    override func setUp() {
        networkEngine = MockNetworkEngine()
        dependencies = MockDependencyContainer(networkEngine: networkEngine)
        loader = BreedListLoader(dependencies: dependencies)
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
        networkEngine = nil
        dependencies = nil
        loader = nil
    }

    // MARK: Tests

    func testLoadBreedsLoadsExpectedResult() async {
        // Given

        networkEngine.endpointRequestHandler = { _ in
            BreedListResultStub.value
        }

        // When

        let result = try! await loader.loadBreeds()

        // Then

        XCTAssertEqual(result, BreedListResultStub.value)
    }

    func testLoadBreedsLoadsEmptyResultForEmptyDataLoad() async {
        // Given

        networkEngine.endpointRequestHandler = { _ in
            BreedListResultStub.empty
        }

        // When

        let result = try! await loader.loadBreeds()

        // Then

        XCTAssertEqual(result, BreedListResultStub.empty)
    }
}

// MARK: BreedListResult Equatable

extension BreedListResult: Equatable {
    public static func == (lhs: BreedListResult, rhs: BreedListResult) -> Bool {
        lhs.message == rhs.message
    }
}
