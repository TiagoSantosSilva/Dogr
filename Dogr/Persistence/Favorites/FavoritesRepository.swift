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
            pictures.add(BreedPictureGroupModel(breed: breed.name, pictures: [breed]))
            pictures.sortByName()
            return
        }

        group.pictures.append(breed)
        pictures.send()
    }

    func remove(url: String, for breed: String) {
        guard let groupForBreed = pictures.group(for: breed) else { return }

        groupForBreed.remove(url: url)
        guard groupForBreed.pictures.isEmpty else {
            pictures.send()
            return
        }
        pictures.remove(groupForBreed)
    }

    func isImageFavorite(url: String, for breed: String) -> Bool {
        guard let groupForBreed = pictures.group(for: breed) else { return false }

        return groupForBreed.contains(url: url)
    }
}

// MARK: - BreedPictureGroupModel

private extension BreedPictureGroupModel {
    func contains(url: String) -> Bool {
        pictures.contains(where: { $0.url == url })
    }

    func remove(url: String) {
        pictures = pictures.filter { $0.url != url }
    }
}

// MARK: - FavoritePicturesValueSubject

private extension FavoritePicturesValueSubject {
    func group(for breed: String) -> BreedPictureGroupModel? {
        value.first { $0.breed == breed }
    }

    func sortByName() {
        value.sort { $0.breed < $1.breed }
    }

    func add(_ breed: BreedPictureGroupModel) {
        value.append(breed)
    }

    func remove(_ breed: BreedPictureGroupModel) {
        value.removeAll(where: { $0 == breed })
    }

    func send() {
        send(value)
    }
}
