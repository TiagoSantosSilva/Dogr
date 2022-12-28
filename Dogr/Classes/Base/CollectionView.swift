//
//  CollectionView.swift
//  Dogr
//
//  Created by Tiago Silva on 25/12/2022.
//

import UIKit

class CollectionView: UICollectionView {

    // MARK: - Initialization

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }

    // MARK: - Setups

    private func setup() {
        backgroundColor = Colors.background
        keyboardDismissMode = .onDrag
    }
}
