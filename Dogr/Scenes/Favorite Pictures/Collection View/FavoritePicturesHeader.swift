//
//  FavoritePicturesHeader.swift
//  Dogr
//
//  Created by Tiago Silva on 26/12/2022.
//

import UIKit

final class FavoritePictureHeader: CollectionReusableView {

    // MARK: Subviews

    private let nameLabel: UILabel = .init()

    // MARK: Properties

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    // MARK: Life Cycle

    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
    }

    // MARK: - Functions

    func configure(with group: BreedPictureGroupModel) {
        nameLabel.text = group.breed.capitalized
    }

    // MARK: - Setups

    private func setup() {
        add(subviews: nameLabel)
        setupStyle()
        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constraints.NameLabel.padding),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constraints.NameLabel.padding),
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    private func setupStyle() {
        nameLabel.font = .systemFont(ofSize: 20, weight: .bold)
        nameLabel.textAlignment = .center
    }
}

// MARK: - Constraints

private extension FavoritePictureHeader {
    enum Constraints {
        enum NameLabel {
            static let padding: CGFloat = 8
        }
    }
}
