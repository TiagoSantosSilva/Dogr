//
//  CollectionViewListCell.swift
//  Dogr
//
//  Created by Tiago Silva on 27/12/2022.
//

import UIKit

class CollectionViewListCell: UICollectionViewListCell {

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStyle()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }

    // MARK: - Private Functions

    private func setupStyle() {
        var backgroundConfig = UIBackgroundConfiguration.listGroupedCell()
        backgroundConfig.backgroundColor = .systemGray5
        backgroundConfiguration = backgroundConfig
    }
}
