//
//  NavigationBar.swift
//  Dogr
//
//  Created by Tiago Silva on 25/12/2022.
//

import UIKit

final class NavigationBar: UINavigationBar {

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }

    // MARK: - Setups

    private func setup() {
        self.prefersLargeTitles = true

        let appearance = NavigationBarAppearance()
        self.standardAppearance = appearance
        self.scrollEdgeAppearance = appearance

        tintColor = Colors.tint
    }
}
