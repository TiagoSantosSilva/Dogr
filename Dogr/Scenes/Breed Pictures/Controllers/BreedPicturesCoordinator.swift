//
//  BreedPicturesCoordinator.swift
//  Dogr
//
//  Created by Tiago Silva on 25/12/2022.
//

import UIKit

final class BreedPicturesCoordinator: Coordinator {

    // MARK: Private Properties

    private let dependencies: DependencyContainable
    private let navigator: Navigatable
    private let breed: BreedListModelViewModel

    // MARK: Initialization

    init(dependencies: DependencyContainable, navigator: Navigatable, breed: BreedListModelViewModel) {
        self.dependencies = dependencies
        self.navigator = navigator
        self.breed = breed
    }

    // MARK: Functions

    func start() {
        let loader = BreedPicturesLoader(dependencies: dependencies, breed: breed)
        let viewModel = BreedPicturesViewModel(breed: breed, loader: loader)
        let viewController = BreedPicturesViewController(viewModel: viewModel)
        viewController.delegate = self

        navigator.transition(to: viewController, as: .push)
    }
}

// MARK: - BreedPicturesViewControllerDelegate

extension BreedPicturesCoordinator: BreedPicturesViewControllerDelegate {
    func viewControllerDidPop(_ viewController: BreedPicturesViewController) {
        end()
    }
}
