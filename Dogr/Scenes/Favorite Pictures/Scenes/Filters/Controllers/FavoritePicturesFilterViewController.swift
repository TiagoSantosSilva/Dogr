//
//  FavoritePicturesFilterViewController.swift
//  Dogr
//
//  Created by Tiago Silva on 27/12/2022.
//

import UIKit

protocol FavoritePicturesFilterViewControllerDelegate: AnyObject {
    func viewController(_ viewController: FavoritePicturesFilterViewController, didTap doneButton: UIBarButtonItem, with items: [FavoritePicturesFilterItemViewModel])
    func viewControllerDidDismiss(_ viewController: FavoritePicturesFilterViewController)
}

final class FavoritePicturesFilterViewController: ViewController {

    // MARK: Properties

    weak var delegate: FavoritePicturesFilterViewControllerDelegate?

    private let collectionViewController: FavoritePicturesFilterCollectionViewController
    private let viewModel: FavoritePicturesFilterViewModelable

    // MARK: Initialization

    init(viewModel: FavoritePicturesFilterViewModelable) {
        self.collectionViewController = FavoritePicturesFilterCollectionViewController()
        self.viewModel = viewModel
        super.init()
        self.collectionViewController.delegate = self
    }

    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupSubviews()
        setupContent()
    }

    deinit {
        delegate?.viewControllerDidDismiss(self)
    }

    // MARK: Setups

    private func setupNavigationBar() {
        let resetButton = UIBarButtonItem(title: Localizable.FavoritePicturesFilter.resetButton,
                                          style: .done,
                                          target: self,
                                          action: #selector(resetButtonTapped))
        navigationItem.setLeftBarButton(resetButton, animated: false)
        let doneButton = UIBarButtonItem(title: Localizable.FavoritePicturesFilter.doneButton,
                                         style: .done,
                                         target: self,
                                         action: #selector(doneButtonTapped))
        navigationItem.setRightBarButton(doneButton, animated: false)

        navigationController?.navigationBar.prefersLargeTitles = false
        title = Localizable.FavoritePicturesFilter.title
    }

    private func setupSubviews() {
        add(collectionViewController)
    }

    private func setupContent() {
        collectionViewController.setup(with: viewModel.items)
    }

    // MARK: - Selectors

    @objc private func doneButtonTapped(_ sender: UIBarButtonItem) {
        delegate?.viewController(self, didTap: sender, with: viewModel.items)
    }

    @objc private func resetButtonTapped(_ sender: UIBarButtonItem) {
        viewModel.resetFilter()
        collectionViewController.update(items: viewModel.items)
    }
}

// MARK: - FavoritePicturesFilterCollectionViewControllerDelegate

extension FavoritePicturesFilterViewController: FavoritePicturesFilterCollectionViewControllerDelegate {
    func collectionViewController(_ collectionViewController: FavoritePicturesFilterCollectionViewController, didSelectItemAt indexPath: IndexPath) {
        print(#function)
        viewModel.itemTapped(at: indexPath)
        collectionViewController.update(items: viewModel.items)
    }
}
