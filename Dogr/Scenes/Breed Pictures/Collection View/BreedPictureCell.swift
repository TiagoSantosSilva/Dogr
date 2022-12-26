//
//  BreedPictureCell.swift
//  Dogr
//
//  Created by Tiago Silva on 25/12/2022.
//

import UIKit

protocol BreedPictureCellDelegate: AnyObject {
    func cell(_ cell: BreedPictureCell, didTapFavoriteButtonFor viewModel: BreedPictureModelViewModel)
}

final class BreedPictureCell: CollectionViewCell {

    // MARK: Subviews

    private let imageView: UIImageView = .init()
    private let favoriteButton: BreedPictureCellFavoriteButton = .init()

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
        imageView.image = nil
        favoriteButton.reset()
        favoriteButton.isHidden = true
    }

    // MARK: Configuration

    func configure(with viewModel: BreedPictureModelViewModel, delegate: BreedPictureCellDelegate) {
        self.viewModel = viewModel
        self.delegate = delegate
        imageView.image = viewModel.image
        favoriteButton.isHidden = viewModel.image == nil
        favoriteButton.configure(isFavorite: viewModel.isFavorite == true)
    }

    func display(image: UIImage?) {
        favoriteButton.isHidden = image == nil
        imageView.transitionCrossDissolve {
            self.imageView.image = image
        }
    }

    // MARK: Setups

    private func setup() {
        favoriteButton.isHidden = true
        contentView.add(subviews: imageView, favoriteButton)
        setupStyle()
        setupConstraints()
        imageView.contentMode = .scaleAspectFill

        favoriteButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
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

            favoriteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constraints.LikeButton.padding),
            favoriteButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constraints.LikeButton.padding),
            favoriteButton.heightAnchor.constraint(equalToConstant: Constraints.LikeButton.size),
            favoriteButton.widthAnchor.constraint(equalToConstant: Constraints.LikeButton.size)
        ])
    }

    @objc
    private func likeButtonTapped(_ sender: UIButton) {
        favoriteButton.configure(isFavorite: !(viewModel?.isFavorite == true))
        guard let viewModel = viewModel else { return }
        delegate?.cell(self, didTapFavoriteButtonFor: viewModel)
    }
}

private extension BreedPictureCell {
    final class BreedPictureCellFavoriteButton: UIButton {

        // MARK:

        override init(frame: CGRect) {
            super.init(frame: frame)
            setImage(FavoriteButtonImage.notFavorite, for: .normal)
        }

        required init?(coder: NSCoder) {
            nil
        }

        // MARK:

        func configure(isFavorite: Bool) {
            transitionCrossDissolve {
                self.setImage(isFavorite ? FavoriteButtonImage.favorite : FavoriteButtonImage.notFavorite, for: .normal)
            }
        }

        func reset() {
            setImage(FavoriteButtonImage.notFavorite, for: .normal)
        }
    }

    enum FavoriteButtonImage {
        static let favorite = UIImage(named: "heart-filled")
        static let notFavorite = UIImage(named: "heart-empty")
    }
}

// MARK: - Constraints

private extension BreedPictureCell {
    enum Constraints {
        enum LikeButton {
            static let padding: CGFloat = 8
            static let size: CGFloat = 24
        }
    }
}
