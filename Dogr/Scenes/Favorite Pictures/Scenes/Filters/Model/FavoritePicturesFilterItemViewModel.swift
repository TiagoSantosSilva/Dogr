//
//  FavoritePicturesFilterItemViewModel.swift
//  Dogr
//
//  Created by Tiago Silva on 27/12/2022.
//

import Foundation

final class FavoritePicturesFilterItemViewModel: Hashable {

    // MARK: Properties

    let uuid: UUID = .init()
    let name: String
    let breed: String
    var isSelected: Bool

    // MARK: Initialization

    init(breed: String, name: String, isSelected: Bool) {
        self.breed = breed
        self.name = name
        self.isSelected = isSelected
    }

    // MARK: Hashable

    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }

    static func == (lhs: FavoritePicturesFilterItemViewModel, rhs: FavoritePicturesFilterItemViewModel) -> Bool {
        lhs.uuid == rhs.uuid
    }
}
