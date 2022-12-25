//
//  BreedListCollectionViewLayout.swift
//  Dogr
//
//  Created by Tiago Silva on 25/12/2022.
//

import UIKit

final class BreedListCollectionViewLayout: UICollectionViewCompositionalLayout {

    // MARK: Initialization

    init() {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(horizontal: 16, vertical: 8)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .absolute(100))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
                                                     subitems: [item])
        let layoutSection = NSCollectionLayoutSection(group: group)
        super.init(section: layoutSection)
    }

    required init?(coder: NSCoder) {
        nil
    }
}
