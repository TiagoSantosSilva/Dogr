//
//  FavoritePicturesViewModel.swift
//  Dogr
//
//  Created by Tiago Silva on 25/12/2022.
//

import Combine
import Foundation

protocol FavoritePicturesViewModelable: AnyObject {
    var filterModeledBreeds: [FavoritePicturesFilterItemViewModel] { get }
    var groups: CurrentValueSubject<[BreedPictureGroupModel], Never> { get }
    var isApplyingFilter: Bool { get }

    func filter(with items: [FavoritePicturesFilterItemViewModel])
}

final class FavoritePicturesViewModel: FavoritePicturesViewModelable {

    // MARK: Properties

    var filterModeledBreeds: [FavoritePicturesFilterItemViewModel] {
        favoriteRepository.breedPictures.value.map { .init(breed: $0.breed, name: $0.name, isSelected: $0.breed == selectedBreed) }
    }
    lazy var groups: CurrentValueSubject<[BreedPictureGroupModel], Never> = .init(favoriteRepository.breedPictures.value)
    var isApplyingFilter: Bool { selectedBreed != nil }

    private let favoriteRepository: FavoritesRepositoriable
    private var cancellables: Set<AnyCancellable> = .init()
    private var selectedBreed: String?

    // MARK: Initialization

    init(dependencies: DependencyContainable) {
        self.favoriteRepository = dependencies.favoritesRepository

        favoriteRepository.breedPictures.sink { [weak self] _ in
            self?.updateGroups()
        }.store(in: &cancellables)
    }

    // MARK: Functions

    func filter(with items: [FavoritePicturesFilterItemViewModel]) {
        selectedBreed = items.first { $0.isSelected }?.breed
        updateGroups()
    }

    private func updateGroups() {
        let groupsToSend: [BreedPictureGroupModel] = {
            guard let selectedBreed = selectedBreed else { return favoriteRepository.breedPictures.value }
            return favoriteRepository.breedPictures.value.filter { $0.breed == selectedBreed }
        }()
        groups.send(groupsToSend)
    }
}
