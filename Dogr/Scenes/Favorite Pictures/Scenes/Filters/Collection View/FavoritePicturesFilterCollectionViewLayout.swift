//
//  FavoritePicturesFilterCollectionViewLayout.swift
//  Dogr
//
//  Created by Tiago Silva on 27/12/2022.
//

import UIKit

final class FavoritePicturesFilterCollectionViewLayout: UICollectionViewCompositionalLayout {

    static func make() -> UICollectionViewCompositionalLayout {
        var layout = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        layout.headerMode = .none
        layout.footerMode = .none
        layout.backgroundColor = .systemGray6
        return .list(using: layout)
    }
}
