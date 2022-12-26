//
//  BreedPictureModelViewModel.swift
//  Dogr
//
//  Created by Tiago Silva on 25/12/2022.
//

import UIKit

final class BreedPictureModelViewModel: Hashable {

    // MARK: Properties

    let uuid: UUID = .init()
    var url: String
    var image: UIImage?
    var isFavorite: Bool
    var breed: String

    // MARK: Initialization

    init(url: String, breed: String, isFavorite: Bool) {
        self.url = url
        self.breed = breed
        self.isFavorite = isFavorite
    }

    // MARK: Hashable

    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }

    // MARK: Equatable

    static func == (lhs: BreedPictureModelViewModel, rhs: BreedPictureModelViewModel) -> Bool {
        lhs.uuid == rhs.uuid
    }
}
