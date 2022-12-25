//
//  ViewController.swift
//  Dogr
//
//  Created by Tiago Silva on 24/12/2022.
//

import UIKit

class ViewController: UIViewController {

    // MARK: Initialization

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        nil
    }

    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
    }
}
