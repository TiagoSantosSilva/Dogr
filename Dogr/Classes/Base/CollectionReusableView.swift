//
//  CollectionReusableView.swift
//  Dogr
//
//  Created by Tiago Silva on 26/12/2022.
//

import UIKit

class CollectionReusableView: UICollectionReusableView {

    // MARK: - Initialization

    public override init(frame: CGRect) {
        super.init(frame: frame)
        stylize()
    }

    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        nil
    }

    // MARK: - Functions

    private func stylize() {
        backgroundColor = .systemGray6
    }
}
