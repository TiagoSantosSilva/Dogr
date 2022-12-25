//
//  BreedPictureCell.swift
//  Dogr
//
//  Created by Tiago Silva on 25/12/2022.
//

import UIKit

protocol BreedPictureCellDelegate: AnyObject {
}

final class BreedPictureCell: CollectionViewCell {

    // MARK: Subviews

    private let imageView: UIImageView = .init()

    // MARK: Properties

    weak var delegate: BreedPictureCellDelegate?
    private var viewModel: BreedPictureModelViewModel?

    // MARK: Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    // MARK: Life Cycle

    override func prepareForReuse() {
        super.prepareForReuse()
        // Cancel image load via delegate...
        imageView.image = nil
    }

    // MARK: Configuration

    func configure(with viewModel: BreedPictureModelViewModel, delegate: BreedPictureCellDelegate) {
        self.imageView.image = viewModel.image
        self.delegate = delegate
    }

    func display(image: UIImage?) {
        UIView.transition(with: imageView, duration: 0.3, options: .transitionCrossDissolve) {
            self.imageView.image = image
        }
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
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}
