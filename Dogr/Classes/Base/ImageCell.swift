//
//  ImageCell.swift
//  Dogr
//
//  Created by Tiago Silva on 26/12/2022.
//

import UIKit

class ImageCell: CollectionViewCell {

    // MARK: Subviews

    let imageView: UIImageView = .init()

    // MARK: Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    // MARK: Life Cycle

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }

    // MARK: Setups

    private func setup() {
        contentView.add(subviews: imageView)
        setupStyle()
        setupConstraints()
        imageView.contentMode = .scaleAspectFill
    }

    private func setupStyle() {
        round()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
