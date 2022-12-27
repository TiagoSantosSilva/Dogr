//
//  FavoritePicturesFilterCollectionViewController.swift
//  Dogr
//
//  Created by Tiago Silva on 27/12/2022.
//

import UIKit

protocol FavoritePicturesFilterCollectionViewControllerDelegate: AnyObject {
    func collectionViewController(_ collectionViewController: FavoritePicturesFilterCollectionViewController, didSelectItemAt indexPath: IndexPath)
}

final class FavoritePicturesFilterCollectionViewController: CollectionViewController {

    // MARK: Enumerations

    private enum Section {
        case main
    }

    // MARK: Typealiases

    private typealias CellRegistration = UICollectionView.CellRegistration<FavoritePicturesCollectionViewCell, FavoritePicturesFilterItemViewModel>
    private typealias DataSource = UICollectionViewDiffableDataSource<Section, FavoritePicturesFilterItemViewModel>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, FavoritePicturesFilterItemViewModel>

    // MARK: Properties

    weak var delegate: FavoritePicturesFilterCollectionViewControllerDelegate?

    private let dataSource: DataSource

    // MARK: Initialization

    override init() {
        let layout = FavoritePicturesFilterCollectionViewLayout.make()
        let collectionView = CollectionView(frame: .zero, collectionViewLayout: layout)
        self.dataSource = DataSource(collectionView: collectionView, cellProvider: Self.cellProvider)
        super.init(collectionViewLayout: layout)
        self.collectionView = collectionView
    }

    // MARK: Functions

    func setup(with items: [FavoritePicturesFilterItemViewModel]) {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(items)
        collectionView.layer.add(CATransition.fade, forKey: nil)
        dataSource.apply(snapshot, animatingDifferences: false)
    }

    func update(items: [FavoritePicturesFilterItemViewModel]) {
        var snapshot = dataSource.snapshot()
        snapshot.reconfigureItems(items)
        dataSource.apply(snapshot, animatingDifferences: false)
    }

    // MARK: Setups

    private static var cellProvider: ((UICollectionView, IndexPath, FavoritePicturesFilterItemViewModel) -> UICollectionViewCell?) {
        let cellRegistration = CellRegistration { cell, _, cellViewModel in
            cell.configure(with: cellViewModel)
        }

        return { collectionView, indexPath, cellViewModel in
            collectionView.dequeueConfiguredReusableCell(using: cellRegistration,
                                                         for: indexPath,
                                                         item: cellViewModel)
        }
    }
}

// MARK: - UICollectionViewDelegate

extension FavoritePicturesFilterCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.collectionViewController(self, didSelectItemAt: indexPath)
    }
}
