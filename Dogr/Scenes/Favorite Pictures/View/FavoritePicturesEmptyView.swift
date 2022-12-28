//
//  FavoritePicturesEmptyView.swift
//  Dogr
//
//  Created by Tiago Silva on 27/12/2022.
//

import UIKit

final class FavoritePicturesEmptyView: View {

    // MARK: Properties

    private let stackView: UIStackView = .init()
    private let titleLabel: FavoritePicturesEmptyViewLabel = .init(font: Style.TitleLabel.font,
                                                                   text: Localizable.FavoritePictures.EmptyBar.title,
                                                                   textColor: Colors.label)
    private let messageLabel: FavoritePicturesEmptyViewLabel = .init(font: Style.MessageLabel.font,
                                                                     text: Localizable.FavoritePictures.EmptyBar.message,
                                                                     textColor: Colors.label)

    // MARK: Initialization

    override init() {
        super.init()
        setup()
    }

    // MARK: Setups

    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = Constraints.StackView.spacing
        [titleLabel, messageLabel].forEach(stackView.addArrangedSubview)

        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constraints.StackView.padding),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constraints.StackView.padding)
        ])
    }
}

// MARK: - FavoritePicturesEmptyView

private extension FavoritePicturesEmptyView {
    final class FavoritePicturesEmptyViewLabel: UILabel {

        // MARK: Initialization

        init(font: UIFont, text: String, textColor: UIColor) {
            super.init(frame: .zero)
            setup(font: font, text: text, textColor: textColor)
        }

        required init?(coder: NSCoder) {
            nil
        }

        // MARK: Setups

        private func setup(font: UIFont, text: String, textColor: UIColor) {
            self.font = font
            self.text = text
            self.textColor = textColor
            textAlignment = .center
            numberOfLines = 0
        }
    }
}

// MARK: - Constants

private extension FavoritePicturesEmptyView {
    enum Constraints {
        enum StackView {
            static let padding: CGFloat = 40
            static let spacing: CGFloat = 8
        }
    }

    enum Style {
        enum TitleLabel {
            static let font = UIFont.systemFont(ofSize: 20, weight: .bold)
        }

        enum MessageLabel {
            static let font = UIFont.systemFont(ofSize: 16, weight: .regular)
        }
    }
}
