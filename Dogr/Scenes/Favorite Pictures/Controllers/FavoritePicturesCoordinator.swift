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

    private weak var favoritePicturesViewController: FavoritePicturesViewController?
    private weak var filterCoordinator: FavoritePicturesFilterCoordinator?
    private let dependencies: DependencyContainable
    private let navigator: Navigatable

    // MARK: Initialization

    init(dependencies: DependencyContainable) {
        self.dependencies = dependencies

        let viewModel = FavoritePicturesViewModel(dependencies: dependencies)
        let favoritePicturesViewController = FavoritePicturesViewController(viewModel: viewModel)
        let navigationController = NavigationController(rootViewController: favoritePicturesViewController)
        self.navigator = Navigator(dependencies: dependencies, navigationController: navigationController)
        super.init()
        self.favoritePicturesViewController = favoritePicturesViewController
        favoritePicturesViewController.delegate = self
    }
}

// MARK: - FavoritePicturesViewControllerDelegate

extension FavoritePicturesCoordinator: FavoritePicturesViewControllerDelegate {
    func viewController(_ viewController: FavoritePicturesViewController, didTap sender: UIBarButtonItem, with breeds: [FavoritePicturesFilterItemViewModel]) {
        let coordinator = FavoritePicturesFilterCoordinator(dependencies: dependencies,
                                                            parentNavigator: navigator,
                                                            items: breeds)
        initiate(coordinator: coordinator)
        self.filterCoordinator = coordinator
        self.filterCoordinator?.delegate = self
    }
}

// MARK: FavoritePicturesFilterCoordinatorDelegate

extension FavoritePicturesCoordinator: FavoritePicturesFilterCoordinatorDelegate {
    func coordinator(_ coordinator: FavoritePicturesFilterCoordinator, didDismissWith items: [FavoritePicturesFilterItemViewModel]) {
        favoritePicturesViewController?.applyFilter(with: items)
    }
}
