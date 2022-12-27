//
//  FavoritePicturesCollectionViewCell.swift
//  Dogr
//
//  Created by Tiago Silva on 27/12/2022.
//

import UIKit

final class FavoritePicturesCollectionViewCell: CollectionViewListCell {

    // MARK: Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    // MARK: Configuration

    func configure(with viewModel: FavoritePicturesFilterItemViewModel) {
        var configuration = defaultContentConfiguration()
        configuration.text = viewModel.name
        contentConfiguration = configuration
        accessories = viewModel.isSelected ? [.checkmark()] : []
    }

    // MARK: Setups

    private func setup() {
        var configuration = defaultContentConfiguration()
        configuration.textProperties.color = .label
        contentConfiguration = configuration
        tintColor = .systemBlue
    }
}
