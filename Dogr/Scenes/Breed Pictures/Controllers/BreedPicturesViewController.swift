//
//  BreedPicturesViewController.swift
//  Dogr
//
//  Created by Tiago Silva on 25/12/2022.
//

import Combine
import os.log
import UIKit

protocol BreedPicturesViewControllerDelegate: AnyObject {
    func viewControllerDidPop(_ viewController: BreedPicturesViewController)
}

final class BreedPicturesViewController: ViewController {

    // MARK: Properties

    weak var delegate: BreedPicturesViewControllerDelegate?
    private var cancellables: Set<AnyCancellable> = .init()
    private let collectionViewController: BreedPicturesCollectionViewController
    private let viewModel: BreedPicturesViewModelable

    // MARK: Initialization

    init(viewModel: BreedPicturesViewModelable) {
        self.collectionViewController = BreedPicturesCollectionViewController()
        self.viewModel = viewModel
        super.init()
        setupNavigationBar()
        collectionViewController.delegate = self
    }

    deinit {
        delegate?.viewControllerDidPop(self)
    }

    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupContent()
        setupSubviews()
    }

    // MARK: Setups

    private func setupNavigationBar() {
        title = viewModel.title
    }

    private func setupSubviews() {
        add(collectionViewController)
    }

    private func setupContent() {
        viewModel.images.sink { error in
            os_log("TODO ⚠️")
        } receiveValue: { [weak self] imageList in
            self?.collectionViewController.update(with: imageList)
        }.store(in: &cancellables)
    }
}

// MARK: - BreedPicturesCollectionViewControllerDelegate

extension BreedPicturesViewController: BreedPicturesCollectionViewControllerDelegate {
    func collectionViewController(_ collectionViewController: BreedPicturesCollectionViewController, didEndDisplayingAt indexPath: IndexPath) {
        viewModel.cancel(indexPath: indexPath)
    }

    func collectionViewController(_ collectionViewController: BreedPicturesCollectionViewController, willDisplay indexPath: IndexPath) {
        viewModel.loadImage(for: indexPath) { [weak self] in
            switch $0 {
            case let .success(image):
                self?.collectionViewController.set(image: image, at: indexPath)
            case .failure:
                return
            }
        }
    }

    func collectionViewController(_ collectionViewController: BreedPicturesCollectionViewController, didFavoriteButtonFor viewModel: BreedPictureModelViewModel) {
        self.viewModel.changeFavoriteStatus(of: viewModel)
    }
}
