//
//  BreedPictureCell.swift
//  Dogr
//
//  Created by Tiago Silva on 25/12/2022.
//

import UIKit

protocol BreedPictureCellDelegate: AnyObject {
    func cell(_ cell: BreedPictureCell, didTapLikeButtonFor viewModel: BreedPictureModelViewModel)
}

final class BreedPictureCell: CollectionViewCell {

    // MARK: Subviews

    private let imageView: UIImageView = .init()
    private let likeButton: BreedPictureCellLikeButton = .init()

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
        likeButton.reset()
        likeButton.isHidden = true
    }

    // MARK: Configuration

    func configure(with viewModel: BreedPictureModelViewModel, delegate: BreedPictureCellDelegate) {
        self.viewModel = viewModel
        self.delegate = delegate
        imageView.image = viewModel.image
        likeButton.isHidden = viewModel.image == nil
        likeButton.configure(isLiked: viewModel.isLiked == true)
    }

    func display(image: UIImage?) {
        likeButton.isHidden = image == nil
        imageView.transitionCrossDissolve {
            self.imageView.image = image
        }
    }

    // MARK: Setups

    private func setup() {
        likeButton.isHidden = true
        contentView.add(subviews: imageView, likeButton)
        setupStyle()
        setupConstraints()
        imageView.contentMode = .scaleAspectFill

        likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
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

            likeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constraints.LikeButton.padding),
            likeButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constraints.LikeButton.padding),
            likeButton.heightAnchor.constraint(equalToConstant: Constraints.LikeButton.size),
            likeButton.widthAnchor.constraint(equalToConstant: Constraints.LikeButton.size)
        ])
    }

    @objc
    private func likeButtonTapped(_ sender: UIButton) {
        viewModel?.isLiked.toggle()
        likeButton.configure(isLiked: viewModel?.isLiked == true)
        guard let viewModel = viewModel else { return }
        delegate?.cell(self, didTapLikeButtonFor: viewModel)
    }
}

private extension BreedPictureCell {
    final class BreedPictureCellLikeButton: UIButton {

        // MARK:

        override init(frame: CGRect) {
            super.init(frame: frame)
            setImage(LikeButtonImage.notLiked, for: .normal)
        }

        required init?(coder: NSCoder) {
            nil
        }

        // MARK:

        func configure(isLiked: Bool) {
            transitionCrossDissolve {
                self.setImage(isLiked ? LikeButtonImage.liked : LikeButtonImage.notLiked, for: .normal)
            }
        }

        func reset() {
            setImage(LikeButtonImage.notLiked, for: .normal)
        }
    }

    enum LikeButtonImage {
        static let liked = UIImage(named: "heart-filled")
        static let notLiked = UIImage(named: "heart-empty")
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
