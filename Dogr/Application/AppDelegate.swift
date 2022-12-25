//
//  AppDelegate.swift
//  Dogr
//
//  Created by Tiago Silva on 24/12/2022.
//

import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: Properties

    lazy var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)

    private let dependencies: DependencyContainable

    private lazy var coordinator: AppCoordinator = {
        guard let window = window else { fatalError() }
        return AppCoordinator(dependencies: dependencies, window: window)
    }()

    // MARK: Initialization

    override init() {
        self.dependencies = DependencyContainer()
        super.init()
    }

    // MARK: Life Cycle

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window?.makeKeyAndVisible()
        coordinator.start()
        return true
    }
}
