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

    // MARK: Initialization

    init(url: String) {
        self.url = url
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
