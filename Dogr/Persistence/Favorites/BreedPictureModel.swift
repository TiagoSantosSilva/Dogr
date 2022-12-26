//
//  BreedPictureModel.swift
//  Dogr
//
//  Created by Tiago Silva on 26/12/2022.
//

import UIKit

final class BreedPictureModel: Hashable {

    // MARK: Properties

    let uuid: UUID = .init()
    let url: String
    let breed: String
    let image: UIImage?

    // MARK: Initialization

    init(url: String, breed: String, image: UIImage?) {
        self.url = url
        self.breed = breed
        self.image = image
    }

    // MARK: Hashable

    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }

    // MARK: Equatable

    static func == (lhs: BreedPictureModel, rhs: BreedPictureModel) -> Bool {
        lhs.uuid == rhs.uuid
    }
}
