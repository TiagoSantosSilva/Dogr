//
//  UIViewController.swift
//  Dogr
//
//  Created by Tiago Silva on 25/12/2022.
//

import UIKit

public extension UIViewController {
    func add(_ child: UIViewController) {
        view.addSubview(child.view)
        addChild(child)
        child.didMove(toParent: self)
    }
}
