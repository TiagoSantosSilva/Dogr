//
//  ViewControllerRepresentable.swift
//  Dogr
//
//  Created by Tiago Silva on 25/12/2022.
//

import UIKit

protocol ViewControllerRepresentable: AnyObject {
    var viewController: UIViewController { get }
}

