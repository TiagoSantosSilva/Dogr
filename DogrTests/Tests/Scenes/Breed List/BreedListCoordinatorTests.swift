//
//  BreedListCoordinatorTests.swift
//  DogrTests
//
//  Created by Tiago Silva on 27/12/2022.
//

import XCTest
@testable import Dogr

final class BreedListCoordinatorTests: XCTestCase {

    // MARK: Properties

    private var coordinator: BreedListCoordinator!

    // MARK: Set Up & Tear Down

    override func setUp() {
        coordinator = BreedListCoordinator(dependencies: MockDependencyContainer())
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
        coordinator = nil
    }

    // MARK: Tests

    func testStartHasNavigationControllerAsRoot() {
        // Given

        // When

        coordinator.start()

        // Then

        XCTAssert(coordinator.viewController is UINavigationController)
    }

    func testStartHasRootViewControllerAsBreedListViewController() {
        // Given

        // When

        coordinator.start()

        let navigationController = try! XCTUnwrap(coordinator.viewController as? UINavigationController)
        let viewController = try! XCTUnwrap(navigationController.viewControllers.first)

        // Then

        XCTAssert(viewController is BreedListViewController)
    }
}
