//
//  FavoritesRepository.swift
//  Dogr
//
//  Created by Tiago Silva on 25/12/2022.
//

import Combine

protocol FavoritesRepositoriable: AnyObject {
    var pictures: CurrentValueSubject<[BreedPictureGroupModel], Never> { get }

    func add(_ breed: BreedPictureModel)
    func remove(url: String, for breed: String)
    func isImageFavorite(url: String, for breed: String) -> Bool
}

typealias FavoritePicturesValueSubject = CurrentValueSubject<[BreedPictureGroupModel], Never>

final class FavoritesRepository: FavoritesRepositoriable {

    // MARK: Properties

    private(set) var pictures: FavoritePicturesValueSubject = .init([])

    // MARK: Functions

    func add(_ breed: BreedPictureModel) {
        guard let group = pictures.group(for: breed.name) else {
            pictures.value.append(BreedPictureGroupModel(breed: breed.name, pictures: [breed]))
            return
        }

        group.pictures.append(breed)
        updateSubject()
    }

    func remove(url: String, for breed: String) {
        guard let groupForBreed = pictures.group(for: breed) else { return }

        groupForBreed.pictures = groupForBreed.pictures.filter { $0.url != url }
        guard groupForBreed.pictures.isEmpty else {
            updateSubject()
            return
        }
        pictures.value.removeAll(where: { $0 == groupForBreed })
    }

    func isImageFavorite(url: String, for breed: String) -> Bool {
        guard let groupForBreed = pictures.group(for: breed) else { return false }

        return groupForBreed.pictures.contains(where: { $0.url == url })
    }

    private func updateSubject() {
        pictures.send(pictures.value)
    }
}

extension FavoritePicturesValueSubject {
    func group(for breed: String) -> BreedPictureGroupModel? {
        value.first { $0.breed == breed }
    }
}
