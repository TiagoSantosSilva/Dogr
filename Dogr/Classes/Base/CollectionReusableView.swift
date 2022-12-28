//
//  CollectionReusableView.swift
//  Dogr
//
//  Created by Tiago Silva on 26/12/2022.
//

import UIKit

class CollectionReusableView: UICollectionReusableView {

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        stylize()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }

    // MARK: - Functions

    private func stylize() {
        backgroundColor = Colors.background
    }
}
