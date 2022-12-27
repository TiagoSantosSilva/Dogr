//
//  BreedPicturesCollectionViewLayout.swift
//  Dogr
//
//  Created by Tiago Silva on 25/12/2022.
//

import UIKit

final class BreedPicturesCollectionViewLayout: UICollectionViewCompositionalLayout {

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
        let layoutSection = NSCollectionLayoutSection(group: group)
        layoutSection.contentInsets = NSDirectionalEdgeInsets(padding: Section.padding)
        super.init(section: layoutSection)
    }

    required init?(coder: NSCoder) {
        nil
    }
}

// MARK: - Constants

extension BreedPicturesCollectionViewLayout {
    enum Item {
        static let width: NSCollectionLayoutDimension = .fractionalWidth(1/2)
        static let height: NSCollectionLayoutDimension = .fractionalHeight(1.0)
        static let padding: CGFloat = 4
    }

    enum Group {
        static let width: NSCollectionLayoutDimension = .fractionalWidth(1.0)
        static let height: NSCollectionLayoutDimension = .fractionalWidth(1/2)
    }
    
    enum Section {
        static let padding: CGFloat = 4
    }
}
