//
//  MockFavoritesRepository.swift
//  DogrTests
//
//  Created by Tiago Silva on 27/12/2022.
//

import Combine
import Foundation
@testable import Dogr

final class MockFavoritesRepository: FavoritesRepositoriable {

    // MARK: Properties

    var breedPictures: CurrentValueSubject<[Dogr.BreedPictureGroupModel], Never> = .init([])

    var addHandler: ((BreedPictureModel) -> Void)?
    var removeHandler: ((String, String) -> Void)?
    var isImageFavoriteHandler: ((String, String) -> Bool)?

    // MARK: Functions

    func add(_ breed: Dogr.BreedPictureModel) {
        guard let addHandler = addHandler else {
            fatalError()
        }

        addHandler(breed)
    }

    func remove(url: String, for breed: String) {
        guard let removeHandler = removeHandler else {
            fatalError()
        }

        removeHandler(url, breed)
    }

    func isImageFavorite(url: String, for breed: String) -> Bool {
        guard let isImageFavoriteHandler = isImageFavoriteHandler else {
            fatalError()
        }

        return isImageFavoriteHandler(url, breed)
    }
}
