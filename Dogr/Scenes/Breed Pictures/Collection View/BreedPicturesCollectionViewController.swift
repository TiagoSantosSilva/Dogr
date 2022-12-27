//
//  BreedPicturesCollectionViewController.swift
//  Dogr
//
//  Created by Tiago Silva on 25/12/2022.
//

import UIKit

protocol BreedPicturesCollectionViewControllerDelegate: AnyObject {
    func collectionViewController(_ collectionViewController: BreedPicturesCollectionViewController, didEndDisplayingAt indexPath: IndexPath)
    func collectionViewController(_ collectionViewController: BreedPicturesCollectionViewController, willDisplay indexPath: IndexPath)
    func collectionViewController(_ collectionViewController: BreedPicturesCollectionViewController, didFavoriteButtonFor viewModel: BreedPictureModelViewModel)
}

final class BreedPicturesCollectionViewController: CollectionViewController {

    // MARK: Enumerations

    private enum Section {
        case main
    }

    weak var delegate: BreedPicturesCollectionViewControllerDelegate?

    // MARK: Typealiases

    private typealias CellRegistration = UICollectionView.CellRegistration<BreedPictureCell, BreedPictureModelViewModel>
    private typealias DataSource = UICollectionViewDiffableDataSource<Section, BreedPictureModelViewModel>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, BreedPictureModelViewModel>

    // MARK: Properties

    private var dataSource: DataSource?

    // MARK: Initialization

    override init() {
        let layout = BreedPicturesCollectionViewLayout()
        let collectionView = CollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(collectionViewLayout: layout)
        self.dataSource = DataSource(collectionView: collectionView, cellProvider: Self.cellProvider { [weak self] item in
            guard let self else { return }
            self.delegate?.collectionViewController(self, didFavoriteButtonFor: item)
        })
        self.collectionView = collectionView
    }

    // MARK: Functions

    func set(image: UIImage?, at indexPath: IndexPath) {
        DispatchQueue.main.async { [weak self] in
            guard let self,
                  let cell = self.collectionView.cellForItem(at: indexPath) as? BreedPictureCell else { return }
            cell.display(image: image)
        }
    }

    @MainActor func update(with images: [BreedPictureModelViewModel]) {
        Task {
            var snapshot = Snapshot()
            snapshot.appendSections([.main])
            snapshot.appendItems(images)
            collectionView.layer.add(CATransition.fade, forKey: nil)
            dataSource?.apply(snapshot, animatingDifferences: false)
        }
    }

    // MARK: Setups

    private static func cellProvider(favoriteTapCompletion: @escaping (BreedPictureModelViewModel) -> Void) -> ((UICollectionView, IndexPath, BreedPictureModelViewModel) -> UICollectionViewCell?) {
        let cellRegistration = CellRegistration { cell, _, cellViewModel in
            cell.configure(with: cellViewModel, buttonTapCompletion: favoriteTapCompletion)
        }

        return { collectionView, indexPath, cellViewModel in
            collectionView.dequeueConfiguredReusableCell(using: cellRegistration,
                                                         for: indexPath,
                                                         item: cellViewModel)
        }
    }
}

// MARK: - UICollectionViewDelegate

extension BreedPicturesCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        delegate?.collectionViewController(self, didEndDisplayingAt: indexPath)
    }

    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        delegate?.collectionViewController(self, willDisplay: indexPath)
    }
}
