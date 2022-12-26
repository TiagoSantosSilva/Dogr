//
//  BreedPictureModel.swift
//  Dogr
//
//  Created by Tiago Silva on 26/12/2022.
//

import UIKit

final class BreedPictureModel {

    // MARK: Properties

    let url: String
    let breed: String
    let image: UIImage?

    // MARK: Initialization

    init(url: String, breed: String, image: UIImage?) {
        self.url = url
        self.breed = breed
        self.image = image
    }
}
