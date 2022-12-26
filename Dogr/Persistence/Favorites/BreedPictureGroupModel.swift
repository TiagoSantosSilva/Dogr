//
//  BreedPictureGroupModel.swift
//  Dogr
//
//  Created by Tiago Silva on 26/12/2022.
//

import Foundation

final class BreedPictureGroupModel: Hashable {

    // MARK: Properties

    let uuid: UUID = .init()
    let breed: String
    var pictures: [BreedPictureModel]

    // MARK: Initialization

    init(breed: String, pictures: [BreedPictureModel]) {
        self.breed = breed
        self.pictures = pictures
    }

    // MARK: Hashable

    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }

    static func == (lhs: BreedPictureGroupModel, rhs: BreedPictureGroupModel) -> Bool {
        lhs.uuid == rhs.uuid
    }
}
