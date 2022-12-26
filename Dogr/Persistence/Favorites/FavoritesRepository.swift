//
//  FavoritesRepository.swift
//  Dogr
//
//  Created by Tiago Silva on 25/12/2022.
//

import Combine

protocol FavoritesRepositoriable: AnyObject {
    var pictures: CurrentValueSubject<[BreedPictureModel], Never> { get set }
}

final class FavoritesRepository: FavoritesRepositoriable {

    // MARK: Properties

    var pictures: CurrentValueSubject<[BreedPictureModel], Never> = .init([])
}
