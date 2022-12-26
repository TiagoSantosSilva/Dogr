//
//  FavoritePicturesViewController.swift
//  Dogr
//
//  Created by Tiago Silva on 25/12/2022.
//

import Combine
import UIKit

final class FavoritePicturesViewController: ViewController {

    // MARK: Properties

    private let collectionViewController: FavoritePicturesCollectionViewController
    private let viewModel: FavoritePicturesViewModelable
    private var cancellables: Set<AnyCancellable> = .init()

    // MARK: Initialization

    init(viewModel: FavoritePicturesViewModelable) {
        self.collectionViewController = FavoritePicturesCollectionViewController()
        self.viewModel = viewModel
        super.init()

        setupNavigationBar()
    }

    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupContent()
        setupSubviews()
    }

    // MARK: Setups

    private func setupNavigationBar() {
        title = Localizable.FavoritePictures.navigationBarTitle
    }

    private func setupSubviews() {
        add(collectionViewController)
    }

    private func setupContent() {
        viewModel.favoriteRepository.pictures.sink { [weak self] in
            self?.collectionViewController.update(with: $0)
        }.store(in: &cancellables)
    }
}
