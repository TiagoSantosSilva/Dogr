//
//  TabBarController.swift
//  Dogr
//
//  Created by Tiago Silva on 24/12/2022.
//

import UIKit

final class TabBarController: UITabBarController {

    // MARK: Initialization

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder: NSCoder) {
        nil
    }

    // MARK: Setups

    private func setup() {
        tabBar.tintColor = .systemBlue
        tabBar.barTintColor = .systemGray5
        tabBar.unselectedItemTintColor = .secondaryLabel
        tabBar.isTranslucent = false
        tabBar.backgroundColor = .systemGray5
    }
}
