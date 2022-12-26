//
//  FavoritePicturesCoordinator.swift
//  Dogr
//
//  Created by Tiago Silva on 25/12/2022.
//

import UIKit

final class FavoritePicturesCoordinator: Coordinator, ViewControllerRepresentable {

    // MARK: Properties

    var viewController: UIViewController {
        navigator.navigationController
    }

    // MARK: Private Properties

    private let dependencies: DependencyContainable
    private let navigator: Navigatable

    // MARK: Initialization

    init(dependencies: DependencyContainable) {
        self.dependencies = dependencies

        let viewModel = FavoritePicturesViewModel(dependencies: dependencies)
        let viewController = FavoritePicturesViewController(viewModel: viewModel)
        let navigationController = NavigationController(rootViewController: viewController)

        self.navigator = Navigator(dependencies: dependencies, navigationController: navigationController)
    }
}