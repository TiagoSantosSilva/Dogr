//
//  FavoritePicturesCollectionViewLayout.swift
//  Dogr
//
//  Created by Tiago Silva on 26/12/2022.
//

import UIKit

final class FavoritePicturesCollectionViewLayout: UICollectionViewCompositionalLayout {

    // MARK: Initialization

    init() {
        let itemSize = NSCollectionLayoutSize(widthDimension: Item.width,
                                              heightDimension: Item.height)
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(padding: Item.padding)

        let groupSize = NSCollectionLayoutSize(widthDimension: Group.width,
                                               heightDimension: Group.height)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])

        let header = NSCollectionLayoutSize(widthDimension: Header.width,
                                            heightDimension: Header.height)
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: header,
                                                                        elementKind: ElementKinds.header,
                                                                        alignment: .top)

        let layoutSection = NSCollectionLayoutSection(group: group)
        layoutSection.contentInsets = NSDirectionalEdgeInsets(padding: Section.padding)
        layoutSection.boundarySupplementaryItems = [sectionHeader]
        super.init(section: layoutSection)
    }

    required init?(coder: NSCoder) {
        nil
    }
}

// MARK: - Constants

extension FavoritePicturesCollectionViewLayout {
    enum ElementKinds {
        static let header: String = "favorite-pictures-header-kind"
    }

    enum Item {
        static let width: NSCollectionLayoutDimension = .fractionalWidth(1/2)
        static let height: NSCollectionLayoutDimension = .fractionalHeight(1.0)
        static let padding: CGFloat = 4
    }

    enum Group {
        static let width: NSCollectionLayoutDimension = .fractionalWidth(1.0)
        static let height: NSCollectionLayoutDimension = .fractionalWidth(1/2)
    }

    enum Header {
        static let width: NSCollectionLayoutDimension = .fractionalWidth(1.0)
        static let height: NSCollectionLayoutDimension = .estimated(44)
    }

    enum Section {
        static let padding: CGFloat = 4
    }
}
