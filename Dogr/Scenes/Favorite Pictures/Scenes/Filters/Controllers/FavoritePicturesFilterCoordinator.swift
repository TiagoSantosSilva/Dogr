//
//  FavoritePicturesFilterCoordinator.swift
//  Dogr
//
//  Created by Tiago Silva on 27/12/2022.
//

import UIKit

protocol FavoritePicturesFilterCoordinatorDelegate: AnyObject {
    func coordinator(_ coordinator: FavoritePicturesFilterCoordinator, didDismissWith items: [FavoritePicturesFilterItemViewModel])
}

final class FavoritePicturesFilterCoordinator: Coordinator {

    // MARK: Properties

    weak var delegate: FavoritePicturesFilterCoordinatorDelegate?
    private let dependencies: DependencyContainable
    private let navigator: Navigatable
    private weak var parentNavigator: Navigatable?

    // MARK: Initialization

    init(dependencies: DependencyContainable, parentNavigator: Navigatable?, items: [FavoritePicturesFilterItemViewModel]) {
        self.dependencies = dependencies

        let viewModel = FavoriteFilterPicturesViewModel(items: items)
        let viewController = FavoritePicturesFilterViewController(viewModel: viewModel)
        let navigationController = NavigationController(rootViewController: viewController)

        self.navigator = Navigator(dependencies: dependencies, navigationController: navigationController)
        self.parentNavigator = parentNavigator
        super.init()
        viewController.delegate = self
    }

    // MARK: Coordinator

    func start() {
        parentNavigator?.transition(to: navigator.navigationController, as: .modal, animated: true)
    }
}

// MARK: - FavoritePicturesFilterViewControllerDelegate

extension FavoritePicturesFilterCoordinator: FavoritePicturesFilterViewControllerDelegate {
    func viewControllerDidDismiss(_ viewController: FavoritePicturesFilterViewController) {
        end()
    }

    func viewController(_ viewController: FavoritePicturesFilterViewController, didTap doneButton: UIBarButtonItem, with items: [FavoritePicturesFilterItemViewModel]) {
        navigator.dismiss()
        delegate?.coordinator(self, didDismissWith: items)
        end()
    }
}
