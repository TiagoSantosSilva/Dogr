//
//  BreedListViewController.swift
//  Dogr
//
//  Created by Tiago Silva on 25/12/2022.
//

import UIKit

protocol BreedListViewControllerDelegate: AnyObject {
    func viewController(_ viewController: BreedListViewController, didSelect breed: BreedListModelViewModel)
}

final class BreedListViewController: ViewController {

    // MARK: Properties

    weak var delegate: BreedListViewControllerDelegate?

    private let collectionViewController: BreedListCollectionViewController
    private let viewModel: BreedListViewModelable

    // MARK: Initialization

    init(viewModel: BreedListViewModelable) {
        self.collectionViewController = BreedListCollectionViewController()
        self.viewModel = viewModel
        super.init()
        self.collectionViewController.delegate = self

        setupNavigationBar()
        view.backgroundColor = .systemBlue
    }

    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupContent()
        setupSubviews()
    }

    // MARK: Setups

    private func setupNavigationBar() {
        title = Localizable.BreedList.navigationBarTitle
    }

    private func setupSubviews() {
        add(collectionViewController)
    }

    private func setupContent() {
        viewModel.loadBreeds { [weak self] in
            switch $0 {
            case .success:
                guard let breeds = self?.viewModel.breeds else { return }
                self?.collectionViewController.update(with: breeds)
            case .error:
                return
            }
        }
    }
}

// MARK: - BreedListCollectionViewControllerDelegate

extension BreedListViewController: BreedListCollectionViewControllerDelegate {
    func collectionViewController(_ collectionViewController: BreedListCollectionViewController, didSelectItemAt indexPath: IndexPath) {
        let breed = viewModel.breeds[indexPath.row]
        delegate?.viewController(self, didSelect: breed)
    }
}
