//
//  FavoritePicturesCell.swift
//  Dogr
//
//  Created by Tiago Silva on 26/12/2022.
//

import UIKit

final class FavoritePicturesCell: ImageCell {

    // MARK: Configuration

    func configure(with viewModel: BreedPictureModel) {
        imageView.image = viewModel.image
    }
}
