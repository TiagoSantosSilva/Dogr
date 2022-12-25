//
//  AppCoordinator.swift
//  Dogr
//
//  Created by Tiago Silva on 25/12/2022.
//

import UIKit

final class AppCoordinator: Coordinator {

    // MARK: - Properties

    private let dependencies: DependencyContainable
    private let window: UIWindow

    // MARK: - Initialization

    init(dependencies: DependencyContainable, window: UIWindow) {
        self.dependencies = dependencies
        self.window = window
        super.init()
    }

    // MARK: - Coordinator

    func start() {
        initiate(coordinator: TabBarCoordinator(dependencies: dependencies,
                                                tabBarController: TabBarController(),
                                                window: window))
    }
}
