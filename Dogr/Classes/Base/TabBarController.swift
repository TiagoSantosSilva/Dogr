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
        tabBar.tintColor = Colors.tint
        tabBar.barTintColor = Colors.TabBar.barTint
        tabBar.unselectedItemTintColor = Colors.TabBar.unselectedItem
        tabBar.isTranslucent = false
        tabBar.backgroundColor = Colors.TabBar.background
    }
}
