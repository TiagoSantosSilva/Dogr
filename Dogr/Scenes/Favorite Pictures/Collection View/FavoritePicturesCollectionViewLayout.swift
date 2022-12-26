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
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/2),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(padding: 4)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalWidth(1/2))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])

        let header = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                            heightDimension: .estimated(44))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: header,
                                                                        elementKind: ElementKinds.header,
                                                                        alignment: .top)

        let layoutSection = NSCollectionLayoutSection(group: group)
        layoutSection.contentInsets = NSDirectionalEdgeInsets(padding: 4)
        layoutSection.boundarySupplementaryItems = [sectionHeader]
        super.init(section: layoutSection)
    }

    required init?(coder: NSCoder) {
        nil
    }
}

// MARK: - Element Kinds

extension FavoritePicturesCollectionViewLayout {
    enum ElementKinds {
        static let header: String = "favorite-pictures-header-kind"
    }
}
