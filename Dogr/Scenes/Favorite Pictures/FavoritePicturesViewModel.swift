//
//  FavoritePicturesViewModel.swift
//  Dogr
//
//  Created by Tiago Silva on 25/12/2022.
//

import Foundation

protocol FavoritePicturesViewModelable: AnyObject {
    var favoriteRepository: FavoritesRepositoriable { get }
}

final class FavoritePicturesViewModel: FavoritePicturesViewModelable {

    // MARK: Properties

    let favoriteRepository: FavoritesRepositoriable

    // MARK: Initialization

    init(dependencies: DependencyContainable) {
        self.favoriteRepository = dependencies.favoritesRepository
    }
}
