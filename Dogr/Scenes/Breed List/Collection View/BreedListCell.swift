//
//  BreedListCell.swift
//  Dogr
//
//  Created by Tiago Silva on 25/12/2022.
//

import UIKit

final class BreedListCell: CollectionViewCell {

    // MARK: Subviews

    private let nameLabel: UILabel = .init()

    // MARK: Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    // MARK: Life Cycle

    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
    }

    // MARK: Configuration

    func configure(with viewModel: BreedListModelViewModel) {
        nameLabel.text = viewModel.displayName
    }

    // MARK: Setups

    private func setup() {
        contentView.add(subviews: nameLabel)
        setupStyle()
        setupConstraints()
    }

    private func setupStyle() {
        round()

        nameLabel.textColor = .label
        nameLabel.textAlignment = .left
        nameLabel.font = Style.NameLabel.font
    }

    private func setupConstraints() {
        let leadingAnchor = nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constraints.NameLabel.padding)
        leadingAnchor.priority = Priorities.leading
        let trailingAnchor = nameLabel.leadingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constraints.NameLabel.padding)
        trailingAnchor.priority = Priorities.trailing
        NSLayoutConstraint.activate([
            leadingAnchor,
            trailingAnchor,
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}

// MARK: - Constraints

private extension BreedListCell {
    enum Constraints {
        enum NameLabel {
            static let padding: CGFloat = 8
        }
    }

    enum Style {
        enum NameLabel {
            static let font: UIFont = .systemFont(ofSize: 14, weight: .medium)
        }
    }

    enum Priorities {
        static let leading: UILayoutPriority = .init(999)
        static let trailing: UILayoutPriority = .init(998)
    }
}
