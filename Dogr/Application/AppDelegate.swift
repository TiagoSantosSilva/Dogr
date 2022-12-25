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

    // MARK: Life Cycle

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window?.makeKeyAndVisible()
        let vc = ViewController()
        vc.view.backgroundColor = .systemBlue
        window?.rootViewController = vc
        return true
    }
}
