//
//  TabBarCoordinator.swift
//  Dogr
//
//  Created by Tiago Silva on 25/12/2022.
//

import UIKit

final class TabBarCoordinator: Coordinator {

    // MARK: - Properties

    private let dependencies: DependencyContainable
    private let tabBarController: TabBarController
    private let window: UIWindow

    // MARK: - Initalization

    init(dependencies: DependencyContainable, tabBarController: TabBarController, window: UIWindow) {
        self.dependencies = dependencies
        self.tabBarController = tabBarController
        self.window = window
        super.init()
    }

    // MARK: - Functions

    func start() {
        let breedListCoordinator = BreedListCoordinator(dependencies: dependencies)
        let favoritePicturesCoordinator = FavoritePicturesCoordinator(dependencies: dependencies)

        [breedListCoordinator, favoritePicturesCoordinator].forEach { coordinators.append($0) }
        let viewControllers = ([breedListCoordinator, favoritePicturesCoordinator] as [ViewControllerRepresentable]).map { $0.viewController }
        let items: [UITabBarItem] = [.init(title: Localizable.BreedList.tabBarTitle, image: .TabBar.breedList, selectedImage: .TabBar.breedList),
                                     .init(title: Localizable.FavoritePictures.tabBarTitle, image: .TabBar.favoritePictures, selectedImage: .TabBar.favoritePictures)]

        items.enumerated().forEach { viewControllers[$0.offset].tabBarItem = $0.element }

        tabBarController.setViewControllers(viewControllers, animated: false)
        window.rootViewController = tabBarController
    }
}

