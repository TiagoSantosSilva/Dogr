//
//  BreedListViewModelTests.swift
//  DogrTests
//
//  Created by Tiago Silva on 28/12/2022.
//

import XCTest
@testable import Dogr

final class BreedListViewModelTests: XCTestCase {

    // MARK: Properties

    private var loader: MockBreedListLoader!
    private var viewModel: BreedListViewModel!

    // MARK: Set Up & Tear Down

    override func setUp() {
        loader = MockBreedListLoader()
        viewModel = BreedListViewModel(loader: loader)
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
        loader = nil
        viewModel = nil
    }

    // MARK: Tests

    func testLoadBreedsCompletesWithSuccessForSuccessfulLoaderResponse() {
        // Given

        let expectation = expectation(description: "View Model received successful response.")
        loader.loadBreedsHandler = {
            BreedListResult.value
        }

        // When

        viewModel.loadBreeds { result in
            if result == .error {
                XCTFail()
            }
            expectation.fulfill()
        }

        // Then

        waitForExpectations(timeout: 1)
    }

    func testLoadBreedsCompletesWithErrorForErrorThrownOnLoader() {
        // Given

        let expectation = expectation(description: "View Model caught an error.")
        loader.loadBreedsHandler = nil

        // When

        viewModel.loadBreeds { result in
            if result == .success {
                XCTFail()
            }
            expectation.fulfill()
        }

        // Then

        waitForExpectations(timeout: 1)
    }

    func testLoadBreedsCompletedWithSuccessCompletesWithOrderedBreedList() {
        // Given

        let expectation = expectation(description: "View Model received successful response.")
        loader.loadBreedsHandler = {
            BreedListResult.value
        }

        // When

        viewModel.loadBreeds { result in
            if result == .error {
                XCTFail()
            }

            let breedNames = self.viewModel.breeds.map { $0.name }
            if breedNames != BreedListResultStub.orderedBreedList {
                XCTFail()
            }

            expectation.fulfill()
        }

        // Then

        waitForExpectations(timeout: 1)
    }
}
