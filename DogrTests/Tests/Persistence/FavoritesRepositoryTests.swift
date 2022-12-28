//
//  FavoritesRepositoryTests.swift
//  DogrTests
//
//  Created by Tiago Silva on 28/12/2022.
//

import Combine
import XCTest
@testable import Dogr

final class FavoritesRepositoryTests: XCTestCase {

    // MARK: Properties

    private var cancellables: Set<AnyCancellable>!
    private var repository: FavoritesRepository!

    // MARK: Set Up & Tear Down

    override func setUp() {
        cancellables = .init()
        repository = FavoritesRepository()
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
        repository = nil
        cancellables = nil
    }

    // MARK: Tests

    func testAddAddsNewBreedGroupForNonExistentBreedGroup() {
        // Given

        // When

        repository.add(.african1)

        // Then

        XCTAssert(repository.breedPictures.value.contains { $0.breed == BreedPictureModel.african1.name })
        XCTAssertEqual(1, repository.breedPictures.value.count)
        XCTAssertEqual(1, repository.breedPictures.value.first { $0.breed == BreedPictureModel.african1.name }?.pictures.count)
    }

    func testAddAddsBreedPictureToExistingGroup() {
        // Given

        repository.breedPictures.value = [BreedPictureGroupModel(breed: "african", pictures: [.african1])]

        // When

        repository.add(.african2)

        // Then

        XCTAssert(repository.breedPictures.value.contains { $0.breed == BreedPictureModel.african2.name })
        XCTAssertEqual(1, repository.breedPictures.value.count)
        XCTAssertEqual(2, repository.breedPictures.value.first { $0.breed == BreedPictureModel.african2.name }?.pictures.count)
    }

    func testAddBreedPictureToNewBreedUpdatesSubject() {
        // Given

        let expectation = expectation(description: "Picture subject updated.")

        /// Drops 1 because it's a `CurrentValueSubject`, drops a second one because we're mutating the picture list twice.
        repository.breedPictures.dropFirst(2).sink { _ in
            expectation.fulfill()
        }.store(in: &cancellables)

        // When

        repository.add(.african1)

        // Then

        waitForExpectations(timeout: 1)
    }

    func testAddBreedPictureToExistingBreedUpdatesSubject() {
        // Given

        let expectation = expectation(description: "Picture subject updated.")

        repository.breedPictures.value = [BreedPictureGroupModel(breed: "african", pictures: [.african1])]

        repository.breedPictures.dropFirst().sink { _ in
            expectation.fulfill()
        }.store(in: &cancellables)

        // When

        repository.add(.african2)

        // Then

        waitForExpectations(timeout: 1)
    }

    func testRemoveBreedPictureRemovesBreedPictureFromGroup() {
        // Given

        repository.breedPictures.value = [BreedPictureGroupModel(breed: "african", pictures: [.african1]),
                                          BreedPictureGroupModel(breed: "african", pictures: [.african2])]

        // When

        repository.remove(url: BreedPictureModel.african2.url, for: BreedPictureModel.african2.name)

        // Then

        let breedPictures = repository.breedPictures.value.first { $0.breed == BreedPictureModel.african2.name }!.pictures

        XCTAssertFalse(breedPictures.contains { $0.url == BreedPictureModel.african2.url })
        XCTAssertEqual(1, breedPictures.count)
    }

    func testRemoveBreedPictureRemovesBreedPictureAndGroup() {
        // Given

        repository.breedPictures.value = [BreedPictureGroupModel(breed: "african", pictures: [.african1])]

        // When

        repository.remove(url: BreedPictureModel.african1.url, for: BreedPictureModel.african1.name)

        // Then

        let breedGroup = repository.breedPictures.value.first { $0.breed == BreedPictureModel.african2.name }

        XCTAssertNil(breedGroup)
    }

    func testRemoveBreedPictureThatRemovesBreedPictureUpdatesSubject() {
        // Given

        let expectation = expectation(description: "Picture subject updated.")

        repository.breedPictures.value = [BreedPictureGroupModel(breed: "african", pictures: [.african1]),
                                          BreedPictureGroupModel(breed: "african", pictures: [.african2])]

        repository.breedPictures.dropFirst().sink { _ in
            expectation.fulfill()
        }.store(in: &cancellables)

        // When

        repository.remove(url: BreedPictureModel.african2.url, for: BreedPictureModel.african2.name)

        // Then

        waitForExpectations(timeout: 1)
    }

    func testRemoveBreedPictureThatRemovesBreedPictureAndGroupUpdatesSubject() {
        // Given

        let expectation = expectation(description: "Picture subject updated.")

        repository.breedPictures.value = [BreedPictureGroupModel(breed: "african", pictures: [.african1])]

        repository.breedPictures.dropFirst().sink { _ in
            expectation.fulfill()
        }.store(in: &cancellables)

        // When

        repository.remove(url: BreedPictureModel.african1.url, for: BreedPictureModel.african1.name)

        // Then

        waitForExpectations(timeout: 1)
    }

    func testIsImageFavoriteReturnsFalseForNonExistingGroup() {
        // Given

        repository.breedPictures.value = [BreedPictureGroupModel(breed: "african", pictures: [.african1]),
                                          BreedPictureGroupModel(breed: "african", pictures: [.african2])]

        // When

        let isFavorite = repository.isImageFavorite(url: BreedPictureModel.greyhound.url, for: BreedPictureModel.greyhound.name)

        // Then

        XCTAssertFalse(isFavorite)
    }

    func testIsImageFavoriteReturnsFalseForNonExistingBreedImage() {
        // Given

        repository.breedPictures.value = [BreedPictureGroupModel(breed: "greyhound", pictures: [.greyhound]),
                                          BreedPictureGroupModel(breed: "clumber", pictures: [.clumber])]

        // When

        let isFavorite = repository.isImageFavorite(url: BreedPictureModel.australian.url, for: BreedPictureModel.australian.name)

        // Then

        XCTAssertFalse(isFavorite)
    }

    func testIsImageFavoriteReturnsTrueForExistingBreedImage() {
        // Given

        repository.breedPictures.value = [BreedPictureGroupModel(breed: "mastiff", pictures: [.mastiff]),
                                          BreedPictureGroupModel(breed: "australian", pictures: [.australian])]

        // When

        let isFavorite = repository.isImageFavorite(url: BreedPictureModel.australian.url, for: BreedPictureModel.australian.name)

        // Then

        XCTAssert(isFavorite)
    }
}
