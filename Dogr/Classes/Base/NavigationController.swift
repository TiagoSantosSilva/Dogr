//
//  NavigationController.swift
//  Dogr
//
//  Created by Tiago Silva on 25/12/2022.
//

import UIKit

final class NavigationController: UINavigationController {

    // MARK: - Initialization

    override init(rootViewController: UIViewController) {
        super.init(navigationBarClass: NavigationBar.self, toolbarClass: nil)
        self.setViewControllers([rootViewController], animated: false)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        nil
    }
}
