//
//  BreedListViewController.swift
//  Dogr
//
//  Created by Tiago Silva on 25/12/2022.
//

import UIKit

final class BreedListViewController: ViewController {

    // MARK: Properties

    private let viewModel: BreedListViewModelable

    // MARK: Initialization

    init(viewModel: BreedListViewModelable) {
        self.viewModel = viewModel
        super.init()
        title = Localizable.BreedList.navigationBarTitle
        view.backgroundColor = .systemBlue
    }

    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupContent()
    }

    // MARK: Setups

    private func setupContent() {
        viewModel.loadBreeds { [weak self] in
            switch $0 {
            case .success:
                print("🍊", self?.viewModel.breeds)
            case .error:
                return
            }
        }
    }
}
